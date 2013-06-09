package app.view
{
	import app.ApplicationFacade;
	import app.view.components.ImageClosedHandle;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class ImageClosedHandleMediator extends Mediator implements IMediator
	{
		public function ImageClosedHandleMediator(mediatorName:String=null, viewComponent:Object=null)
		{
			super(mediatorName, viewComponent);
						
			imageClosedHandle.addEventListener(MouseEvent.CLICK,onClick);
		}
		
		protected function get imageClosedHandle():ImageClosedHandle
		{
			return viewComponent as ImageClosedHandle;
		}
		
		private function onClick(event:Event):void
		{				
			sendNotification(ApplicationFacade.NOTIFY_TITLEWINDOW_CLOSED_IMGLST,imageClosedHandle.closedhandle);
		}
	}
}