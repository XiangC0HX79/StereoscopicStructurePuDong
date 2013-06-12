package app.view
{
	import app.ApplicationFacade;
	import app.model.BuildProxy;
	import app.model.vo.BuildVO;
	import app.model.vo.KeyUnitVO;
	import app.view.components.TitleWindowTatics;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	import mx.managers.PopUpManager;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class TitleWindowTaticsMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "TitleWindowTaticsMediator";
		
		public function TitleWindowTaticsMediator()
		{
			super(NAME, new TitleWindowTatics);
			
			titleWindowTatics.addEventListener(Event.CLOSE,onClose);
			
			titleWindowTatics.addEventListener(TitleWindowTatics.COMMUNICATE,onCommunicate);
			titleWindowTatics.addEventListener(TitleWindowTatics.CABLEDROP,onCableDrop);
			titleWindowTatics.addEventListener(TitleWindowTatics.LANDING,onLanding);
			titleWindowTatics.addEventListener(TitleWindowTatics.WINDOWS,onWindows);
			titleWindowTatics.addEventListener(TitleWindowTatics.INTERNALHIGH,onInternalHigh);
		}
		
		protected function get titleWindowTatics():TitleWindowTatics
		{
			return viewComponent as TitleWindowTatics;
		}
		
		private function onClose(event:Event):void
		{
			PopUpManager.removePopUp(titleWindowTatics);
		}
					
		private function onCommunicate(event:Event):void
		{
			sendNotification(ApplicationFacade.NOTIFY_TITLEWINDOW_TATICALPOINT,titleWindowTatics.Build.Communicate);
		}
		
		private function onCableDrop(event:Event):void
		{
			sendNotification(ApplicationFacade.NOTIFY_TITLEWINDOW_TATICALPOINT,titleWindowTatics.Build.Cabledrop);
		}
		
		private function onLanding(event:Event):void
		{
			sendNotification(ApplicationFacade.NOTIFY_TITLEWINDOW_TATICALPOINT,titleWindowTatics.Build.Landing);
		}
		
		private function onWindows(event:Event):void
		{
			sendNotification(ApplicationFacade.NOTIFY_TITLEWINDOW_TATICALPOINT,titleWindowTatics.Build.Windows);
		}
		
		private function onInternalHigh(event:Event):void
		{
			sendNotification(ApplicationFacade.NOTIFY_TITLEWINDOW_TATICALPOINT,titleWindowTatics.Build.Internalhigh);
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				ApplicationFacade.NOTIFY_INIT_APP
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case ApplicationFacade.NOTIFY_INIT_APP:
					titleWindowTatics.Build = notification.getBody() as BuildVO;
					break;
			}
		}
	}
}