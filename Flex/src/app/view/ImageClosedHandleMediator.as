package app.view
{
	import app.ApplicationFacade;
	import app.model.IconsProxy;
	import app.model.vo.BuildVO;
	import app.model.vo.ClosedhandleVO;
	import app.view.components.ImageClosedHandle;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Image;
	import mx.core.DragSource;
	import mx.managers.DragManager;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class ImageClosedHandleMediator extends Mediator implements IMediator
	{
		public function ImageClosedHandleMediator(mediatorName:String=null, viewComponent:Object=null)
		{
			super(mediatorName, viewComponent);
						
			if(imageClosedHandle.closedhandle.pics.length > 0)
			{
				imageClosedHandle.buttonMode = true;
				imageClosedHandle.addEventListener(MouseEvent.CLICK,onClick);
			}
			
			if(BuildVO.Edit)
			{
				imageClosedHandle.addEventListener(MouseEvent.MOUSE_MOVE,onDragStart);
			}
			
			var iconsProxy:IconsProxy = facade.retrieveProxy(IconsProxy.NAME) as IconsProxy;
			imageClosedHandle.source = iconsProxy.icons.IconCloseHandle.icon;
		}
		
		protected function get imageClosedHandle():ImageClosedHandle
		{
			return viewComponent as ImageClosedHandle;
		}
		
		private function onClick(event:Event):void
		{				
			sendNotification(ApplicationFacade.NOTIFY_TITLEWINDOW_CLOSED_IMGLST,imageClosedHandle.closedhandle.pics);
		}
		
		private function onDragStart(e:MouseEvent):void
		{						
			var imageProxy:Image = new Image;
			imageProxy.source = imageClosedHandle.source;
			
			var ds:DragSource = new DragSource();  
			ds.addData(imageClosedHandle.closedhandle,"ClosedhandleVO");
			DragManager.doDrag(imageClosedHandle,ds,e,imageProxy); 
		}
	}
}