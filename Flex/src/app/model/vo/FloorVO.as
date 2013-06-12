package app.model.vo
{
	import flash.display.Bitmap;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	public class FloorVO
	{
		private var _source:*;
		
		public var floorChildIndex:Number;
		
		public var floorID:String;
		
		public var floorName:String;
		
		public function get T_FloorPicPath():String
		{
			return  _source.T_FloorPicPath?_source.T_FloorPicPath.replace("../",ConfigVO.BASE_URL):"";	
		}
		
		public var floorBitmap:Bitmap;
		
		public var scale:Number;
		
		public var xOffset:Number;
		public var yOffset:Number;
		 
		public var xRotation:Number;
		public var yRotation:Number;
		public var zRotation:Number;
		
		public var alpha:Number;
		
		public var components:ArrayCollection;
		
		public var edit:Boolean = false;
		
		public function FloorVO(value:*)
		{
			_source = value;
			
			this.floorID = value.T_FloorID;
			this.floorName = value.T_FloorName;						
			this.scale = (value.T_FloorScale == undefined)?0.2:value.T_FloorScale;
			this.xOffset = (value.T_FloorX == undefined)?0:value.T_FloorX;
			this.yOffset = (value.T_FloorY == undefined)?0:value.T_FloorY;
			this.yRotation = (value.T_FloorYRotation == undefined)?0:value.T_FloorYRotation;
			this.xRotation = (value.T_FloorXRotation == undefined)?0:value.T_FloorXRotation;
			this.zRotation = (value.T_FloorZRotation == undefined)?0:value.T_FloorZRotation;
			this.alpha = (value.T_FloorAlpha == undefined)?0.5:value.T_FloorAlpha;
		}
	}
}