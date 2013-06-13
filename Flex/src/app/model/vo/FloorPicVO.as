package app.model.vo
{
	import flash.display.Bitmap;

	[Bindable]
	public class FloorPicVO
	{
		private var _source:*;
		
		public var bitmap:Bitmap;
		
		public function get T_FloorPicID():Number
		{
			return _source.T_FloorPicID;
		}
		
		public function get T_FloorPicimgPath():String
		{
			return _source.T_FloorPicimgPath?_source.T_FloorPicimgPath.replace("../",ConfigVO.BASE_URL):"";
		}
		
		public function FloorPicVO(value:*)
		{
			_source = value;
		}
	}
}