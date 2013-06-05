package app.model.vo
{
	import flash.display.Bitmap;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	public class BuildVO
	{
		public var buildID:String;
		
		public var buildName:String;
		
		public var buildBitmapName:String;
		
		public var buildBitmap:Bitmap;
		
		public var floors:ArrayCollection = new ArrayCollection;
		
		public var edit:Boolean;
				
		public function BuildVO()
		{
		}
	}
}