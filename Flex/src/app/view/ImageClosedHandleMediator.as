package app.view
{
	import app.ApplicationFacade;
	import app.model.IconsProxy;
	import app.model.cosnt.PanelSurroundingTool;
	import app.model.vo.BuildVO;
	import app.model.vo.ClosedHandleVO;
	import app.model.vo.ConfigVO;
	import app.view.components.ImageClosedHandle;
	
	import com.adobe.utils.DictionaryUtil;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Image;
	import mx.core.DragSource;
	import mx.managers.DragManager;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class ImageClosedHandleMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "ImageClosedHandleMediator";
		
		public function ImageClosedHandleMediator(ch:ClosedHandleVO)
		{
			super(NAME + ch.T_ClosedhandlesID, new ImageClosedHandle);
				
			if(DictionaryUtil.getKeys(ch.pics).length > 0)
			{
				imageClosedHandle.buttonMode = true;
				imageClosedHandle.addEventListener(MouseEvent.CLICK,onClick);
			}
			
			if(ConfigVO.EDIT)
			{
				imageClosedHandle.addEventListener(MouseEvent.MOUSE_MOVE,onDragStart);
			}
			
			var iconsProxy:IconsProxy = facade.retrieveProxy(IconsProxy.NAME) as IconsProxy;
			imageClosedHandle.source = iconsProxy.icons.IconCloseHandle;
			
			imageClosedHandle.closedhandle = ch;
		}
		
		protected function get imageClosedHandle():ImageClosedHandle
		{
			return viewComponent as ImageClosedHandle;
		}
		
		private function onClick(event:Event):void
		{				
			if(PanelSurroundingTool.Tool == PanelSurroundingTool.MOVE)
			{
				sendNotification(ApplicationFacade.NOTIFY_TITLEWINDOW_MEDIA,imageClosedHandle.closedhandle.pics);
			}
		}
		
		private function onDragStart(e:MouseEvent):void
		{						
			var imageProxy:Image = new Image;
			imageProxy.source = imageClosedHandle.source;
			
			var ds:DragSource = new DragSource();  
			ds.addData(imageClosedHandle.closedhandle,"ClosedhandleVO");
			ds.addData(new Point(e.localX,e.localY),"StartPoint");
			DragManager.doDrag(imageClosedHandle,ds,e,imageProxy); 
		}
	}
}