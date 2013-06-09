package app.view
{
	import app.ApplicationFacade;
	import app.controller.WebServiceCommand;
	import app.model.BuildProxy;
	import app.model.vo.ComponentVO;
	import app.model.vo.FloorVO;
	import app.view.components.ImageComponent;
	import app.view.components.TitleWindowFloor;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	
	import mx.collections.ArrayCollection;
	import mx.core.IFlexDisplayObject;
	import mx.events.CloseEvent;
	import mx.events.FlexEvent;
	import mx.managers.PopUpManager;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import spark.components.Image;
	import spark.components.TitleWindow;
	
	public class TitleWindowFloorMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "TitleWindowFloorMediator";
		
		public function TitleWindowFloorMediator()
		{
			super(NAME, new TitleWindowFloor);
			
			titleWindowFloor.addEventListener(FlexEvent.CREATION_COMPLETE,onCreation);
			titleWindowFloor.addEventListener(TitleWindowFloor.WIN_CLOSE,onClose);
		}
		
		protected function get titleWindowFloor():TitleWindowFloor
		{
			return viewComponent as TitleWindowFloor;
		}
		
		private function onCreation(event:FlexEvent):void
		{
			var buildProxy:BuildProxy = facade.retrieveProxy(BuildProxy.NAME) as BuildProxy;
			for each(var component:ComponentVO in titleWindowFloor.floor.components)
			{
				var imageComponent:ImageComponent = new ImageComponent;
				imageComponent.component = component;
				
				facade.registerMediator(new ImageComponentMediator("ImageComponentMediator" + component.componentID,imageComponent));
								
				titleWindowFloor.groupComponent.addElement(imageComponent);
			}
			
			titleWindowFloor.initScales();
		}
		
		private function onClose(event:Event):void
		{
			for each(var component:ComponentVO in titleWindowFloor.floor.components)
			{
				facade.removeMediator("ImageComponentMediator" + component.componentID);
			}
			
			titleWindowFloor.groupComponent.removeAllElements();
			
			PopUpManager.removePopUp(titleWindowFloor);
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				ApplicationFacade.NOTIFY_TITLEWINDOW_FLOOR
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case ApplicationFacade.NOTIFY_TITLEWINDOW_FLOOR:
					titleWindowFloor.floor = notification.getBody() as FloorVO;
					
					if(titleWindowFloor.initialized)
					{
						onCreation(null);
					}
					break;
			}
		}
	}
}