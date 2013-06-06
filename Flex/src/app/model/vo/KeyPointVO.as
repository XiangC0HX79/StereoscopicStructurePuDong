package app.model.vo
{
	import flash.display.Bitmap;
	import flash.geom.Point;

	[Bindable]
	public class KeyPointVO
	{
		public static var Icon:Bitmap;
		
		public var KeyPointId:String;
		
		public var XOffset:Number;
		
		public var YOffset:Number;
		
		public function KeyPointVO(value:Object)
		{
			KeyPointId = value.ID;
			XOffset = Number(value.X);
			YOffset = Number(value.Y);
		}
	}
}