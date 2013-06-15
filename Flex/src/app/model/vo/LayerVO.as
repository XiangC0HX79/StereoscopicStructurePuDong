package app.model.vo
{
	[Bindable]
	public class LayerVO
	{	
		public static const NONE:LayerVO = new LayerVO(0,"未知信息");
		
		public static const COMMANDHEIGHT:LayerVO = new LayerVO(1,"制高点");
		public static const CLOSEHANDLE:LayerVO = new LayerVO(2,"分控范围");
		public static const TRAFFIC:LayerVO = new LayerVO(3,"重要交通信息");
		public static const HAZARD:LayerVO = new LayerVO(4,"危险源");
		public static const RESCUE:LayerVO = new LayerVO(5,"救援信息");
		public static const FIRE:LayerVO = new LayerVO(6,"消防栓");
		public static const KEYUNITS:LayerVO = new LayerVO(7,"重点单位");
		public static const SCENTING:LayerVO = new LayerVO(8,"窨井通道");	
		
		public static const EMERGENCYROUTE:LayerVO = new LayerVO(11,"应急疏散通道");
		public static const CONTROLROOM:LayerVO = new LayerVO(12,"总控室");
		public static const MONITOR:LayerVO = new LayerVO(13,"监控中心");
		public static const ELEVATOR:LayerVO = new LayerVO(14,"电梯");
		public static const OTHERKEY:LayerVO = new LayerVO(15,"其他重要部位");
		
		public static const VIDEO:LayerVO = new LayerVO(16,"视频点位");
		
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