package app.model.vo
{	
	import flash.display.Bitmap;
	import flash.geom.Point;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	public class ClosedHandlePicVO
	{
		private var source:Object;
		
		public function get T_ClosedhandlesPicTitle():String
		{
			return source.T_ClosedhandlesPicTitle;
		}
		
		public function get T_ClosedhandlesPicRremark():String
		{
			return source.T_ClosedhandlesPicRremark;
		}
		
		public function get T_ClosedhandlesPicimgPath():String
		{
			return  source.T_ClosedhandlesPicimgPath.replace("../",WebServiceVO.BASE_WSDL);	
		}
		
		public function ClosedHandlePicVO(value:Object)
		{
			source = value;
		}
	}
}