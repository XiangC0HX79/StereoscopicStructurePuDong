package app.model.vo
{
	import flash.display.Bitmap;
	
	import org.osmf.media.MediaType;

	[Bindable]
	public class MediaVO implements IMediaVO
	{
		private var _source:*;
		
		public function get mediaID():Number
		{
			return  _source.T_FloorMediaID;	
		}
		
		public function get containerID():Number
		{
			return  _source.T_FloorDetailID;	
		}
		
		public function get T_FloorID():Number
		{
			return _source.T_FloorID;
		}
		
		public function get mediaTitle():String
		{
			return  _source.T_FloorMediaName;	
		}
		
		public function get mediaRemark():String
		{
			return  _source.T_FloorMediaremark;	
		}
		
		public function get mediaPath():String
		{
			return _source.T_FloorMediaPicPath?_source.T_FloorMediaPicPath.replace("../",ConfigVO.BASE_URL):"";
		}
		
		public function get mediaType():String
		{
			return (_source.T_FloorMediaType == 1)?MediaType.IMAGE:MediaType.VIDEO;
		}
		
		public function MediaVO(item:*)
		{
			_source = item;
		}
	}
}