package app.model.vo
{
	import app.controller.WebServiceCommand;

	[Bindable]
	public class KeyUnitVO
	{
		private var source:Object;
		
		public function get T_KeyUnitsID():Number
		{
			return source.T_KeyUnitsID;
		}
		
		public function get T_KeyUnitsName():String
		{
			return source.T_KeyUnitsName;
		}
		
		public function get T_KeyUnitsAddress():String
		{
			return source.T_KeyUnitsAddress;
		}
		
		public function get T_KeyUnitsLineLength():String
		{
			return source.T_KeyUnitsAddress;
		}
		
		public function get T_KeyUnitsX():Number
		{
			return source.T_KeyUnitsX;
		}
		
		public function get T_KeyUnitsY():Number
		{
			return source.T_KeyUnitsY;
		}
		
		public function get T_KeyUnitsPicimgPath():String
		{
			return  source.T_KeyUnitsPicimgPath.replace("../",WebServiceCommand.WSDL);	
		}
		
		public function KeyUnitVO(value:Object)
		{
			source = value;
		}
	}
}