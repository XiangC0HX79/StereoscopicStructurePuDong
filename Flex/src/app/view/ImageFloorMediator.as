package app.view
{
	import app.ApplicationFacade;
	import app.model.BuildProxy;
	import app.model.vo.ComponentVO;
	import app.model.vo.FloorVO;
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
		
		private var _aComVisible:Array = new Array(false,false,false,false,false);
		
		public function ImageFloorMediator(mediatorName:String=null, viewComponent:Object=null)
		{
			super(mediatorName, viewComponent);
			
			updateFloor();
						
			//imageFloor.addEventListener(MouseEvent.MOUSE_OVER,onMouseOver);
			//imageFloor.addEventListener(MouseEvent.MOUSE_OUT,onMouseOut);
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
				var comVisible:Boolean = false;
				for each(var item:Boolean in _aComVisible)
				{
					comVisible ||= item;
				}
				alpha = comVisible?imageFloor.floor.alpha:0.01;
			}
			
			_alpha = alpha;
			
			var imageW:Number = imageFloor.floor.floorBitmap.bitmapData.width;
			var imageH:Number = imageFloor.floor.floorBitmap.bitmapData.height;
			
			var floorBitmapData:BitmapData = new BitmapData(imageW,imageH);//imageFloor.floor.floorBitmap.bitmapData.clone();	
			
			var m:Array = [1,0,0,0,0,
						   0,1,0,0,0,
						   0,0,1,0,0,
						   0,0,0,alpha,0];
			
			var filter:ColorMatrixFilter = new ColorMatrixFilter(m);
				
			floorBitmapData.applyFilter(imageFloor.floor.floorBitmap.bitmapData
				,new Rectangle(0,0,imageW,imageH)
				,new Point(0,0)
				,filter);
						
			for each(var component:ComponentVO in imageFloor.floor.components)
			{
				if(component.visible)
				{
					var matrix:Matrix = new Matrix(1,0,0,1,component.xOffset,component.yOffset);
					floorBitmapData.draw(component.componentBitmap,matrix);
				}
			}
			
			/*var dx:Number = 0.5;
			var dy:Number = 0.5;
			
			var angle:Number = Math.PI * (37 / 180);
			
			matrix = new Matrix(1,0,0,1,-floorBitmapData.width/2,-floorBitmapData.height/2);
			
			matrix.concat(new Matrix(1,0,-dx,1));
			
			matrix.rotate(angle);
			
			matrix.concat(new Matrix(1,0,0,1,floorBitmapData.width / 2 + floorBitmapData.height * dx / 2,floorBitmapData.height / 2));
			
			matrix.scale(1,dy);*/
						
			var zangle:Number = Math.PI * (2 - imageFloor.floor.xRotation / 180);
			var xangle:Number = Math.PI * (imageFloor.floor.yRotation / 180);
			var yangle:Number = Math.PI * (imageFloor.floor.zRotation / 180);
			
			var sinx:Number = Math.sin(xangle);
			var siny:Number = Math.sin(yangle);
			var sinz:Number = Math.sin(zangle);
			var cosx:Number = Math.cos(xangle);
			var cosy:Number = Math.cos(yangle);
			var cosz:Number = Math.cos(zangle);
			//var dy:Number = Math.cos(yangle);
			//var dz:Number = Math.cos(zangle);
			
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
			
			w = w<2?2:w;
			h = h<2?2:h;
			
			//var w:Number = Math.sqrt(floorBitmapData.width * floorBitmapData.width + floorBitmapData.height * floorBitmapData.height);
			//var h:Number = w;
						
			matrix = new Matrix(1,0,0,1,-floorBitmapData.width/2,-floorBitmapData.height/2);
			
			//matrix.rotate(xangle);
			
			//matrix.scale(1,dy)
				
			//matrix.scale(dz,1)
			matrix.concat(new Matrix(a,b,c,d,0,0));
			
			matrix.concat(new Matrix(1,0,0,1,w / 2,h / 2));
			
			matrix.scale(imageFloor.floor.scale,imageFloor.floor.scale);
												
			w = w * imageFloor.floor.scale;
			h = h * imageFloor.floor.scale;
			
			w = w<1?1:w;
			h = h<1?1:h;
			
			var cuttingFloor:BitmapData = new BitmapData(w,h,true,0x0);
			
			cuttingFloor.draw(floorBitmapData,matrix);
			
			imageFloor.source = cuttingFloor;
		}
		
		
		override public function listNotificationInterests():Array
		{
			return [
				ApplicationFacade.NOTIFY_MENU_LAYER,
				ApplicationFacade.NOTIFY_FLOOR_ROTATION,				
				ApplicationFacade.NOTIFY_FLOOR_FOCUS
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case ApplicationFacade.NOTIFY_MENU_LAYER:
					var type:Number = notification.getBody()[0];
					var visible:Boolean = notification.getBody()[1];
					
					for each(var component:ComponentVO in imageFloor.floor.components)
					{
						if((component.type == type)
							&& (component.visible != visible))
						{							
							component.visible = visible;
						}
					}
					
					_aComVisible[type - 1] = visible;
					
					updateFloor();
					break;
				
				case ApplicationFacade.NOTIFY_FLOOR_ROTATION:
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
							imageFloor.toolTip = imageFloor.floor.floorName;
							
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