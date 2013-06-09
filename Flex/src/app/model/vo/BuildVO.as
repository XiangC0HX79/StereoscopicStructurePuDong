package app.model.vo
{
	import app.controller.WebServiceCommand;
	
	import flash.display.Bitmap;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	public class BuildVO
	{
		private var source:Object;
		
		public function get TMB_ID():Number
		{
			return source.TMB_ID;
		}
				
		public function get TMB_Name():String
		{
			return source.TMB_Name;
		}
		
		public function get TMB_X():Number
		{
			return source.TMB_X;
		}
		
		public function get TMB_Y():Number
		{
			return source.TMB_Y;
		}
		
		public function get TMB_videoPath():String
		{
			return  source.TMB_videoPath?source.TMB_videoPath.replace("../",WebServiceCommand.WSDL):source.TMB_videoPath;	
		}
		
		public function get T_ClosedPicPath():String
		{
			return  source.T_ClosedPicPath?source.T_ClosedPicPath.replace("../",WebServiceCommand.WSDL):source.T_ClosedPicPath;	
		}
		
		public function get T_RescueimgPath():String
		{
			return  source.T_RescueimgPath?source.T_RescueimgPath.replace("../",WebServiceCommand.WSDL):source.T_RescueimgPath;	
		}
		
		public function get T_FirePath():String
		{
			return  source.T_FirePath?source.T_FirePath.replace("../",WebServiceCommand.WSDL):source.T_FirePath;	
		}
		
		public function get T_ScentingPicPath():String
		{
			return  source.T_ScentingPicPath?source.T_ScentingPicPath.replace("../",WebServiceCommand.WSDL):source.T_ScentingPicPath;	
		}		
		
		public function get TMB_descriptionPath():String
		{
			return  source.TMB_descriptionPath?source.TMB_descriptionPath.replace("../",WebServiceCommand.WSDL):source.TMB_descriptionPath;	
		}	
		
		public function get TMB_SecurityOrgPath():String
		{
			return  source.TMB_SecurityOrgPath?source.TMB_SecurityOrgPath.replace("../",WebServiceCommand.WSDL):source.TMB_SecurityOrgPath;	
		}	
		
		public function get TMB_FuncDivisionPath():String
		{
			return  source.TMB_FuncDivisionPath?source.TMB_FuncDivisionPath.replace("../",WebServiceCommand.WSDL):source.TMB_FuncDivisionPath;	
		}	
			
		public function get TMB_Communicate():String
		{
			return source.TMB_Communicate;
		}
		
		public function get TMB_Cabledrop():String
		{
			return source.TMB_Cabledrop;
		}
		
		public function get TMB_Landing():String
		{
			return source.TMB_Landing;
		}
		
		public function get TMB_windows():String
		{
			return source.TMB_windows;
		}
		
		public function get TMB_Internalhigh():String
		{
			return source.TMB_Internalhigh;
		}
		
		
		//周边环境
		public var TMB_StereoPic:Bitmap;
		
		public var CommandingHeights:ArrayCollection = new ArrayCollection;
		
		public var closeHandles:ArrayCollection;
		
		public var keyUnits:ArrayCollection = new ArrayCollection;
		
		public var Scenting:ArrayCollection = new ArrayCollection;
		
		public var Traffic:ArrayCollection = new ArrayCollection;
		
		public var Hazzard:ArrayCollection = new ArrayCollection;
		
		public var Communicate:ArrayCollection = new ArrayCollection;
		public var Cabledrop:ArrayCollection = new ArrayCollection;
		public var Landing:ArrayCollection = new ArrayCollection;
		public var Windows:ArrayCollection = new ArrayCollection;
		public var Internalhigh:ArrayCollection = new ArrayCollection;
		
		//public var controlRange:ControlRangeVO;
		
		//内部结构图
		//public var buildBitmapName:String;
		
		public var buildBitmap:Bitmap;
		
		public var floors:ArrayCollection = new ArrayCollection;
		
		//应急预案
		public var contingencyPlans:String;
		
		
		public function BuildVO(value:Object = null)
		{
			source = value;
		}
	}
}