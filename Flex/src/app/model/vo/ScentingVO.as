package app.model.vo
{
	import app.controller.WebServiceCommand;

	[Bindable]
	public class ScentingVO
	{
		private var source:Object;
				
		public function get T_ScentingID():Number
		{
			return source.T_ScentingID;
		}
		
		public function get T_ScentingX():Number
		{
			return source.T_ScentingX;
		}
		
		public function get T_ScentingY():Number
		{
			return source.T_ScentingY;
		}
		
		public function get T_Scentingremark():String
		{
			return source.T_Scentingremark;
		}
		
		public function get T_ScentingImgName():String
		{
			return source.T_ScentingImgName;
		}
		
		public function get T_ScentingimgPath():String
		{
			return  source.T_ScentingimgPath.replace("../",WebServiceCommand.WSDL);	
		}
		
		public function ScentingVO(value:Object)
		{
			source = value;
		}
	}
}