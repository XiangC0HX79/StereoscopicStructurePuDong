package app.view
{
	import app.ApplicationFacade;
	import app.view.components.TitleWindowMedia;
	
	import flash.utils.Dictionary;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class TitleWindowMediaMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "TitleWindowMediaMediator";
		
		public function TitleWindowMediaMediator()
		{
			super(NAME, new TitleWindowMedia);
		}
		
		protected function get titleWindowMedia():TitleWindowMedia
		{
			return viewComponent as TitleWindowMedia;
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				ApplicationFacade.NOTIFY_TITLEWINDOW_MEDIA
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case ApplicationFacade.NOTIFY_TITLEWINDOW_MEDIA:					
					titleWindowMedia.medias = notification.getBody() as Dictionary;	
					break;
			}
		}
	}
}