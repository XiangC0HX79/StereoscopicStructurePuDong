package app.model.vo
{
	import flash.display.Bitmap;
	import flash.geom.Point;

	[Bindable]
	public class ControlRangeVO_Old
	{
		public var XOffset:Number;
		
		public var YOffset:Number;
		
		public var bitmap:Bitmap;
		
		public function ControlRangeVO_Old(value:Object)
		{
			XOffset = Number(value.X);
			YOffset = Number(value.Y);
		}
	}
}