package app.model.vo
{
	import app.controller.WebServiceCommand;

	[Bindable]
	public class TaticalVO
	{
		private var source:Object;
		
		public function get TP_ID():Number
		{
			return source.TP_ID;
		}
		
		public function get TP_Type():Number
		{
			return source.TP_Type;
		}
				
		public function get TP_Title():String
		{
			return source.TP_Title;
		}
		
		public function get TP_Remark():String
		{
			return source.TP_Remark;
		}
		
		public function get TP_PicPath():String
		{
			return  source.TP_PicPath?source.TP_PicPath.replace("../",WebServiceCommand.WSDL):source.TP_PicPath;	
		}
		
		public function get TP_VideoPath():String
		{
			return  source.TP_VideoPath?source.TP_VideoPath.replace("../",WebServiceCommand.WSDL):source.TP_VideoPath;	
		}
		
		public function TaticalVO(value:Object)
		{
			source = value;
		}
	}
}