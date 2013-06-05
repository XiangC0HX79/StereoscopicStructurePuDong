package app.model.vo
{
	import flash.display.Bitmap;

	[Bindable]
	public class MediaVO
	{
		public var mediaID:String = "";
		
		public var mediaName:String = "";
		
		public var mediaRemark:String = "";
		
		public var mediaBimap:Bitmap;
		
		public var mediaBimapName:String = "";
		
		public function MediaVO(item:Object)
		{
			this.mediaID = item.T_FloorMediaID;
			this.mediaName = item.T_FloorMediaName;
			this.mediaRemark = item.T_FloorMediaremark;
			this.mediaBimapName = item.T_FloorMediaPicPath;
		}
	}
}