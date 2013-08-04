package app.view
{
	import app.ApplicationFacade;
	import app.model.vo.BuildVO;
	import app.model.vo.ConfigVO;
	import app.view.components.ImageBuilding;
	
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.controls.Image;
	import mx.core.DragSource;
	import mx.graphics.ImageSnapshot;
	import mx.managers.DragManager;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class ImageBuildingMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "ImageBuildingMediator";
		
		public function ImageBuildingMediator()
		{
			super(NAME, new ImageBuilding);
			
			imageBuilding.addEventListener(MouseEvent.CLICK,onMouseClick);
			
			imageBuilding.addEventListener(MouseEvent.MOUSE_MOVE,onDragStart);
		}
		
		protected function get imageBuilding():ImageBuilding
		{
			return viewComponent as ImageBuilding;
		}
				
		private function onMouseClick(event:Event):void
		{			
			sendNotification(ApplicationFacade.NOTIFY_TITLEWINDOW_MOVIE,imageBuilding.build.TMB_videoPath);
		}
		
		private function onDragStart(e:MouseEvent):void
		{					
			if(!ConfigVO.EDIT)
				return;
			
			var imageProxy:Image = new Image;			
			imageProxy.source = new Bitmap(ImageSnapshot.captureBitmapData(imageBuilding));
			
			var ds:DragSource = new DragSource();  
			ds.addData(imageBuilding.build,"BuildVO");
			ds.addData(new Point(e.localX,e.localY),"StartPoint");
			DragManager.doDrag(imageBuilding,ds,e,imageProxy); 
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				ApplicationFacade.NOTIFY_INIT_BUILD
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case ApplicationFacade.NOTIFY_INIT_BUILD:				
					imageBuilding.build = notification.getBody() as BuildVO;
					break;
			}
		}
	}
}