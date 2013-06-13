package app.view
{
	import app.ApplicationFacade;
	import app.model.IconsProxy;
	import app.model.vo.BuildVO;
	import app.model.vo.CommandHeightVO;
	import app.model.vo.ConfigVO;
	import app.view.components.ImageCommandingHeight;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Image;
	import mx.core.DragSource;
	import mx.managers.DragManager;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class ImageCommandHeightMediator extends Mediator implements IMediator
	{
		public function ImageCommandHeightMediator(mediatorName:String=null, viewComponent:Object=null)
		{
			super(mediatorName, viewComponent);
			
			imageCommandingHeight.addEventListener(MouseEvent.ROLL_OVER,onOver);
			imageCommandingHeight.addEventListener(MouseEvent.ROLL_OUT,onOut);
			
			imageCommandingHeight.addEventListener(MouseEvent.CLICK,onClick);
			
			if(ConfigVO.EDIT)
			{
				imageCommandingHeight.addEventListener(MouseEvent.MOUSE_MOVE,onDragStart);
			}
						
			var iconsProxy:IconsProxy = facade.retrieveProxy(IconsProxy.NAME) as IconsProxy;
			imageCommandingHeight.source = iconsProxy.icons.IconCommandHeight;
		}
		
		protected function get imageCommandingHeight():ImageCommandingHeight
		{
			return viewComponent as ImageCommandingHeight;
		}
		
		private function onOver(event:Event):void
		{
			sendNotification(ApplicationFacade.NOTIFY_COMMAND_OVER,imageCommandingHeight.commandingHeight);
		}
		
		private function onOut(event:Event):void
		{
			sendNotification(ApplicationFacade.NOTIFY_COMMAND_OUT);
		}
		
		private function onClick(event:Event):void
		{				
			sendNotification(ApplicationFacade.NOTIFY_TITLEWINDOW_COMMAND,imageCommandingHeight.commandingHeight);
		}
		
		private function onDragStart(e:MouseEvent):void
		{						
			var imageProxy:Image = new Image;
			imageProxy.source = imageCommandingHeight.source;
			
			var ds:DragSource = new DragSource();  
			ds.addData(imageCommandingHeight.commandingHeight,"CommandHeightVO");
			ds.addData(new Point(e.localX,e.localY),"StartPoint");
			DragManager.doDrag(imageCommandingHeight,ds,e,imageProxy); 
		}
	}
}