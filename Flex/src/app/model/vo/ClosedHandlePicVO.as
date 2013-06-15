package app.model.vo
{	
	import app.model.WebServiceProxy;
	
	import flash.display.Bitmap;
	import flash.geom.Point;
	
	import mx.collections.ArrayCollection;
	
	import org.osmf.media.MediaType;

	[Bindable]
	public class ClosedHandlePicVO implements IMediaVO
	{
		private var _source:Object;
		
		public function ClosedHandlePicVO(source:Object)
		{
			_source = source;
		}
		
		public function get mediaID():Number
		{
			return _source.T_ClosedhandlesPicID;
		}
		
		public function get containerID():Number
		{
			return _source.T_ClosedhandlesID;
		}
		
		public function get mediaTitle():String
		{
			return _source.T_ClosedhandlesPicTitle;
		}
		
		public function get mediaRemark():String
		{
			return _source.T_ClosedhandlesPicRremark;
		}
		
		public function get mediaPath():String
		{
			return  _source.T_ClosedhandlesPicimgPath?_source.T_ClosedhandlesPicimgPath.replace("../",ConfigVO.BASE_URL):"";	
		}
		
		public function get mediaType():String
		{
			return MediaType.IMAGE;
		}
	}
}