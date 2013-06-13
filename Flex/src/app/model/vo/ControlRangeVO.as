package app.model.vo
{
	import flash.display.Bitmap;
	import flash.geom.Point;

	[Bindable]
	public class ControlRangeVO
	{
		public var XOffset:Number;
		
		public var YOffset:Number;
		
		public var bitmap:Bitmap;
		
		public function ControlRangeVO(value:Object)
		{
			XOffset = Number(value.X);
			YOffset = Number(value.Y);
		}
	}
}