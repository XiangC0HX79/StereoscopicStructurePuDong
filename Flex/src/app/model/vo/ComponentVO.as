package app.model.vo
{
	import flash.display.Bitmap;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	public class ComponentVO
	{		
		private var _source:*;
		
		public var componentID:String;
		
		public var componentName:String;
		
		public var componentBitmap:Bitmap;
		
		public function get T_FloorPicimgPath():String
		{
			return  _source.T_FloorPicimgPath?_source.T_FloorPicimgPath.replace("../",ConfigVO.BASE_URL):"";	
		}
		
		public var layer:LayerVO;
		
		public var xOffset:Number;
		public var yOffset:Number;
								
		public var videoName:String = "";
		
		public var listMedia:ArrayCollection = new ArrayCollection;
		
		public function ComponentVO(item:Object)
		{
			_source = item;
			
			this.componentID = item.T_FloorDetailID;
			this.componentName = item.T_FloorDetailName;			
			this.xOffset = item.T_FloorDetailX;
			this.yOffset = item.T_FloorDetailY;			
		}
	}
}