package app.model.vo
{
	import org.osmf.media.MediaType;

	public class TrafficPicVO implements IMediaVO
	{
		private var _source:*;
		
		public function TrafficPicVO(source:*)
		{
			_source = source;
		}
		
		public function get mediaID():Number
		{
			return _source.T_TrafficPicID;
		}
		
		public function get containerID():Number
		{
			return _source.T_TrafficID;
		}
		
		public function get mediaTitle():String
		{
			return _source.T_TrafficPicTitle;
		}
		
		public function get mediaRemark():String
		{
			return _source.T_TrafficPicRremark;
		}
		
		public function get mediaPath():String
		{
			return  _source.T_TrafficPicmgPath?_source.T_TrafficPicmgPath.replace("../",ConfigVO.BASE_URL):"";	
		}
		
		public function get mediaType():String
		{
			return MediaType.IMAGE;
		}
	}
}