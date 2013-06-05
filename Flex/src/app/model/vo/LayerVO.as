package app.model.vo
{
	[Bindable]
	public class LayerVO
	{
		public var LayerID:Number;
		
		public var LayerName:String;
		
		public var LayerVisible:Boolean = false;
		
		public function LayerVO(layerID:Number,layerName:String)
		{
			LayerID = layerID;
			LayerName = layerName;
		}
	}
}