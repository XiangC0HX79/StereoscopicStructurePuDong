package app.view
{
	import app.ApplicationFacade;
	import app.model.PassageProxy;
	import app.model.vo.ConfigVO;
	import app.view.components.MenuPassage;
	
	import flash.events.Event;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class MenuPassageMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "MenuPassageMediator";
		
		public function MenuPassageMediator()
		{
			super(NAME, new MenuPassage);
			
			menuPassage.addEventListener(MenuPassage.PLAN,onPlan);			
			menuPassage.addEventListener(MenuPassage.UNDERGROUND,onUnderGround);		
			menuPassage.addEventListener(MenuPassage.GROUND,onGround);		
			menuPassage.addEventListener(MenuPassage.TOPFLOOR,onTopFloor);		
			menuPassage.addEventListener(MenuPassage.FRESHAIR,onFreshAir);		
			menuPassage.addEventListener(MenuPassage.SPECIAL,onSpecail);
		}
		
		protected function get menuPassage():MenuPassage
		{
			return viewComponent as MenuPassage;
		}
		
		private function onPlan(event:Event):void
		{
			sendNotification(ApplicationFacade.NOTIFY_MENU_PASSAGE_PLAN);
		}
		
		private function onUnderGround(event:Event):void
		{
			sendNotification(ApplicationFacade.NOTIFY_MENU_PASSAGE_UNDERGROUND);
		}
		
		private function onGround(event:Event):void
		{
			sendNotification(ApplicationFacade.NOTIFY_MENU_PASSAGE_GROUND);
		}
		
		private function onTopFloor(event:Event):void
		{
			sendNotification(ApplicationFacade.NOTIFY_MENU_PASSAGE_TOPFLOOR);
		}
		
		private function onFreshAir(event:Event):void
		{
			sendNotification(ApplicationFacade.NOTIFY_MENU_PASSAGE_FRESHAIR);
		}
		
		private function onSpecail(event:Event):void
		{
			sendNotification(ApplicationFacade.NOTIFY_MENU_PASSAGE_SPECIAL);
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				ApplicationFacade.NOTIFY_INIT_PASSAGE
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case ApplicationFacade.NOTIFY_INIT_PASSAGE:
					if(ConfigVO.EDIT)
					{
						menuPassage.currentState = "Edit";
					}
					
					var passageProxy:PassageProxy = facade.retrieveProxy(PassageProxy.NAME) as PassageProxy;
					menuPassage.dp.addItem(MenuPassage.PLAN);
						
					if(passageProxy.ArrUnderGround.length > 0)
						menuPassage.dp.addItem(MenuPassage.UNDERGROUND);
					if(passageProxy.ArrGround.length > 0)
						menuPassage.dp.addItem(MenuPassage.GROUND);
					if(passageProxy.ArrTopFloor.length > 0)
						menuPassage.dp.addItem(MenuPassage.TOPFLOOR);
					if(passageProxy.ArrFreshAir.length > 0)
						menuPassage.dp.addItem(MenuPassage.FRESHAIR);
					if(passageProxy.ArrSpecial.length > 0)
						menuPassage.dp.addItem(MenuPassage.SPECIAL);
					
					sendNotification(ApplicationFacade.NOTIFY_MENU_PASSAGE_PLAN);
					break;
			}
		}
	}
}