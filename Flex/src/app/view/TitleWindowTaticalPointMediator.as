package app.view
{
	import app.ApplicationFacade;
	import app.view.components.TitleWindowTaticalPoint;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	import mx.managers.PopUpManager;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class TitleWindowTaticalPointMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "TitleWindowTaticalPointMediator";
		
		public function TitleWindowTaticalPointMediator()
		{
			super(NAME, new TitleWindowTaticalPoint);
			
			titleWindowTaticalPoint.addEventListener(Event.CLOSE,onClose);
			
			titleWindowTaticalPoint.addEventListener(TitleWindowTaticalPoint.VIDEO,onVideo);
		}
		
		protected function get titleWindowTaticalPoint():TitleWindowTaticalPoint
		{
			return viewComponent as TitleWindowTaticalPoint;
		}
		
		private function onClose(event:Event):void
		{
			PopUpManager.removePopUp(titleWindowTaticalPoint);
		}
						
		private function onVideo(event:Event):void
		{
			sendNotification(ApplicationFacade.NOTIFY_TITLEWINDOW_MOVIE,titleWindowTaticalPoint.tatical.TP_VideoPath);
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				ApplicationFacade.NOTIFY_TITLEWINDOW_TATICALPOINT
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case ApplicationFacade.NOTIFY_TITLEWINDOW_TATICALPOINT:
					titleWindowTaticalPoint.Taticals = notification.getBody() as ArrayCollection;
					break;
			}
		}
	}
}