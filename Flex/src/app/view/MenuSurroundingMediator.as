package app.view
{
	import app.ApplicationFacade;
	import app.model.BuildProxy;
	import app.model.LayerSettingSurroundingProxy;
	import app.model.vo.BuildVO;
	import app.model.vo.KeyUnitVO;
	import app.model.vo.LayerVO;
	import app.view.components.MenuSub;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class MenuSurroundingMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "MenuSurroundingMediator";
				
		public function MenuSurroundingMediator()
		{
			super(NAME, new MenuSub);
			
			menuSurrounding.addEventListener(Event.CHANGE,onChange);	
		}
		
		protected function get menuSurrounding():MenuSub
		{
			return viewComponent as MenuSub;
		}
		
		private function onChange(event:Event):void
		{
			var buildProxy:BuildProxy = facade.retrieveProxy(BuildProxy.NAME) as BuildProxy;
			
			event.stopImmediatePropagation();
			
			var layer:LayerVO = event.target.data as LayerVO;
			if(layer.LayerName == "分控范围")
			{
				sendNotification(ApplicationFacade.NOTIFY_SURROUNDING_CLOSEDHANDDLES);
			}
			else if(layer.LayerName == "救援信息")
			{
				sendNotification(ApplicationFacade.NOTIFY_SURROUNDING_RESCUE,layer.LayerVisible);
			}
			else if(layer == LayerVO.KEYUNITS)
			{
			}			
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				ApplicationFacade.NOTIFY_APP_INIT
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case ApplicationFacade.NOTIFY_APP_INIT:
					var build:BuildVO = notification.getBody() as BuildVO;					
					
					var layerSettingSurroundingProxy:LayerSettingSurroundingProxy = facade.retrieveProxy(LayerSettingSurroundingProxy.NAME) as LayerSettingSurroundingProxy;
								
					if(build.CommandingHeights.length > 0)
						layerSettingSurroundingProxy.Layers.addItem(LayerVO.COMMANDHEIGHT);	
										
					if(build.CloseHandles.length > 0)
						layerSettingSurroundingProxy.Layers.addItem(LayerVO.CLOSEHANDLE);		
					
					if(build.Traffic.length > 0)
						layerSettingSurroundingProxy.Layers.addItem(LayerVO.TRAFFIC);		
					
					if(build.Hazzard.length > 0)
						layerSettingSurroundingProxy.Layers.addItem(LayerVO.HAZARD);		
					
					if(build.T_RescueimgPath)
						layerSettingSurroundingProxy.Layers.addItem(LayerVO.RESCUE);
					
					layerSettingSurroundingProxy.Layers.addItem(LayerVO.FIRE);
					
					if(build.KeyUnits.length > 0)
						layerSettingSurroundingProxy.Layers.addItem(LayerVO.KEYUNITS);
					
					if(build.Scenting.length > 0)
						layerSettingSurroundingProxy.Layers.addItem(LayerVO.SCENTING);
					
					menuSurrounding.dataProvider = layerSettingSurroundingProxy.Layers;	
					break;
			}
		}
	}
}