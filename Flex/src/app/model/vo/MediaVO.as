package app.model.vo
{
	import flash.display.Bitmap;

	[Bindable]
	public class MediaVO
	{
		private var _source:*;
		
		public function get T_FloorMediaID():Number
		{
			return  _source.T_FloorMediaID;	
		}
		
		public function get T_FloorMediaName():String
		{
			return  _source.T_FloorMediaName;	
		}
		
		public function get T_FloorMediaremark():String
		{
			return  _source.T_FloorMediaremark;	
		}
		
		public function get T_FloorMediaPicPath():String
		{
			return _source.T_FloorMediaPicPath?_source.T_FloorMediaPicPath.replace("../",ConfigVO.BASE_URL):"";
		}
		
		public function MediaVO(item:*)
		{
			_source = item;
		}
	}
}