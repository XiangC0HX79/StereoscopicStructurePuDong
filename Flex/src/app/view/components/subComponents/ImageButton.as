package app.view.components.subComponents
{
	import mx.graphics.BitmapFill;
	
	import spark.components.Button;
	import spark.components.Image;
	
	public class ImageButton extends Button
	{		
		public function ImageButton()
		{
			super();
		}
		
		[Bindable]public var upIcon:Object = null;
		
		[Bindable]public var overIcon:Object = null;
	}
}