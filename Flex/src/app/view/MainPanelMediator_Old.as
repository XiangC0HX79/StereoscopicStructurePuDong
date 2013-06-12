package app.view
{
	import app.AppEvent;
	import app.ApplicationFacade;
	import app.model.BuildProxy;
	import app.model.vo.ComponentVO;
	import app.model.vo.FloorVO;
	import app.view.components.ImageFloor;
	import app.view.components.MainPanel;
	import app.view.components.TitleWindowFloor;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import mx.collections.ArrayCollection;
	import mx.events.FlexEvent;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import spark.components.Group;
	import spark.components.Image;
	import spark.components.TitleWindow;
	import spark.primitives.Rect;
	
	public class MainPanelMediator_Old extends Mediator implements IMediator
	{
		public static const NAME:String = "MainPanelMediator";
		
		private var buildProxy:BuildProxy;
		
		public function MainPanelMediator_Old(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
			
			mainPanel.addEventListener(MainPanel.FLOORCHANGE,onFloorChange);
			mainPanel.addEventListener(MainPanel.FLOOROFFSET,onFloorOffset);
			mainPanel.addEventListener(MainPanel.FLOORROTATION,onFloorRotation);
			
			mainPanel.addEventListener(MainPanel.FLOORSAVE,onFloorSave);
			
			mainPanel.addEventListener(MainPanel.MENUYJSX,onMenu);
			mainPanel.addEventListener(MainPanel.MENUZKS,onMenu);
			mainPanel.addEventListener(MainPanel.MENUJKZX,onMenu);
			mainPanel.addEventListener(MainPanel.MENUDT,onMenu);
			mainPanel.addEventListener(MainPanel.MENUQT,onMenu);
			
			mainPanel.addEventListener(MainPanel.GROUPMOVE,onGroupMove);
			mainPanel.addEventListener(MainPanel.GROUPOUT,onGroupOut);
			
			buildProxy = facade.retrieveProxy(BuildProxy.NAME) as BuildProxy;
		}
		
		protected function get mainPanel():MainPanel
		{
			return viewComponent as MainPanel;
		}
				
		private function onMenu(event:Event):void
		{
			switch(event.type)
			{
				case MainPanel.MENUYJSX:							
					sendNotification(ApplicationFacade.NOTIFY_MENU_LAYER,[1,mainPanel.btnYJSX.selected]);			
					break;
				case MainPanel.MENUZKS:
					sendNotification(ApplicationFacade.NOTIFY_MENU_LAYER,[2,mainPanel.btnZKS.selected]);
					break;
				case MainPanel.MENUJKZX:
					sendNotification(ApplicationFacade.NOTIFY_MENU_LAYER,[3,mainPanel.btnJKZX.selected]);
					break;
				case MainPanel.MENUDT:
					sendNotification(ApplicationFacade.NOTIFY_MENU_LAYER,[4,mainPanel.btnDT.selected]);
					break;
				case MainPanel.MENUQT:
					sendNotification(ApplicationFacade.NOTIFY_MENU_LAYER,[5,mainPanel.btnQT.selected]);
					break;
			}
		}
		
		private function onFloorChange(event:Event):void
		{
			var floor:FloorVO = mainPanel.listFloor.selectedItem as FloorVO;
			if(	(floor != null) 
				&&((floor.xOffset != 0)
					||(floor.yOffset != 0)
					||(floor.xRotation != 0)
					||(floor.yRotation != 0)
					||(floor.zRotation != 0)
					||(floor.alpha != 0.5)))
			{					
				mainPanel.scale = floor.scale;
				mainPanel.xOffset = floor.xOffset;
				mainPanel.yOffset = floor.yOffset;
				mainPanel.xRotation = floor.xRotation;
				mainPanel.yRotation = floor.yRotation;
				mainPanel.zRotation = floor.zRotation;
				mainPanel.floorAlpha = floor.alpha;
			}
		}
		
		private function onFloorOffset(event:Event):void
		{
			var floor:FloorVO = mainPanel.listFloor.selectedItem as FloorVO;
			if(floor != null) 
			{
				floor.edit = true;
				
				floor.scale = mainPanel.scale;
				floor.xOffset = mainPanel.xOffset;
				floor.yOffset = mainPanel.yOffset;
			}			
		}
		
		private function onFloorSave(event:Event):void
		{
			var data:String = "";
						
			for each(var floor:FloorVO in buildProxy.build.floors)
			{			
				if(floor.edit)
				{
					data += floor.floorID + ";" + floor.scale + ";" + floor.xOffset + ";" + floor.yOffset + ";" + floor.xRotation + ";" + floor.yRotation + ";" + floor.zRotation + ";" + floor.alpha + "@";
					floor.edit = false;
				}
			}
			
			sendNotification(ApplicationFacade.NOTIFY_WEBSERVICE_SEND,
				["SaveFloor",onSaveFloor
					,[buildProxy.build.buildID,data]]);
			
			function onSaveFloor(result:Number):void
			{				
				
			}			
		}
		
		private function onFloorRotation(event:Event):void
		{			
			var floor:FloorVO = mainPanel.listFloor.selectedItem as FloorVO;
			if(floor != null) 
			{
				floor.edit = true;
				
				sendNotification(ApplicationFacade.NOTIFY_FLOOR_ROTATION,floor);
			}
		}
		
		private function onGroupMove(event:AppEvent):void
		{			
			var floorFocus:ImageFloor;
			
			var pt:Point = event.data as Point;
			
			for each(var floor:FloorVO in buildProxy.build.floors)
			{
				var imageFloorMediator:ImageFloorMediator = facade.retrieveMediator("ImageFloorMediator" + floor.floorID) as ImageFloorMediator;
				var imageFloor:ImageFloor = imageFloorMediator.getViewComponent() as ImageFloor;
				
				var rect:Rectangle = new Rectangle(imageFloor.x,imageFloor.y,imageFloor.width * imageFloor.scaleX,imageFloor.height * imageFloor.scaleY);
				if(rect.containsPoint(pt))
				{					
					/*if(
						mainPanel.btnYJSX.selected
						|| mainPanel.btnZKS.selected
						|| mainPanel.btnJKZX.selected
						|| mainPanel.btnDT.selected
						|| mainPanel.btnQT.selected						
					)
					{*/
						var ptPixel:Point = imageFloor.globalToLocal(mainPanel.contentGroup.localToGlobal(pt));
						var alpha:Number = (imageFloor.source as BitmapData).getPixel32(ptPixel.x,ptPixel.y);
											
						if(alpha != 0)
						{
							floorFocus = imageFloor;						
							break;
						}
					/*}
					else
					{
						floorFocus = imageFloor;						
						break;						
					}*/
				}
			}
			
			var floorTop:ImageFloor = mainPanel.contentGroup.getElementAt(buildProxy.build.floors.length - 1) as ImageFloor;
			
			if(floorTop != floorFocus)
			{
				var index:Number = buildProxy.build.floors.getItemIndex(floorTop.floor);
				if(index != 0)
				{
					mainPanel.contentGroup.setElementIndex(floorTop,buildProxy.build.floors.length - 1 - index);
				}		
				
				if(floorFocus)
				{
					mainPanel.contentGroup.setElementIndex(floorFocus,buildProxy.build.floors.length - 1);
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
				ApplicationFacade.NOTIFY_INIT_APP
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case ApplicationFacade.NOTIFY_INIT_APP:
					mainPanel.groupEdit.visible = buildProxy.build.edit;
					
					mainPanel.listFloor.dataProvider = buildProxy.build.floors;
					
					mainPanel.imageBuild.source = buildProxy.build.buildBitmap;
					
					mainPanel.contentGroup.width = buildProxy.build.buildBitmap.width;
					mainPanel.contentGroup.height = buildProxy.build.buildBitmap.height;					
					
					//for each(var floor:FloorVO in buildProxy.build.floors)
					//{
					for(var i:Number = buildProxy.build.floors.length - 1;i >=0;i--)
					{
						var floor:FloorVO = buildProxy.build.floors[i];
					
						var imageFloor:ImageFloor = new ImageFloor;
						imageFloor.floor = floor;
						
						facade.registerMediator(new ImageFloorMediator("ImageFloorMediator" + floor.floorID,imageFloor));
												
						mainPanel.contentGroup.addElement(imageFloor);
					}
					
					if(mainPanel.group.width < buildProxy.build.buildBitmap.width)
					{
						mainPanel.imageHSlider.minimum = mainPanel.group.width - buildProxy.build.buildBitmap.width;
						mainPanel.imageHSlider.value = (mainPanel.group.width - buildProxy.build.buildBitmap.width)/2;
						mainPanel.imageHSlider.visible = true;
					}
					
					if(mainPanel.group.height < buildProxy.build.buildBitmap.height)
					{
						mainPanel.imageVSlider.minimum = mainPanel.group.height - buildProxy.build.buildBitmap.height;
						mainPanel.imageVSlider.value = (mainPanel.group.height - buildProxy.build.buildBitmap.height)/2;
						mainPanel.imageVSlider.visible = true;
					}
					
					sendNotification(ApplicationFacade.NOTIFY_APP_LOADINGHIDE,"程序初始化完成！");					
					break;
			}
		}
	}
}