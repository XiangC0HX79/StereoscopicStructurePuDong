package app.view
{
	import app.ApplicationFacade;
	import app.model.vo.BuildVO;
	import app.model.vo.LayerVO;
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
			LayerVO.RESCUE.LayerVisible = false;
			
			PopUpManager.removePopUp(titleWindowRescueImg);
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				ApplicationFacade.NOTIFY_INIT_BUILD
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case ApplicationFacade.NOTIFY_INIT_BUILD:
					titleWindowRescueImg.T_RescueimgPath = (notification.getBody() as BuildVO).T_RescueimgPath;
					break;
			}
		}
	}
}