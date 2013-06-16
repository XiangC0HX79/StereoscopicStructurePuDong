package app.model.vo
{	
	import app.model.WebServiceProxy;
	
	import flash.display.Bitmap;
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.FaultEvent;
			
	[Bindable]
	public class BuildVO
	{		
		private var _source:*;
		
		public function get TMB_ID():Number
		{
			return _source.TMB_ID;
		}
				
		public function get TMB_Name():String
		{
			return _source.TMB_Name;
		}
		
		public function get TMB_StereoPicPath():String
		{
			return  _source.TMB_StereoPicPath?_source.TMB_StereoPicPath.replace("../",ConfigVO.BASE_URL):_source.TMB_StereoPicPath;	
		}
		
		public function get TMB_PicPath():String
		{
			return  _source.TMB_PicPath?_source.TMB_PicPath.replace("../",ConfigVO.BASE_URL):_source.TMB_PicPath;	
		}
		
		public function get TMB_X():Number
		{
			return _source.TMB_X?_source.TMB_X:0;
		}
		
		public function get TMB_Y():Number
		{
			return _source.TMB_Y?_source.TMB_Y:0;
		}
		
		public function get TMB_videoPath():String
		{
			return  _source.TMB_videoPath?_source.TMB_videoPath.replace("../",ConfigVO.BASE_URL):_source.TMB_videoPath;	
		}
		
		public function get T_ClosedPicPath():String
		{
			return  _source.T_ClosedPicPath?_source.T_ClosedPicPath.replace("../",ConfigVO.BASE_URL):_source.T_ClosedPicPath;	
		}
		
		public function get T_RescueimgPath():String
		{
			return  _source.T_RescueimgPath?_source.T_RescueimgPath.replace("../",ConfigVO.BASE_URL):_source.T_RescueimgPath;	
		}
		
		public function get T_FirePath():String
		{
			return  _source.T_FirePath?_source.T_FirePath.replace("../",ConfigVO.BASE_URL):_source.T_FirePath;	
		}
		
		public function get T_ScentingPicPath():String
		{
			return  _source.T_ScentingPicPath?_source.T_ScentingPicPath.replace("../",ConfigVO.BASE_URL):_source.T_ScentingPicPath;	
		}		
		
		public function get TMB_descriptionPath():String
		{
			return  _source.TMB_descriptionPath?_source.TMB_descriptionPath.replace("../",ConfigVO.BASE_URL):_source.TMB_descriptionPath;	
		}	
		
		public function get TMB_SecurityOrgPath():String
		{
			return  _source.TMB_SecurityOrgPath?_source.TMB_SecurityOrgPath.replace("../",ConfigVO.BASE_URL):_source.TMB_SecurityOrgPath;	
		}	
		
		public function get TMB_FuncDivisionPath():String
		{
			return  _source.TMB_FuncDivisionPath?_source.TMB_FuncDivisionPath.replace("../",ConfigVO.BASE_URL):_source.TMB_FuncDivisionPath;	
		}	
		
		public function get TMB_EmergPath():String
		{
			return  _source.TMB_EmergPath?_source.TMB_EmergPath.replace("../",ConfigVO.BASE_URL):_source.TMB_EmergPath;	
		}	
			
		public function get TMB_Communicate():String
		{
			return _source.TMB_Communicate;
		}
		
		public function get TMB_Cabledrop():String
		{
			return _source.TMB_Cabledrop;
		}
		
		public function get TMB_Landing():String
		{
			return _source.TMB_Landing;
		}
		
		public function get TMB_windows():String
		{
			return _source.TMB_windows;
		}
		
		public function get TMB_Internalhigh():String
		{
			return _source.TMB_Internalhigh;
		}
				
		//内部结构图		
		//public var floors:ArrayCollection = new ArrayCollection;
		//public var floorPics:ArrayCollection = new ArrayCollection;
						
		public var BitmapWidth:Number = 0;
		public var BitmapHeight:Number = 0;
		
		public function BuildVO(value:* = null)
		{
			_source = value;
		}
	}
}