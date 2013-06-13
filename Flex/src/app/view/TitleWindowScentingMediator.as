package app.view
{
	import app.ApplicationFacade;
	import app.model.vo.ScentingVO;
	import app.view.components.TitleWindowScenting;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	import mx.managers.PopUpManager;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class TitleWindowScentingMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "TitleWindowScentingMediator";
		
		public function TitleWindowScentingMediator()
		{
			super(NAME, new TitleWindowScenting);
			
			titleWindowScenting.addEventListener(Event.CLOSE,onClose);
		}
		
		protected function get titleWindowScenting():TitleWindowScenting
		{
			return viewComponent as TitleWindowScenting;
		}
		
		private function onClose(event:Event):void
		{
			PopUpManager.removePopUp(titleWindowScenting);
		}
						
		override public function listNotificationInterests():Array
		{
			return [
				ApplicationFacade.NOTIFY_TITLEWINDOW_SCENTING
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case ApplicationFacade.NOTIFY_TITLEWINDOW_SCENTING:
					titleWindowScenting.Scenting = notification.getBody() as ScentingVO;
					break;
			}
		}
	}
}