package app.view
{
	import app.ApplicationFacade;
	import app.model.IconsProxy;
	import app.model.vo.ConfigVO;
	import app.model.vo.ScentingVO;
	import app.view.components.ImageScenting;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.collections.ArrayCollection;
	import mx.core.DragSource;
	import mx.managers.DragManager;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import spark.components.Image;
	
	public class ImageScentingMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "ImageScentingMediator";
		
		public function ImageScentingMediator(sc:ScentingVO)
		{
			super(NAME + sc.T_ScentingID, new ImageScenting);
						
			imageScenting.addEventListener(MouseEvent.CLICK,onClick);
			
			if(ConfigVO.EDIT)
			{
				imageScenting.addEventListener(MouseEvent.MOUSE_MOVE,onDragStart);
			}
			
			var iconsProxy:IconsProxy = facade.retrieveProxy(IconsProxy.NAME) as IconsProxy;
			imageScenting.source = iconsProxy.icons.IconScenting;
			
			imageScenting.scenting = sc;
		}
		
		protected function get imageScenting():ImageScenting
		{
			return viewComponent as ImageScenting;
		}
		
		private function onClick(event:Event):void
		{				
			sendNotification(ApplicationFacade.NOTIFY_TITLEWINDOW_SCENTING,imageScenting.scenting);
		}
		
		private function onDragStart(e:MouseEvent):void
		{						
			var imageProxy:Image = new Image;
			imageProxy.source = imageScenting.source;
			
			var ds:DragSource = new DragSource();  
			ds.addData(imageScenting.scenting,"ScentingVO");
			ds.addData(new Point(e.localX,e.localY),"StartPoint");
			DragManager.doDrag(imageScenting,ds,e,imageProxy); 
		}
	}
}