package app.model.vo
{
	[Bindable]
	public class ImportExportPicVO
	{
		private var _source:*;
		
		public function get T_ImportExportPicID():Number
		{
			return _source.T_ImportExportPicID;
		}		
		
		public function get T_PassageID():Number
		{
			return _source.T_PassageID;
		}		
		
		public function get T_ImportExportID():Number
		{
			return _source.T_ImportExportID;
		}		
		
		public function get T_ImportExportPicTitle():String
		{
			return _source.T_ImportExportPicTitle;
		}
		
		public function get T_ImportExportPicRemark():String
		{
			return _source.T_ImportExportPicRemark;
		}
		
		public function get T_ImportExportPicPicPath():String
		{
			return  _source.T_ImportExportPicPicPath?_source.T_ImportExportPicPicPath.replace("../",ConfigVO.BASE_URL):"";
		}
		
		public function get T_ImportExportType():Number
		{
			return _source.T_ImportExportType;
		}
		
		public function ImportExportPicVO(value:*)
		{
			_source = value;
		}
	}
}