package app.model.vo
{
	import flash.utils.Dictionary;

	[Bindable]
	public class ImportExportVO
	{
		private var _source:*;
		
		public function get T_ImportExportID():Number
		{
			return _source.T_ImportExportID;
		}		
		
		public function get T_PassageID():Number
		{
			return _source.T_PassageID;
		}		
		
		public function get T_ImportExportName():String
		{
			return _source.T_ImportExportName;
		}
		
		public function get T_ImportExportremark():String
		{
			return _source.T_ImportExportremark;
		}
		
		public function get T_ImportExportX():Number
		{
			return _source.T_ImportExportX;
		}
		
		public function get T_ImportExportY():Number
		{
			return _source.T_ImportExportY;
		}
		
		public var DictImportExportPic:Dictionary;
		
		public function get DictImportExportPicLength():Number
		{
			var i:Number = 0;
			
			for(var key:* in DictImportExportPic)
				i++;
			
			return i;
		}
		
		public function ImportExportVO(value:*)
		{
			DictImportExportPic = new Dictionary;
			
			_source = value;
		}
	}
}