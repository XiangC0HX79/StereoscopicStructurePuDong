package app.view
{
	import app.ApplicationFacade;
	import app.model.BuildProxy;
	import app.model.vo.FloorDetailVO;
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
	import mx.core.IVisualElement;
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
			
			titleWindowFloor.createDeferredContent();
			
			titleWindowFloor.addEventListener(Event.CLOSE,onClose);
		}
		
		protected function get titleWindowFloor():TitleWindowFloor
		{
			return viewComponent as TitleWindowFloor;
		}
				
		private function onClose(event:Event):void
		{
			for each(var component:FloorDetailVO in titleWindowFloor.floor.floorDetails)
			{
				var mediator:ImageComponentMediator = facade.retrieveMediator(ImageComponentMediator.NAME + component.T_FloorDetailID) as ImageComponentMediator;
				
				titleWindowFloor.groupFloor.removeElement(mediator.getViewComponent() as IVisualElement);
				
				facade.removeMediator(mediator.getMediatorName());
			}
			
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
										
					titleWindowFloor.initScales();
					
					for each(var component:FloorDetailVO in titleWindowFloor.floor.floorDetails)
					{
						var c:ImageComponentMediator = new ImageComponentMediator(component);
						
						facade.registerMediator(c);
						
						titleWindowFloor.groupFloor.addElement(c.getViewComponent() as IVisualElement);
					}
					break;
			}
		}
	}
}