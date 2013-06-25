package app.view
{
	import app.ApplicationFacade;
	import app.model.BuildProxy;
	import app.model.FloorPorxy;
	import app.model.vo.BuildVO;
	import app.model.vo.ConfigVO;
	import app.model.vo.FloorVO;
	import app.model.vo.LayerVO;
	import app.view.components.MenuStereoScopicStructure;
	
	import flash.events.Event;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class MenuStereoScopicStructureMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "MenuStereoScopicStructureMediator";
		
		public function MenuStereoScopicStructureMediator()
		{
			super(NAME, new MenuStereoScopicStructure);			
			
			menuStereoScopicStructure.addEventListener(Event.CHANGE,onChange);			
		}
		
		protected function get menuStereoScopicStructure():MenuStereoScopicStructure
		{
			return viewComponent as MenuStereoScopicStructure;
		}
		
		private function onChange(event:Event):void
		{
			event.stopImmediatePropagation();
			
			sendNotification(ApplicationFacade.NOTIFY_STEREO_LAYER);
			
			sendNotification(ApplicationFacade.NOTIFY_SHOW_INFO,false);	
			
			var floorPorxy:FloorPorxy = facade.retrieveProxy(FloorPorxy.NAME) as FloorPorxy;
			
			var layer:LayerVO = event.target.data as LayerVO;
			
			if(!floorPorxy.hasFloorDetail(layer))
				sendNotification(ApplicationFacade.NOTIFY_SHOW_INFO,layer.LayerVisible);
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
					menuStereoScopicStructure.dp.addItem(LayerVO.EMERGENCYROUTE);
					menuStereoScopicStructure.dp.addItem(LayerVO.CONTROLROOM);
					menuStereoScopicStructure.dp.addItem(LayerVO.MONITOR);
					menuStereoScopicStructure.dp.addItem(LayerVO.ELEVATOR);
					menuStereoScopicStructure.dp.addItem(LayerVO.OTHERKEY);
					break;
			}
		}
	}
}