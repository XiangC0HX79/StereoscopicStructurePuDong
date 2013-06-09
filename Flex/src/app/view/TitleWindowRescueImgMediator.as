package app.view
{
	import app.ApplicationFacade;
	import app.model.BuildProxy;
	import app.view.components.TitleWindowRescueImg;
	
	import flash.events.Event;
	
	import mx.managers.PopUpManager;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class TitleWindowRescueImgMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "TitleWindowRescueImgMediator";
		
		public function TitleWindowRescueImgMediator()
		{
			super(NAME, new TitleWindowRescueImg);
			
			titleWindowRescueImg.addEventListener(Event.CLOSE,onClose);
		}
		
		protected function get titleWindowRescueImg():TitleWindowRescueImg
		{
			return viewComponent as TitleWindowRescueImg;
		}
		
		private function onClose(event:Event):void
		{
			PopUpManager.removePopUp(titleWindowRescueImg);
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				ApplicationFacade.NOTIFY_APP_INIT,
				
				ApplicationFacade.NOTIFY_SURROUNDING_RESCUE
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case ApplicationFacade.NOTIFY_APP_INIT:
					var buildProxy:BuildProxy = facade.retrieveProxy(BuildProxy.NAME) as BuildProxy;
					titleWindowRescueImg.T_RescueimgPath = buildProxy.build.T_RescueimgPath;
					break;
				
				case ApplicationFacade.NOTIFY_SURROUNDING_RESCUE:
					if(notification.getBody())
					{
						sendNotification(ApplicationFacade.NOTIFY_TITLEWINDOW_RESCUE);
					}
					else
					{
						PopUpManager.removePopUp(titleWindowRescueImg);
					}
					break;
			}
		}
	}
}