package app.model.vo
{
	import app.controller.WebServiceCommand;

	[Bindable]
	public class TrafficInfoVO
	{
		private var source:Object;
		
		public function get T_TrafficID():Number
		{
			return source.T_TrafficID;
		}
		
		public function get T_TrafficX():Number
		{
			return source.T_TrafficX;
		}
		
		public function get T_TrafficY():Number
		{
			return source.T_TrafficY;
		}
		
		public function get T_TrafficPicTitle():String
		{
			return source.T_TrafficPicTitle;
		}
		
		public function get T_TrafficPicRremark():String
		{
			return source.T_TrafficPicRremark;
		}
		
		public function get T_TrafficPicmgPath():String
		{
			return  source.T_TrafficPicmgPath.replace("../",WebServiceCommand.WSDL);	
		}
		
		public function TrafficInfoVO(value:Object)
		{
			source = value;
		}
	}
}