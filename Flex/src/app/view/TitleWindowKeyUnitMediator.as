package app.view
{
	import app.ApplicationFacade;
	import app.model.vo.KeyUnitVO;
	import app.view.components.TitleWindowKeyUnit;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	import mx.managers.PopUpManager;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class TitleWindowKeyUnitMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "TitleWindowKeyUnitMediator";
		
		public function TitleWindowKeyUnitMediator()
		{
			super(NAME, new TitleWindowKeyUnit);
			
			titleWindowKeyUnit.addEventListener(Event.CLOSE,onClose);
		}
		
		protected function get titleWindowKeyUnit():TitleWindowKeyUnit
		{
			return viewComponent as TitleWindowKeyUnit;
		}
		
		private function onClose(event:Event):void
		{
			PopUpManager.removePopUp(titleWindowKeyUnit);
		}
						
		override public function listNotificationInterests():Array
		{
			return [
				ApplicationFacade.NOTIFY_TITLEWINDOW_KEYUNIT
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case ApplicationFacade.NOTIFY_TITLEWINDOW_KEYUNIT:
					titleWindowKeyUnit.keyUnit = notification.getBody() as KeyUnitVO;
					break;
			}
		}
	}
}