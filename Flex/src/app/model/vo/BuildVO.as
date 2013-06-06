package app.model.vo
{
	import flash.display.Bitmap;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	public class BuildVO
	{
		public var buildID:String;
		
		public var buildName:String;
		
		public var edit:Boolean;
		
		//周边环境
		public var surroundingBitmap:Bitmap;
		
		public var keyPoints:ArrayCollection = new ArrayCollection;
		
		public var controlRange:ControlRangeVO;
		
		//内部结构图
		//public var buildBitmapName:String;
		
		public var buildBitmap:Bitmap;
		
		public var floors:ArrayCollection = new ArrayCollection;
		
		//应急预案
		public var contingencyPlans:String;
		
		
		public function BuildVO()
		{
		}
	}
}