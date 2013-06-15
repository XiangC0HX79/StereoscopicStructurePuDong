package app.model.vo
{
	import org.osmf.media.MediaType;

	[Bindable]
	public class ImportExportPicVO implements IMediaVO
	{
		private var _source:*;
		
		public function get mediaID():Number
		{
			return _source.T_ImportExportPicID;
		}		
		
		public function get T_PassageID():Number
		{
			return _source.T_PassageID;
		}		
		
		public function get containerID():Number
		{
			return _source.T_ImportExportID;
		}		
		
		public function get mediaTitle():String
		{
			return _source.T_ImportExportPicTitle;
		}
		
		public function get mediaRemark():String
		{
			return _source.T_ImportExportPicRemark;
		}
		
		public function get mediaPath():String
		{
			return  _source.T_ImportExportPicPicPath?_source.T_ImportExportPicPicPath.replace("../",ConfigVO.BASE_URL):"";
		}
		
		public function get mediaType():String
		{
			return (_source.T_ImportExportType == 1)?MediaType.IMAGE:MediaType.VIDEO;
		}
		
		public function ImportExportPicVO(value:*)
		{
			_source = value;
		}
	}
}