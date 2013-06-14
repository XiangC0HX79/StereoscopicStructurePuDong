package app.view
{
	import app.ApplicationFacade;
	import app.model.BuildProxy;
	import app.model.vo.BuildVO;
	import app.model.vo.ConfigVO;
	import app.model.vo.FireHydrantVO;
	import app.model.vo.KeyUnitVO;
	import app.model.vo.LayerVO;
	import app.view.components.MenuSurrounding;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	import mx.managers.CursorManager;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class MenuSurroundingMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "MenuSurroundingMediator";
				
		public function MenuSurroundingMediator()
		{
			super(NAME, new MenuSurrounding);
			
			menuSurrounding.addEventListener(Event.CHANGE,onChange);	
			
			menuSurrounding.addEventListener(MenuSurrounding.DEFAULT,onDefault);
			menuSurrounding.addEventListener(MenuSurrounding.SAVE,onSave);
			menuSurrounding.addEventListener(MenuSurrounding.FIREADD,onFireAdd);
			menuSurrounding.addEventListener(MenuSurrounding.FIREDEL,onFireDel);
		}
		
		protected function get menuSurrounding():MenuSurrounding
		{
			return viewComponent as MenuSurrounding;
		}
		
		private function onChange(event:Event):void
		{			
			event.stopImmediatePropagation();
			
			var layer:LayerVO = event.target.data as LayerVO;
			if(layer.LayerName == "救援信息")
			{
				sendNotification(ApplicationFacade.NOTIFY_TITLEWINDOW_RESCUE);
			}	
		}
				
		private function onDefault(event:Event):void
		{
			FireHydrantVO.Tool = FireHydrantVO.MOVE;
			CursorManager.removeAllCursors();
		}
		
		private function onSave(event:Event):void
		{
			var buildProxy:BuildProxy = facade.retrieveProxy(BuildProxy.NAME) as BuildProxy;
			buildProxy.SaveSurrouding();
		}
		
		private function onFireAdd(event:Event):void
		{
			FireHydrantVO.Tool = FireHydrantVO.ADD;
			
			LayerVO.FIRE.LayerVisible = true;
		}
		
		private function onFireDel(event:Event):void
		{
			FireHydrantVO.Tool = FireHydrantVO.DEL;
			
			LayerVO.FIRE.LayerVisible = true;
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
					if(ConfigVO.EDIT)
					{
						menuSurrounding.currentState = "Edit";
					}
					
					var build:BuildVO = notification.getBody() as BuildVO;					
													
					if(build.CommandingHeights.length > 0)
						menuSurrounding.dp.addItem(LayerVO.COMMANDHEIGHT);	
										
					if(build.CloseHandles.length > 0)
						menuSurrounding.dp.addItem(LayerVO.CLOSEHANDLE);		
					
					if(build.Traffic.length > 0)
						menuSurrounding.dp.addItem(LayerVO.TRAFFIC);		
					
					if(build.Hazzard.length > 0)
						menuSurrounding.dp.addItem(LayerVO.HAZARD);		
					
					if(build.T_RescueimgPath)
						menuSurrounding.dp.addItem(LayerVO.RESCUE);
					
					if((build.FireHydrant.length > 0) || ConfigVO.EDIT)
						menuSurrounding.dp.addItem(LayerVO.FIRE);
					
					if(build.KeyUnits.length > 0)
						menuSurrounding.dp.addItem(LayerVO.KEYUNITS);
					
					if(build.Scenting.length > 0)
						menuSurrounding.dp.addItem(LayerVO.SCENTING);
					break;
			}
		}
	}
}