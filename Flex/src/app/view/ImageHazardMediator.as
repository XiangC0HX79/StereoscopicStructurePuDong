package app.view
{
	import app.ApplicationFacade;
	import app.model.IconsProxy;
	import app.model.vo.ConfigVO;
	import app.model.vo.HazardVO;
	import app.model.vo.IconsVO;
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
		public static const NAME:String = "ImageHazardMediator";
		
		public function ImageHazardMediator(hz:HazardVO)
		{
			super(NAME + hz.T_HazardID, new ImageHazard);
						
			imageHazard.addEventListener(MouseEvent.CLICK,onClick);
			
			if(ConfigVO.EDIT)
			{
				imageHazard.addEventListener(MouseEvent.MOUSE_MOVE,onDragStart);
			}
						
			var iconsProxy:IconsProxy = facade.retrieveProxy(IconsProxy.NAME) as IconsProxy;
			if(hz.T_HazardType == 1)
			{
				imageHazard.source = iconsProxy.icons.IconEletric;
			}
			else if(hz.T_HazardType == 2)
			{
				imageHazard.source = iconsProxy.icons.IconGas;
			}
			else
			{
				imageHazard.source = iconsProxy.icons.IconCan;
			}
			
			imageHazard.hazard = hz;
		}
		
		protected function get imageHazard():ImageHazard
		{
			return viewComponent as ImageHazard;
		}
		
		private function onClick(event:Event):void
		{				
			sendNotification(ApplicationFacade.NOTIFY_TITLEWINDOW_HAZARD,imageHazard.hazard);
		}
		
		private function onDragStart(e:MouseEvent):void
		{						
			var imageProxy:Image = new Image;
			imageProxy.source = imageHazard.source;
			
			var ds:DragSource = new DragSource();  
			ds.addData(imageHazard.hazard,"HazardVO");
			ds.addData(new Point(e.localX,e.localY),"StartPoint");
			
			DragManager.doDrag(imageHazard,ds,e,imageProxy); 
		}
	}
}