package app.view
{
	import app.ApplicationFacade;
	import app.model.IconsProxy;
	import app.model.vo.ConfigVO;
	import app.model.vo.TrafficInfoVO;
	import app.view.components.ImageTraffic;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Image;
	import mx.core.DragSource;
	import mx.managers.DragManager;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class ImageTrafficMediator extends Mediator implements IMediator
	{
		public function ImageTrafficMediator(mediatorName:String=null, viewComponent:Object=null)
		{
			super(mediatorName, viewComponent);
						
			imageTraffic.addEventListener(MouseEvent.CLICK,onClick);
			
			if(ConfigVO.EDIT)
			{
				imageTraffic.addEventListener(MouseEvent.MOUSE_MOVE,onDragStart);
			}
			
			var iconsProxy:IconsProxy = facade.retrieveProxy(IconsProxy.NAME) as IconsProxy;
			imageTraffic.source = iconsProxy.icons.IconTraffic;
		}
		
		protected function get imageTraffic():ImageTraffic
		{
			return viewComponent as ImageTraffic;
		}
		
		private function onClick(event:Event):void
		{				
			sendNotification(ApplicationFacade.NOTIFY_TITLEWINDOW_TRAFFIC,imageTraffic.trafficInfo);
		}
		
		private function onDragStart(e:MouseEvent):void
		{						
			var imageProxy:Image = new Image;
			imageProxy.source = imageTraffic.source;
			
			var ds:DragSource = new DragSource();  
			ds.addData(imageTraffic.trafficInfo,"TrafficInfoVO");
			ds.addData(new Point(e.localX,e.localY),"StartPoint");
			DragManager.doDrag(imageTraffic,ds,e,imageProxy); 
		}
	}
}