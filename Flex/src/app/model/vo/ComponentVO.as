package app.model.vo
{
	import flash.display.Bitmap;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	public class ComponentVO
	{		
		public var componentID:String;
		
		public var componentName:String;
		
		public var componentBitmap:Bitmap;
		
		public var componentBitmapName:String;
		
		public var layer:LayerVO;
		
		public var xOffset:Number;
		public var yOffset:Number;
		
		//public var visible:Boolean;
						
		public var videoName:String = "";
		
		public var listMedia:ArrayCollection = new ArrayCollection;
		
		public function ComponentVO(item:Object)
		{
			this.componentID = item.T_FloorDetailID;
			this.componentName = item.T_FloorDetailName;
			this.componentBitmapName = item.T_FloorPicimgPath;
			this.xOffset = item.T_FloorDetailX;
			this.yOffset = item.T_FloorDetailY;
			
			//this.type = item.T_FloorDetailType;
		}
	}
}