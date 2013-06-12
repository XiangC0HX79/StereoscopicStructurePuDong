package app.view
{
	import app.ApplicationFacade;
	import app.model.IconsProxy;
	import app.model.vo.ConfigVO;
	import app.view.components.ImageKeyUnit;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Image;
	import mx.core.DragSource;
	import mx.managers.DragManager;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class ImageKeyUnitMediator extends Mediator implements IMediator
	{
		public function ImageKeyUnitMediator(mediatorName:String=null, viewComponent:Object=null)
		{
			super(mediatorName, viewComponent);
						
			imageKeyUnit.addEventListener(MouseEvent.CLICK,onClick);
			
			if(ConfigVO.EDIT)
			{
				imageKeyUnit.addEventListener(MouseEvent.MOUSE_MOVE,onDragStart);
			}
			
			var iconsProxy:IconsProxy = facade.retrieveProxy(IconsProxy.NAME) as IconsProxy;
			imageKeyUnit.source = iconsProxy.icons.IconKeyUnit;
		}
		
		protected function get imageKeyUnit():ImageKeyUnit
		{
			return viewComponent as ImageKeyUnit;
		}
		
		private function onClick(event:Event):void
		{				
			sendNotification(ApplicationFacade.NOTIFY_TITLEWINDOW_KEYUNIT,imageKeyUnit.keyUnit);
		}
		
		private function onDragStart(e:MouseEvent):void
		{						
			var imageProxy:Image = new Image;
			imageProxy.source = imageKeyUnit.source;
			
			var ds:DragSource = new DragSource();  
			ds.addData(imageKeyUnit.keyUnit,"KeyUnitVO");
			ds.addData(new Point(e.localX,e.localY),"StartPoint");
			DragManager.doDrag(imageKeyUnit,ds,e,imageProxy); 
		}
	}
}