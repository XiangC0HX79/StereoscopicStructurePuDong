package app.view
{
	import app.ApplicationFacade;
	import app.model.BuildProxy;
	import app.model.ClosedHandleProxy;
	import app.model.CommandHeightProxy;
	import app.model.FireHydrantProxy;
	import app.model.HazardProxy;
	import app.model.KeyUnitProxy;
	import app.model.ScentingProxy;
	import app.model.TrafficProxy;
	import app.model.vo.BuildVO;
	import app.model.vo.ConfigVO;
	import app.model.vo.FireHydrantVO;
	import app.model.vo.KeyUnitVO;
	import app.model.vo.LayerVO;
	import app.view.components.MenuSurrounding;
	
	import com.adobe.utils.DictionaryUtil;
	
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	import mx.managers.CursorManager;
	import mx.rpc.AsyncToken;
	import mx.rpc.CallResponder;
	import mx.rpc.events.ResultEvent;
	
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
			
			sendNotification(ApplicationFacade.NOTIFY_SHOW_INFO,false);				
			
			var layer:LayerVO = event.target.data as LayerVO;
			switch(layer)
			{
				case LayerVO.COMMANDHEIGHT:
					var commandHeightProxy:CommandHeightProxy = facade.retrieveProxy(CommandHeightProxy.NAME) as CommandHeightProxy;
					if(DictionaryUtil.getKeys(commandHeightProxy.dict).length <= 0)
						sendNotification(ApplicationFacade.NOTIFY_SHOW_INFO,layer.LayerVisible);	
					break;
				
				case LayerVO.CLOSEHANDLE:
					var closedHandleProxy:ClosedHandleProxy = facade.retrieveProxy(ClosedHandleProxy.NAME) as ClosedHandleProxy;
					if(DictionaryUtil.getKeys(closedHandleProxy.dict).length <= 0)
						sendNotification(ApplicationFacade.NOTIFY_SHOW_INFO,layer.LayerVisible);
					break;
				
				case LayerVO.TRAFFIC:
					var trafficProxy:TrafficProxy = facade.retrieveProxy(TrafficProxy.NAME) as TrafficProxy;
					if(DictionaryUtil.getKeys(trafficProxy.dict).length <= 0)
						sendNotification(ApplicationFacade.NOTIFY_SHOW_INFO,layer.LayerVisible);
					break;
				
				case LayerVO.HAZARD:
					var hazardProxy:HazardProxy = facade.retrieveProxy(HazardProxy.NAME) as HazardProxy;
					if(DictionaryUtil.getKeys(hazardProxy.dict).length <= 0)
						sendNotification(ApplicationFacade.NOTIFY_SHOW_INFO,layer.LayerVisible);
					break;
				
				case LayerVO.RESCUE:
					var buildProxy:BuildProxy = facade.retrieveProxy(BuildProxy.NAME) as BuildProxy;
					if(buildProxy.build.T_RescueimgPath)
						sendNotification(ApplicationFacade.NOTIFY_TITLEWINDOW_RESCUE);
					else
					sendNotification(ApplicationFacade.NOTIFY_SHOW_INFO,layer.LayerVisible);
					break;
				
				case LayerVO.FIRE:
					var fireHydrantProxy:FireHydrantProxy = facade.retrieveProxy(FireHydrantProxy.NAME) as FireHydrantProxy;
					if(DictionaryUtil.getKeys(fireHydrantProxy.dict).length <= 0)
						sendNotification(ApplicationFacade.NOTIFY_SHOW_INFO,layer.LayerVisible);
					break;
				
				case LayerVO.KEYUNITS:
					var keyUnitProxy:KeyUnitProxy = facade.retrieveProxy(KeyUnitProxy.NAME) as KeyUnitProxy;
					if(DictionaryUtil.getKeys(keyUnitProxy.dict).length <= 0)
						sendNotification(ApplicationFacade.NOTIFY_SHOW_INFO,layer.LayerVisible);
					break;
				
				case LayerVO.SCENTING:
					var scentingProxy:ScentingProxy = facade.retrieveProxy(ScentingProxy.NAME) as ScentingProxy;
					if(DictionaryUtil.getKeys(scentingProxy.dict).length <= 0)
						sendNotification(ApplicationFacade.NOTIFY_SHOW_INFO,layer.LayerVisible);
					break;
			}
		}
				
		private function onDefault(event:Event):void
		{
			FireHydrantVO.Tool = FireHydrantVO.MOVE;
			CursorManager.removeAllCursors();
		}
		
		private var _dictSave:Dictionary;
		private function onSave(event:Event):void
		{
			_dictSave = new Dictionary;
			
			var responder:CallResponder = new CallResponder;
			responder.addEventListener(ResultEvent.RESULT,onSaveListener);
			
			var commandHeightProxy:CommandHeightProxy = facade.retrieveProxy(CommandHeightProxy.NAME) as CommandHeightProxy;						
			var token:AsyncToken = commandHeightProxy.save();			
			token.addResponder(responder);			
			_dictSave[token] = false;
			
			var closedHandleProxy:ClosedHandleProxy = facade.retrieveProxy(ClosedHandleProxy.NAME) as ClosedHandleProxy;						
			token = closedHandleProxy.save();			
			token.addResponder(responder);			
			_dictSave[token] = false;
			
			var trafficProxy:TrafficProxy = facade.retrieveProxy(TrafficProxy.NAME) as TrafficProxy;						
			token = trafficProxy.save();			
			token.addResponder(responder);			
			_dictSave[token] = false;
			
			var hazardProxy:HazardProxy = facade.retrieveProxy(HazardProxy.NAME) as HazardProxy;						
			token = hazardProxy.save();			
			token.addResponder(responder);			
			_dictSave[token] = false;
			
			var fireHydrantProxy:FireHydrantProxy = facade.retrieveProxy(FireHydrantProxy.NAME) as FireHydrantProxy;						
			token = fireHydrantProxy.save();			
			token.addResponder(responder);			
			_dictSave[token] = false;
			
			var keyUnitProxy:KeyUnitProxy = facade.retrieveProxy(KeyUnitProxy.NAME) as KeyUnitProxy;						
			token = keyUnitProxy.save();			
			token.addResponder(responder);			
			_dictSave[token] = false;
			
			var scentingProxy:ScentingProxy = facade.retrieveProxy(ScentingProxy.NAME) as ScentingProxy;						
			token = scentingProxy.save();			
			token.addResponder(responder);			
			_dictSave[token] = false;
		}
		
		private function onSaveListener(event:ResultEvent):void
		{
			_dictSave[event.token] = true;
			
			for each(var b:Boolean in _dictSave)
			{
				if(!b)
					return;
			}
			
			sendNotification(ApplicationFacade.NOTIFY_APP_ALERTINFO,"周边环境信息保存成功。");
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
					
					menuSurrounding.dp.addItem(LayerVO.COMMANDHEIGHT);	
					menuSurrounding.dp.addItem(LayerVO.CLOSEHANDLE);						
					menuSurrounding.dp.addItem(LayerVO.TRAFFIC);	
					menuSurrounding.dp.addItem(LayerVO.HAZARD);						
					menuSurrounding.dp.addItem(LayerVO.RESCUE);					
					menuSurrounding.dp.addItem(LayerVO.FIRE);
					menuSurrounding.dp.addItem(LayerVO.KEYUNITS);
					menuSurrounding.dp.addItem(LayerVO.SCENTING);
					break;
			}
		}
	}
}