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
		public function set T_ImportExportX(value:Number):void
		{
			edit = true;
			_source.T_ImportExportX = value;
		}
		
		public function get T_ImportExportY():Number
		{
			return _source.T_ImportExportY;
		}
		public function set T_ImportExportY(value:Number):void
		{
			edit = true;
			_source.T_ImportExportY = value;
		}
		
		public var DictImportExportPic:Dictionary;
				
		public var edit:Boolean = false;
		
		public function ImportExportVO(value:*)
		{
			DictImportExportPic = new Dictionary;
			
			_source = value;
		}
	}
}