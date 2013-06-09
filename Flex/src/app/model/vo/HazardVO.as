package app.model.vo
{
	import app.controller.WebServiceCommand;

	[Bindable]
	public class HazardVO
	{
		private var source:Object;
		
		public function get T_HazardID():Number
		{
			return source.T_HazardID;
		}
		
		public function get T_HazardX():Number
		{
			return source.T_HazardX;
		}
		
		public function get T_HazardY():Number
		{
			return source.T_HazardY;
		}
		
		public function get T_HazardType():Number
		{
			return source.T_HazardType;
		}
		
		public function get T_HazardName():String
		{
			return source.T_HazardName;
		}
		
		public function get T_HazardAddress():String
		{
			return source.T_HazardAddress;
		}
		
		public function get T_HazardLineLength():String
		{
			return source.T_HazardLineLength;
		}
		
		public function get T_HazardPicimgPath():String
		{
			return  source.T_HazardPicimgPath.replace("../",WebServiceCommand.WSDL);	
		}
		
		public function HazardVO(value:Object)
		{
			source = value;
		}
	}
}