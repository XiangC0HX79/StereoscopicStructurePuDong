package app.view
{
	import app.ApplicationFacade;
	import app.view.components.ImageCommandingHeight;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class ImageCommandHeightMediator extends Mediator implements IMediator
	{
		public function ImageCommandHeightMediator(mediatorName:String=null, viewComponent:Object=null)
		{
			super(mediatorName, viewComponent);
			
			imageKeyPoint.addEventListener(MouseEvent.ROLL_OVER,onOver);
			imageKeyPoint.addEventListener(MouseEvent.ROLL_OUT,onOut);
			
			imageKeyPoint.addEventListener(MouseEvent.CLICK,onClick);
		}
		
		protected function get imageKeyPoint():ImageCommandingHeight
		{
			return viewComponent as ImageCommandingHeight;
		}
		
		private function onOver(event:Event):void
		{
			sendNotification(ApplicationFacade.NOTIFY_COMMAND_OVER,imageKeyPoint.commandingHeight);
		}
		
		private function onOut(event:Event):void
		{
			sendNotification(ApplicationFacade.NOTIFY_COMMAND_OUT);
		}
		
		private function onClick(event:Event):void
		{				
			sendNotification(ApplicationFacade.NOTIFY_TITLEWINDOW_COMMAND,imageKeyPoint.commandingHeight);
		}
	}
}