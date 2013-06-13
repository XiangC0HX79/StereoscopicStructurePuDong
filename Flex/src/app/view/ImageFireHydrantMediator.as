package app.view
{
	import app.model.BuildProxy;
	import app.model.IconsProxy;
	import app.model.vo.ConfigVO;
	import app.model.vo.FireHydrantVO;
	import app.view.components.ImageFireHydrant;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.controls.Image;
	import mx.core.DragSource;
	import mx.managers.CursorManager;
	import mx.managers.DragManager;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class ImageFireHydrantMediator extends Mediator implements IMediator
	{
		public function ImageFireHydrantMediator(mediatorName:String=null, viewComponent:Object=null)
		{
			super(mediatorName, viewComponent);
			
			imageFireHydrant.addEventListener(MouseEvent.CLICK,onClick);
			
			if(ConfigVO.EDIT)
			{
				imageFireHydrant.addEventListener(MouseEvent.MOUSE_MOVE,onDragStart);
			}
			
			var iconsProxy:IconsProxy = facade.retrieveProxy(IconsProxy.NAME) as IconsProxy;
			imageFireHydrant.source = iconsProxy.icons.IconFireHydrant;
		}
		
		protected function get imageFireHydrant():ImageFireHydrant
		{
			return viewComponent as ImageFireHydrant;
		}	
		
		private function onClick(event:Event):void
		{
			if(FireHydrantVO.Tool == FireHydrantVO.DEL)
			{
				var buildProxy:BuildProxy = facade.retrieveProxy(BuildProxy.NAME) as BuildProxy;
				buildProxy.DelFireHydrant(imageFireHydrant.FireHydrant);
			}
		}
		
		private function onDragStart(e:MouseEvent):void
		{						
			var imageProxy:Image = new Image;
			imageProxy.source = imageFireHydrant.source;
			
			var ds:DragSource = new DragSource();  
			ds.addData(imageFireHydrant.FireHydrant,"FireHydrantVO");
			ds.addData(new Point(e.localX,e.localY),"StartPoint");
			DragManager.doDrag(imageFireHydrant,ds,e,imageProxy); 
		}	
	}
}