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
		public function set T_HazardX(value:Number):void
		{
			source.T_HazardX = value;
		}
		
		public function get T_HazardY():Number
		{
			return source.T_HazardY;
		}
		public function set T_HazardY(value:Number):void
		{
			source.T_HazardY = value;
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
			return source.T_HazardLineLength?source.T_HazardLineLength:"";
		}
		
		public function get T_HazardPicimgPath():String
		{
			return  source.T_HazardPicimgPath.replace("../",ConfigVO.BASE_URL);	
		}
		
		public function HazardVO(value:Object)
		{
			source = value;
		}
	}
}