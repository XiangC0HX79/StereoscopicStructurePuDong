package app.model.vo
{	
	import app.model.WebServiceProxy;
	
	import flash.display.Bitmap;
	import flash.geom.Point;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	public class CommandHeightPicVO
	{
		private var source:Object;
		
		public function get T_ComTitle():String
		{
			return source.T_ComTitle;
		}
		
		public function get T_ComRemark():String
		{
			return source.T_ComRemark;
		}
		
		public function get T_ComPicPath():String
		{
			return  source.T_ComPicPath.replace("../",ConfigVO.BASE_URL);	
		}
		
		public function CommandHeightPicVO(value:Object)
		{
			source = value;
		}
	}
}