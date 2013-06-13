package app.view
{
	import app.ApplicationFacade;
	import app.model.BuildProxy;
	import app.model.vo.BuildVO;
	import app.model.vo.ConfigVO;
	import app.model.vo.FloorVO;
	import app.model.vo.LayerVO;
	import app.view.components.MenuStereoScopicEdit;
	
	import flash.events.Event;
	import flash.utils.setTimeout;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class MenuStereoScopicEditMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "MenuStereoScopicEditMediator";
		
		public function MenuStereoScopicEditMediator()
		{
			super(NAME, new MenuStereoScopicEdit);			
			
			menuStereoScopicEdit.addEventListener(MenuStereoScopicEdit.FLOOR_CHANGE,onFloorChange);
			
			menuStereoScopicEdit.addEventListener(MenuStereoScopicEdit.FLOOR_SCALE,onFloorScale);
			menuStereoScopicEdit.addEventListener(MenuStereoScopicEdit.FLOOR_ALPHA,onFloorAlpha);
			menuStereoScopicEdit.addEventListener(MenuStereoScopicEdit.FLOOR_ROTATION,onFloorRotation);			
						
			menuStereoScopicEdit.addEventListener(MenuStereoScopicEdit.FLOOR_SAVE,onFloorSave);
		}
		
		protected function get menuStereoScopicEdit():MenuStereoScopicEdit
		{
			return viewComponent as MenuStereoScopicEdit;
		}
		
		private function onFloorScale(event:Event):void
		{			
			var buildProxy:BuildProxy = facade.retrieveProxy(BuildProxy.NAME) as BuildProxy;
			buildProxy.LoadFloorBitmap(menuStereoScopicEdit.floor,onLoadFloorBitmap);
						
			function onLoadFloorBitmap():void
			{
				sendNotification(ApplicationFacade.NOTIFY_FLOOR_UPDATE,menuStereoScopicEdit.floor);
			}
		}
				
		private function onFloorAlpha(event:Event):void
		{			
			sendNotification(ApplicationFacade.NOTIFY_FLOOR_UPDATE,menuStereoScopicEdit.floor);
		}
		
		private function onFloorChange(event:Event):void
		{
			var s:Number = Math.round(menuStereoScopicEdit.floor.floorBitmap.width / menuStereoScopicEdit.floor.BitmapWidth * 100) / 100;
			if(s != menuStereoScopicEdit.floor.T_FloorScale)
			{				
				var buildProxy:BuildProxy = facade.retrieveProxy(BuildProxy.NAME) as BuildProxy;
				buildProxy.LoadFloorBitmap(menuStereoScopicEdit.floor,onLoadFloorBitmap);
				
				function onLoadFloorBitmap():void
				{
					sendNotification(ApplicationFacade.NOTIFY_FLOOR_UPDATE,menuStereoScopicEdit.floor);
				}
			}
		}
				
		private function onFloorSave(event:Event):void
		{			
			var buildProxy:BuildProxy = facade.retrieveProxy(BuildProxy.NAME) as BuildProxy;
			buildProxy.SaveFloors();
		}
		
		private function onFloorRotation(event:Event):void
		{		
			sendNotification(ApplicationFacade.NOTIFY_FLOOR_UPDATE,menuStereoScopicEdit.floor);
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
					menuStereoScopicEdit.build = notification.getBody() as BuildVO;					
					break;
			}
		}
	}
}