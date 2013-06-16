package app.view
{
	import app.model.IconsProxy;
	import app.model.PassageProxy;
	import app.model.vo.ConfigVO;
	import app.model.vo.VideoVO;
	import app.view.components.ImageVideo;
	
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.controls.Image;
	import mx.core.DragSource;
	import mx.managers.DragManager;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class ImageVideoMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "ImageVideoMediator";
		
		public function ImageVideoMediator(v:VideoVO)
		{
			super(NAME + v.T_VideoID, new ImageVideo);
			
			imageVideo.addEventListener(MouseEvent.CLICK,onClick);
			
			if(ConfigVO.EDIT)
			{
				imageVideo.addEventListener(MouseEvent.MOUSE_MOVE,onDragStart);
			}
			
			var iconsProxy:IconsProxy = facade.retrieveProxy(IconsProxy.NAME) as IconsProxy;
			imageVideo.source = iconsProxy.icons.IconVideo;
			
			imageVideo.v = v;
		}
		
		protected function get imageVideo():ImageVideo
		{
			return viewComponent as ImageVideo;
		}	
		
		private function onClick(event:MouseEvent):void
		{
			if(VideoVO.Tool == VideoVO.DEL)
			{
				var passageProxy:PassageProxy = facade.retrieveProxy(PassageProxy.NAME) as PassageProxy;
				passageProxy.DelVideo(imageVideo.v);
			}
		}
		
		private function onDragStart(e:MouseEvent):void
		{						
			var imageProxy:Image = new Image;
			imageProxy.source = imageVideo.source;
			
			var ds:DragSource = new DragSource();  
			ds.addData(imageVideo.v,"VideoVO");
			ds.addData(new Point(e.localX,e.localY),"StartPoint");
			DragManager.doDrag(imageVideo,ds,e,imageProxy); 
		}	
	}
}