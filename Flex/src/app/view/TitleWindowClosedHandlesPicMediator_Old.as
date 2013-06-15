package app.view
{
	import app.ApplicationFacade;
	import app.model.vo.ClosedHandlePicVO;
	import app.model.vo.ClosedHandleVO;
	import app.model.vo.CommandHeightVO;
	import app.view.components.TitleWindowClosedHandlesPic;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	import mx.managers.PopUpManager;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class TitleWindowClosedHandlesPicMediator_Old extends Mediator implements IMediator
	{
		public static const NAME:String = "TitleWindowClosedHandlesPicMediator";
		
		public function TitleWindowClosedHandlesPicMediator_Old()
		{
			super(NAME, new TitleWindowClosedHandlesPic);
		}
				
		protected function get titleWindowClosedHandlesPic():TitleWindowClosedHandlesPic
		{
			return viewComponent as TitleWindowClosedHandlesPic;
		}
				
		override public function listNotificationInterests():Array
		{
			return [
				ApplicationFacade.NOTIFY_TITLEWINDOW_CLOSED_IMGLST
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case ApplicationFacade.NOTIFY_TITLEWINDOW_CLOSED_IMGLST:
					titleWindowClosedHandlesPic.CloseHandelPics = notification.getBody() as ArrayCollection; 
					break;
			}
		}
	}
}