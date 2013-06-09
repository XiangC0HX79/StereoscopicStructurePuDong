package app.view
{
	import app.ApplicationFacade;
	import app.model.vo.CommandHeightVO;
	import app.view.components.TitleWindowCommandHeightPic;
	
	import flash.events.Event;
	
	import mx.managers.PopUpManager;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class TitleWindowCommandHeightPicMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "TitleWindowCommandHeightPicMediator";
		
		public function TitleWindowCommandHeightPicMediator()
		{
			super(NAME, new TitleWindowCommandHeightPic);
			
			titleWindowCommandingHeightPic.addEventListener(Event.CLOSE,onClose);
		}
				
		protected function get titleWindowCommandingHeightPic():TitleWindowCommandHeightPic
		{
			return viewComponent as TitleWindowCommandHeightPic;
		}
		
		private function onClose(event:Event):void
		{
			PopUpManager.removePopUp(titleWindowCommandingHeightPic);
		}
				
		override public function listNotificationInterests():Array
		{
			return [
				ApplicationFacade.NOTIFY_TITLEWINDOW_COMMAND_IMGLST
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case ApplicationFacade.NOTIFY_TITLEWINDOW_COMMAND_IMGLST:
					titleWindowCommandingHeightPic.commandingHeight = notification.getBody() as CommandHeightVO;
					
					titleWindowCommandingHeightPic.ImageIndex = 0;
					break;
			}
		}
	}
}