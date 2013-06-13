package app.view
{
	import app.ApplicationFacade;
	import app.model.vo.ConfigVO;
	import app.view.components.ImageHazard;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Image;
	import mx.core.DragSource;
	import mx.managers.DragManager;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class ImageHazardMediator extends Mediator implements IMediator
	{
		public function ImageHazardMediator(mediatorName:String=null, viewComponent:Object=null)
		{
			super(mediatorName, viewComponent);
						
			imageHazard.addEventListener(MouseEvent.CLICK,onClick);
			
			if(ConfigVO.EDIT)
			{
				imageHazard.addEventListener(MouseEvent.MOUSE_MOVE,onDragStart);
			}
		}
		
		protected function get imageHazard():ImageHazard
		{
			return viewComponent as ImageHazard;
		}
		
		private function onClick(event:Event):void
		{				
			sendNotification(ApplicationFacade.NOTIFY_TITLEWINDOW_HAZARD,imageHazard.Hazard);
		}
		
		private function onDragStart(e:MouseEvent):void
		{						
			var imageProxy:Image = new Image;
			imageProxy.source = imageHazard.source;
			
			var ds:DragSource = new DragSource();  
			ds.addData(imageHazard.Hazard,"HazardVO");
			ds.addData(new Point(e.localX,e.localY),"StartPoint");
			
			DragManager.doDrag(imageHazard,ds,e,imageProxy); 
		}
	}
}