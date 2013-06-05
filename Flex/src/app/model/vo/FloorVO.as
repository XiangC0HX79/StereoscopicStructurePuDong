package app.model.vo
{
	import flash.display.Bitmap;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	public class FloorVO
	{
		public var floorChildIndex:Number;
		
		public var floorID:String;
		
		public var floorName:String;
		
		public var floorBitmapName:String;
		
		public var floorBitmap:Bitmap;
		
		public var scale:Number;
		
		public var xOffset:Number;
		public var yOffset:Number;
		 
		public var xRotation:Number;
		public var yRotation:Number;
		public var zRotation:Number;
		
		public var alpha:Number;
		
		public var components:ArrayCollection = new ArrayCollection;
		
		public var edit:Boolean = false;
		
		public function FloorVO(item:Object)
		{
			this.floorID = item.T_FloorID;
			this.floorName = item.T_FloorName;
			this.floorBitmapName = item.T_FloorPicPath;
			
			//调试，固定为png格式
			//this.floorBitmapName = this.floorBitmapName.substr(0,this.floorBitmapName.lastIndexOf(".")) + ".png";
			
			this.scale = (item.T_FloorScale == undefined)?0.2:item.T_FloorScale;
			this.xOffset = (item.T_FloorX == undefined)?0:item.T_FloorX;
			this.yOffset = (item.T_FloorY == undefined)?0:item.T_FloorY;
			this.yRotation = (item.T_FloorYRotation == undefined)?0:item.T_FloorYRotation;
			this.xRotation = (item.T_FloorXRotation == undefined)?0:item.T_FloorXRotation;
			this.zRotation = (item.T_FloorZRotation == undefined)?0:item.T_FloorZRotation;
			this.alpha = (item.T_FloorAlpha == undefined)?0.5:item.T_FloorAlpha;
		}
	}
}