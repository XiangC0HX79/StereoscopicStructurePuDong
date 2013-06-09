package app.view
{
	import app.ApplicationFacade;
	import app.model.vo.HazardVO;
	import app.model.vo.ScentingVO;
	import app.view.components.TitleWindowHazard;
	import app.view.components.TitleWindowScenting;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	import mx.managers.PopUpManager;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class TitleWindowHazardMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "TitleWindowHazardMediator";
		
		public function TitleWindowHazardMediator()
		{
			super(NAME, new TitleWindowHazard);
			
			titleWindowHazard.addEventListener(Event.CLOSE,onClose);
		}
		
		protected function get titleWindowHazard():TitleWindowHazard
		{
			return viewComponent as TitleWindowHazard;
		}
		
		private function onClose(event:Event):void
		{
			PopUpManager.removePopUp(titleWindowHazard);
		}
						
		override public function listNotificationInterests():Array
		{
			return [
				ApplicationFacade.NOTIFY_TITLEWINDOW_HAZARD
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case ApplicationFacade.NOTIFY_TITLEWINDOW_HAZARD:
					titleWindowHazard.Hazard = notification.getBody() as HazardVO;
					break;
			}
		}
	}
}