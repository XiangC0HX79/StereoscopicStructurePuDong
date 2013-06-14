package app.model.vo
{
	import flash.utils.Dictionary;

	[Bindable]
	public class PassageVO
	{
		private var _source:*;
		
		public function get T_PassageID():Number
		{
			return _source.T_PassageID;
		}		
		
		public function get T_PassageName():String
		{
			return _source.T_PassageName;
		}
		
		public function get T_PassageType():Number
		{
			return _source.T_PassageType;
		}
		
		public function get T_PassagePicPath():String
		{
			return  _source.T_PassagePicPath?_source.T_PassagePicPath.replace("../",ConfigVO.BASE_URL):"";
		}
		
		public var DictImportExport:Dictionary;
		
		public function PassageVO(value:*)
		{
			DictImportExport = new Dictionary;
			
			_source = value;
		}
	}
}