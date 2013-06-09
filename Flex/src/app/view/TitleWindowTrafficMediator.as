package app.view
{
	import app.ApplicationFacade;
	import app.model.vo.TrafficInfoVO;
	import app.view.components.TitleWindowTraffic;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	import mx.managers.PopUpManager;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class TitleWindowTrafficMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "TitleWindowTrafficMediator";
		
		public function TitleWindowTrafficMediator()
		{
			super(NAME, new TitleWindowTraffic);
			
			titleWindowTraffic.addEventListener(Event.CLOSE,onClose);
		}
		
		protected function get titleWindowTraffic():TitleWindowTraffic
		{
			return viewComponent as TitleWindowTraffic;
		}
		
		private function onClose(event:Event):void
		{
			PopUpManager.removePopUp(titleWindowTraffic);
		}
						
		override public function listNotificationInterests():Array
		{
			return [
				ApplicationFacade.NOTIFY_TITLEWINDOW_TRAFFIC
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case ApplicationFacade.NOTIFY_TITLEWINDOW_TRAFFIC:
					titleWindowTraffic.Traffic = notification.getBody() as TrafficInfoVO;
					break;
			}
		}
	}
}