package app.model.vo
{
	[Bindable]
	public class LayerVO
	{
		public static const TRAFFIC:LayerVO = new LayerVO(3,"重要交通信息");
		public static const HAZARD:LayerVO = new LayerVO(4,"危险源");
		public static const KEYUNITS:LayerVO = new LayerVO(7,"重点单位");
		public static const SCENTING:LayerVO = new LayerVO(8,"窨井通道");		
		
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