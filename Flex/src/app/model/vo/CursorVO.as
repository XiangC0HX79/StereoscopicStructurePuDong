package app.model.vo
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;

	public class CursorVO extends Bitmap
	{
		public static var customBitmapData:BitmapData;
		
		public function CursorVO()
		{
			super(customBitmapData);
		}
	}
}