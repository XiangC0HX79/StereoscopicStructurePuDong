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
			return source.T_KeyUnitsAddress?source.T_KeyUnitsAddress:"";
		}
		
		public function get T_KeyUnitsX():Number
		{
			return source.T_KeyUnitsX;
		}		
		public function set T_KeyUnitsX(value:Number):void
		{
			source.T_KeyUnitsX = value;
		}
		
		public function get T_KeyUnitsY():Number
		{
			return source.T_KeyUnitsY;
		}	
		public function set T_KeyUnitsY(value:Number):void
		{
			source.T_KeyUnitsY = value;
		}
		
		public function get T_KeyUnitsPicimgPath():String
		{
			return  source.T_KeyUnitsPicimgPath.replace("../",ConfigVO.BASE_URL);	
		}
		
		public function KeyUnitVO(value:Object)
		{
			source = value;
		}
	}
}