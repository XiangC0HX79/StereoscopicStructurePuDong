package app.view
{
	import app.ApplicationFacade;
	import app.model.BuildProxy;
	import app.model.FloorPicProxy;
	import app.model.vo.ConfigVO;
	import app.model.vo.FloorDetailVO;
	import app.model.vo.FloorPicVO;
	import app.model.vo.FloorVO;
	import app.model.vo.LayerVO;
	import app.view.components.ImageFloor;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import flash.filters.BitmapFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import mx.core.IVisualElementContainer;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
		
	public class ImageFloorMediator extends Mediator implements IMediator
	{
		private var _alpha:Number;
				
		public function ImageFloorMediator(mediatorName:String=null, viewComponent:Object=null)
		{
			super(mediatorName, viewComponent);
			
			updateFloor();
						
			imageFloor.addEventListener(MouseEvent.CLICK,onMouseClick);
		}
		
		protected function get imageFloor():ImageFloor
		{
			return viewComponent as ImageFloor;
		}
		
		private function onMouseOver(event:MouseEvent):void
		{
			updateFloor(1);
		}
		
		private function onMouseOut(event:MouseEvent):void
		{
			updateFloor();
		}
		
		private function onMouseClick(event:MouseEvent):void
		{
			sendNotification(ApplicationFacade.NOTIFY_TITLEWINDOW_FLOOR,imageFloor.floor);
		}
		
		private function updateFloor(alpha:Number = NaN):void
		{
			if(isNaN(alpha))
			{
				if(ConfigVO.EDIT
					|| LayerVO.EMERGENCYROUTE.LayerVisible
					|| LayerVO.CONTROLROOM.LayerVisible
					|| LayerVO.MONITOR.LayerVisible
					|| LayerVO.ELEVATOR.LayerVisible
					|| LayerVO.OTHERKEY.LayerVisible
				)
				{
					alpha = imageFloor.floor.T_FloorAlpha;
				}
				else
				{
					alpha = 0.01;
				}
			}
			
			_alpha = alpha;
			
			var imageW:Number = imageFloor.floor.floorBitmap.width;
			var imageH:Number = imageFloor.floor.floorBitmap.height;
			
			var floorBitmapData:BitmapData = new BitmapData(imageW,imageH);
			
			var m:Array = [1,0,0,0,0,
						   0,1,0,0,0,
						   0,0,1,0,0,
						   0,0,0,alpha,0];
			
			var filter:ColorMatrixFilter = new ColorMatrixFilter(m);
				
			floorBitmapData.applyFilter(imageFloor.floor.floorBitmap.bitmapData
				,new Rectangle(0,0,imageW,imageH)
				,new Point(0,0)
				,filter);
						
			var floorPicProxy:FloorPicProxy = facade.retrieveProxy(FloorPicProxy.NAME) as FloorPicProxy;
			for each(var component:FloorDetailVO in imageFloor.floor.floorDetails)
			{
				if(component.layer.LayerVisible || ConfigVO.EDIT)
				{
					var matrix:Matrix = new Matrix(1,0,0,1,component.T_FloorDetailX,component.T_FloorDetailY);					
					matrix.scale(imageFloor.floor.T_FloorScale,imageFloor.floor.T_FloorScale);
					
					var floorPic:FloorPicVO = floorPicProxy.dict[component.T_FloorPicID];
					
					if(floorPic && floorPic.bitmap)
						floorBitmapData.draw(floorPic.bitmap,matrix);
				}
			}
									
			var zangle:Number = Math.PI * (2 - imageFloor.floor.T_FloorXRotation / 180);
			var xangle:Number = Math.PI * (imageFloor.floor.T_FloorYRotation / 180);
			var yangle:Number = Math.PI * (imageFloor.floor.T_FloorZRotation / 180);
			
			var sinx:Number = Math.sin(xangle);
			var siny:Number = Math.sin(yangle);
			var sinz:Number = Math.sin(zangle);
			var cosx:Number = Math.cos(xangle);
			var cosy:Number = Math.cos(yangle);
			var cosz:Number = Math.cos(zangle);
			
			var a:Number = cosy * cosz - sinx * siny * sinz;
			var b:Number = - cosx * sinz;
			var c:Number = cosy * sinz + sinx * siny * cosz;
			var d:Number = cosx * cosz;
			
			var w:Number = 2 * Math.max(
				Math.abs(floorBitmapData.width / 2 * a + floorBitmapData.height / 2 * c),
				Math.abs(floorBitmapData.width / 2 * a - floorBitmapData.height / 2 * c)
			);
			var h:Number = 2 * Math.max(
				Math.abs(floorBitmapData.width / 2 * b + floorBitmapData.height / 2 * d),
				Math.abs(floorBitmapData.width / 2 * b - floorBitmapData.height / 2 * d)
			);
			
			w = int(w<2?2:w);
			h = int(h<2?2:h);
									
			matrix = new Matrix(1,0,0,1,-floorBitmapData.width/2,-floorBitmapData.height/2);
			
			matrix.concat(new Matrix(a,b,c,d,0,0));
			
			matrix.concat(new Matrix(1,0,0,1,w / 2,h / 2));
			
			//matrix.scale(imageFloor.floor.T_FloorScale,imageFloor.floor.T_FloorScale);
												
			//w = w * imageFloor.floor.T_FloorScale;
			//h = h * imageFloor.floor.T_FloorScale;
			
			//w = w<1?1:w;
			//h = h<1?1:h;
			
			var cuttingFloor:BitmapData = new BitmapData(w,h,true,0x0);
			
			cuttingFloor.draw(floorBitmapData,matrix);
			
			imageFloor.source = cuttingFloor;
		}
		
		
		override public function listNotificationInterests():Array
		{
			return [
				ApplicationFacade.NOTIFY_STEREO_LAYER,
				ApplicationFacade.NOTIFY_FLOOR_UPDATE,				
				ApplicationFacade.NOTIFY_FLOOR_FOCUS
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case ApplicationFacade.NOTIFY_STEREO_LAYER:					
					updateFloor();
					break;
				
				case ApplicationFacade.NOTIFY_FLOOR_UPDATE:
					var floor:FloorVO = notification.getBody() as FloorVO;
					if(floor == imageFloor.floor)
					{
						updateFloor();
					}
					break;
				
				case ApplicationFacade.NOTIFY_FLOOR_FOCUS:	
					floor = notification.getBody() as FloorVO;
					
					if(floor == imageFloor.floor)
					{						
						if(_alpha != 1)
						{							
							imageFloor.toolTip = imageFloor.floor.T_FloorName;
							
							updateFloor(1);
						}
					}
					else
					{
						if(_alpha == 1)
						{					
							imageFloor.toolTip = "";
							
							updateFloor();	
						}
					}
					break;
			}
		}
	}
}