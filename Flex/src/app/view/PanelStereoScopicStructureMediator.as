package app.view
{
	import app.ApplicationFacade;
	import app.model.BuildProxy;
	import app.model.FloorPorxy;
	import app.model.vo.BuildVO;
	import app.model.vo.FloorVO;
	import app.view.components.ImageFloor;
	import app.view.components.PanelStereoScopicStructure;
	
	import com.adobe.utils.DictionaryUtil;
	
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class PanelStereoScopicStructureMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "PanelStereoScopicStructureMediator";
				
		public function PanelStereoScopicStructureMediator()
		{
			super(NAME, new PanelStereoScopicStructure);
			
			panelStereoScopicStructure.addEventListener(PanelStereoScopicStructure.GROUPMOVE,onGroupMove);
			panelStereoScopicStructure.addEventListener(PanelStereoScopicStructure.GROUPOUT,onGroupOut);			
		}
		
		protected function get panelStereoScopicStructure():PanelStereoScopicStructure
		{
			return viewComponent as PanelStereoScopicStructure;
		}
	
		private function onGroupMove(event:Event):void
		{
			//var buildProxy:BuildProxy = facade.retrieveProxy(BuildProxy.NAME) as BuildProxy;
			var floorPorxy:FloorPorxy = facade.retrieveProxy(FloorPorxy.NAME) as FloorPorxy;
			
			var floorFocus:ImageFloor;
						
			for each(var floor:FloorVO in floorPorxy.dict)
			{
				var imageFloorMediator:ImageFloorMediator = facade.retrieveMediator("ImageFloorMediator" + floor.T_FloorID) as ImageFloorMediator;
				var imageFloor:ImageFloor = imageFloorMediator.getViewComponent() as ImageFloor;
				
				var rect:Rectangle = new Rectangle(imageFloor.x,imageFloor.y,imageFloor.width * imageFloor.scaleX,imageFloor.height * imageFloor.scaleY);
				if(rect.containsPoint(panelStereoScopicStructure.MousePoint))
				{					
					var ptPixel:Point = imageFloor.globalToLocal(panelStereoScopicStructure.localToGlobal(panelStereoScopicStructure.MousePoint));
					var alpha:Number = (imageFloor.source as BitmapData).getPixel32(ptPixel.x,ptPixel.y);
					
					if(alpha != 0)
					{
						floorFocus = imageFloor;						
						break;
					}
				}
			}
			
			var floors:ArrayCollection = new ArrayCollection(DictionaryUtil.getValues(floorPorxy.dict));
			
			var floorTop:ImageFloor = panelStereoScopicStructure.getElementAt(floors.length) as ImageFloor;
			
			if(floorTop != floorFocus)
			{
				var index:Number = floors.getItemIndex(floorTop.floor);
				if(index != 0)
				{
					panelStereoScopicStructure.setElementIndex(floorTop,floors.length - index);
				}		
				
				if(floorFocus)
				{
					panelStereoScopicStructure.setElementIndex(floorFocus,floors.length);
				}
			}
			
			sendNotification(ApplicationFacade.NOTIFY_FLOOR_FOCUS,floorFocus?floorFocus.floor:null);
		}
		
		private function onGroupOut(event:Event):void
		{			
			sendNotification(ApplicationFacade.NOTIFY_FLOOR_FOCUS,null);
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
					panelStereoScopicStructure.Build = notification.getBody() as BuildVO;	
					break;
				
				case ApplicationFacade.NOTIFY_INIT_FLOOR:				
					var floors:ArrayCollection = new ArrayCollection(DictionaryUtil.getValues((notification.getBody() as Dictionary)));
					
					for(var i:Number = floors.length - 1;i >=0;i--)
					{
						var floor:FloorVO = floors[i];
						
						var imageFloor:ImageFloor = new ImageFloor;
						imageFloor.floor = floor;
						
						facade.registerMediator(new ImageFloorMediator("ImageFloorMediator" + floor.T_FloorID,imageFloor));
						
						panelStereoScopicStructure.addElement(imageFloor);
					}
					break;
			}
		}
	}
}