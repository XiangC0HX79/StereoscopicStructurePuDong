package app.view
{
	import app.ApplicationFacade;
	import app.model.BuildProxy;
	import app.model.LayerSettingStereoScopicProxy;
	import app.model.vo.BuildVO;
	import app.model.vo.ConfigVO;
	import app.model.vo.FloorVO;
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
			
			menuStereoScopicStructure.addEventListener(MenuStereoScopicStructure.FLOORCHANGE,onFloorChange);
			menuStereoScopicStructure.addEventListener(MenuStereoScopicStructure.FLOOROFFSET,onFloorOffset);
			menuStereoScopicStructure.addEventListener(MenuStereoScopicStructure.FLOORROTATION,onFloorRotation);			
			menuStereoScopicStructure.addEventListener(MenuStereoScopicStructure.FLOORSAVE,onFloorSave);
			
			var layerSettingStereoScopicProxy:LayerSettingStereoScopicProxy = facade.retrieveProxy(LayerSettingStereoScopicProxy.NAME) as LayerSettingStereoScopicProxy;
			menuStereoScopicStructure.dp = layerSettingStereoScopicProxy.Layers;
		}
		
		protected function get menuStereoScopicStructure():MenuStereoScopicStructure
		{
			return viewComponent as MenuStereoScopicStructure;
		}
		
		private function onChange(event:Event):void
		{
			event.stopImmediatePropagation();
			
			sendNotification(ApplicationFacade.NOTIFY_STEREO_LAYER);
		}
		private function onFloorChange(event:Event):void
		{
			var floor:FloorVO = menuStereoScopicStructure.listFloor.selectedItem as FloorVO;
			if(	(floor != null) 
				&&((floor.xOffset != 0)
					||(floor.yOffset != 0)
					||(floor.xRotation != 0)
					||(floor.yRotation != 0)
					||(floor.zRotation != 0)
					||(floor.alpha != 0.5)))
			{					
				menuStereoScopicStructure.scale = floor.scale;
				menuStereoScopicStructure.xOffset = floor.xOffset;
				menuStereoScopicStructure.yOffset = floor.yOffset;
				menuStereoScopicStructure.xRotation = floor.xRotation;
				menuStereoScopicStructure.yRotation = floor.yRotation;
				menuStereoScopicStructure.zRotation = floor.zRotation;
				menuStereoScopicStructure.floorAlpha = floor.alpha;
			}
		}
		
		private function onFloorOffset(event:Event):void
		{
			var floor:FloorVO = menuStereoScopicStructure.listFloor.selectedItem as FloorVO;
			if(floor != null) 
			{
				floor.edit = true;
				
				floor.scale = menuStereoScopicStructure.scale;
				floor.xOffset = menuStereoScopicStructure.xOffset;
				floor.yOffset = menuStereoScopicStructure.yOffset;
			}			
		}
		
		private function onFloorSave(event:Event):void
		{			
			var buildProxy:BuildProxy = facade.retrieveProxy(BuildProxy.NAME) as BuildProxy;
			buildProxy.SaveFloors();
		}
		
		private function onFloorRotation(event:Event):void
		{			
			var floor:FloorVO = menuStereoScopicStructure.listFloor.selectedItem as FloorVO;
			if(floor != null) 
			{
				floor.edit = true;
				
				sendNotification(ApplicationFacade.NOTIFY_FLOOR_ROTATION,floor);
			}
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
					menuStereoScopicStructure.build = notification.getBody() as BuildVO;
					
					if(ConfigVO.EDIT)
					{
						menuStereoScopicStructure.currentState = "Edit";
					}
					break;
			}
		}
	}
}