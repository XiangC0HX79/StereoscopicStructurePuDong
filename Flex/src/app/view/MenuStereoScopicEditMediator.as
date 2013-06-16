package app.view
{
	import app.ApplicationFacade;
	import app.model.FloorPorxy;
	import app.model.vo.BuildVO;
	import app.model.vo.ConfigVO;
	import app.model.vo.FloorVO;
	import app.model.vo.LayerVO;
	import app.view.components.MenuStereoScopicEdit;
	
	import com.adobe.utils.DictionaryUtil;
	
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import flash.utils.setTimeout;
	
	import mx.collections.ArrayCollection;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class MenuStereoScopicEditMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "MenuStereoScopicEditMediator";
		
		private var floorPorxy:FloorPorxy;
		
		public function MenuStereoScopicEditMediator()
		{
			super(NAME, new MenuStereoScopicEdit);			
			
			menuStereoScopicEdit.addEventListener(MenuStereoScopicEdit.FLOOR_CHANGE,onFloorChange);
			
			menuStereoScopicEdit.addEventListener(MenuStereoScopicEdit.FLOOR_SCALE,onFloorScale);
			menuStereoScopicEdit.addEventListener(MenuStereoScopicEdit.FLOOR_ALPHA,onFloorAlpha);
			menuStereoScopicEdit.addEventListener(MenuStereoScopicEdit.FLOOR_ROTATION,onFloorRotation);			
						
			menuStereoScopicEdit.addEventListener(MenuStereoScopicEdit.FLOOR_SAVE,onFloorSave);
			
			floorPorxy = facade.retrieveProxy(FloorPorxy.NAME) as FloorPorxy;
		}
		
		protected function get menuStereoScopicEdit():MenuStereoScopicEdit
		{
			return viewComponent as MenuStereoScopicEdit;
		}
		
		private var token:Object;
		private function onFloorScale(event:Event):void
		{		
			token = floorPorxy.LoadFloorBitmap(menuStereoScopicEdit.floor,onLoadFloorBitmap);
		}
		
		private function onLoadFloorBitmap(bitmap:Bitmap,t:Object):void
		{
			if(token != t)
				return;
			
			menuStereoScopicEdit.floor.floorBitmap = bitmap;	
			
			sendNotification(ApplicationFacade.NOTIFY_FLOOR_UPDATE,menuStereoScopicEdit.floor);
		}
				
		private function onFloorAlpha(event:Event):void
		{			
			sendNotification(ApplicationFacade.NOTIFY_FLOOR_UPDATE,menuStereoScopicEdit.floor);
		}
		
		private function onFloorChange(event:Event):void
		{
			var s:Number = Math.round(menuStereoScopicEdit.floor.floorBitmap.width / menuStereoScopicEdit.floor.T_BitmapWidth * 100) / 100;
			if(s != menuStereoScopicEdit.floor.T_FloorScale)
			{				
				token = floorPorxy.LoadFloorBitmap(menuStereoScopicEdit.floor,onLoadFloorBitmap);
			}
		}
				
		private function onFloorSave(event:Event):void
		{			
			floorPorxy.SaveFloors();
		}
		
		private function onFloorRotation(event:Event):void
		{		
			sendNotification(ApplicationFacade.NOTIFY_FLOOR_UPDATE,menuStereoScopicEdit.floor);
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				ApplicationFacade.NOTIFY_INIT_BUILD,
				ApplicationFacade.NOTIFY_INIT_FLOOR
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case ApplicationFacade.NOTIFY_INIT_BUILD:
					menuStereoScopicEdit.build = notification.getBody() as BuildVO;					
					break;
				
				case ApplicationFacade.NOTIFY_INIT_FLOOR:
					menuStereoScopicEdit.floors = new ArrayCollection(DictionaryUtil.getValues((notification.getBody() as Dictionary)));
					break;
			}
		}
	}
}