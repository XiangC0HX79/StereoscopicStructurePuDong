package app.model.vo
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	public class FloorVO
	{
		private var _source:*;
		
		public var floorBitmap:Bitmap;
		
		public function get T_BitmapWidth():Number
		{
			return  _source.T_BitmapWidth;	
		}
		
		public function get T_BitmapHeight():Number
		{
			return  _source.T_BitmapHeight;	
		}
		
		public function get T_FloorID():Number
		{
			return  _source.T_FloorID;	
		}
		
		public function get T_FloorPosID():Number
		{
			return  _source.T_FloorPosID;	
		}
		
		public function get T_FloorName():String
		{
			return  _source.T_FloorName;	
		}
				
		public function get T_FloorPicPath():String
		{
			return  _source.T_FloorPicPath?_source.T_FloorPicPath.replace("../",ConfigVO.BASE_URL):"";	
		}
						
		public function get T_FloorScale():Number
		{
			return  _source.T_FloorScale;	
		}
		public function set T_FloorScale(value:Number):void
		{
			_source.T_FloorScale = value;	
		}
		
		public function get T_FloorX():Number
		{
			return  _source.T_FloorX?_source.T_FloorX:0;	
		}
		public function set T_FloorX(value:Number):void
		{
			_source.T_FloorX = value;	
		}
		
		public function get T_FloorY():Number
		{
			return  _source.T_FloorY?_source.T_FloorY:0;	
		}
		public function set T_FloorY(value:Number):void
		{
			_source.T_FloorY = value;	
		}
		
		public function get T_FloorAlpha():Number
		{
			return  isNaN(_source.T_FloorAlpha)?0.5:_source.T_FloorAlpha;	
		}
		public function set T_FloorAlpha(value:Number):void
		{
			_source.T_FloorAlpha = value;	
		}
		
		public function get T_FloorXRotation():Number
		{
			return  isNaN(_source.T_FloorXRotation)?0:_source.T_FloorXRotation;	
		}
		public function set T_FloorXRotation(value:Number):void
		{
			_source.T_FloorXRotation = value;	
		}
		
		public function get T_FloorYRotation():Number
		{
			return  isNaN(_source.T_FloorYRotation)?0:_source.T_FloorYRotation;	
		}
		public function set T_FloorYRotation(value:Number):void
		{
			_source.T_FloorYRotation = value;	
		}
		
		public function get T_FloorZRotation():Number
		{
			return  isNaN(_source.T_FloorZRotation)?0:_source.T_FloorZRotation;	
		}
		public function set T_FloorZRotation(value:Number):void
		{
			_source.T_FloorZRotation = value;	
		}
				
		public var floorDetails:Dictionary;
		
		public var edit:Boolean = false;
		
		public function FloorVO(value:*)
		{
			floorDetails = new Dictionary;
			
			_source = value;
		}
	}
}