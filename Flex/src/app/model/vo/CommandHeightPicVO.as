package app.model.vo
{
	import org.osmf.media.MediaType;
	
	[Bindable]
	public class CommandHeightPicVO implements IMediaVO
	{
		private var _source:*;
		
		public function CommandHeightPicVO(source:*)
		{
			_source = source;
		}
		
		public function get mediaID():Number
		{
			return _source.T_ComID;
		}
		
		public function get containerID():Number
		{
			return _source.TCH_ID;
		}
		
		public function get mediaTitle():String
		{
			return _source.T_ComTitle;
		}
		
		public function get mediaRemark():String
		{
			return _source.T_ComRemark;
		}
		
		public function get mediaPath():String
		{
			return  _source.T_ComPicPath?_source.T_ComPicPath.replace("../",ConfigVO.BASE_URL):"";	
		}
		
		public function get mediaType():String
		{
			return MediaType.IMAGE;
		}
	}
}