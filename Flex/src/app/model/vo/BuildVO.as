package app.model.vo
{	
	import flash.display.Bitmap;
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.FaultEvent;
			
	[Bindable]
	public class BuildVO extends WebServiceVO
	{
		public static const INIT_BASEINFO:String 		= "InitBaseInfoComplete";
		public static const INIT_COMMANDHEIGHTS:String 	= "InitCommandHeightsComplete";
		public static const INIT_CLOSEHANDLES:String 	= "InitCloseHandlesComplete";
		
		public static var Edit:Boolean = false;
		
		private var source:Object;
		
		public function get TMB_ID():Number
		{
			return source.TMB_ID;
		}
				
		public function get TMB_Name():String
		{
			return source.TMB_Name;
		}
		
		public function get TMB_StereoPicPath():String
		{
			return  source.TMB_StereoPicPath?source.TMB_StereoPicPath.replace("../",WebServiceVO.BASE_WSDL):source.TMB_StereoPicPath;	
		}
			
		public function get TMB_X():Number
		{
			return source.TMB_X?source.TMB_X:0;
		}
		
		public function get TMB_Y():Number
		{
			return source.TMB_Y?source.TMB_Y:0;
		}
		
		public function get TMB_videoPath():String
		{
			return  source.TMB_videoPath?source.TMB_videoPath.replace("../",WebServiceVO.BASE_WSDL):source.TMB_videoPath;	
		}
		
		public function get T_ClosedPicPath():String
		{
			return  source.T_ClosedPicPath?source.T_ClosedPicPath.replace("../",WebServiceVO.BASE_WSDL):source.T_ClosedPicPath;	
		}
		
		public function get T_RescueimgPath():String
		{
			return  source.T_RescueimgPath?source.T_RescueimgPath.replace("../",WebServiceVO.BASE_WSDL):source.T_RescueimgPath;	
		}
		
		public function get T_FirePath():String
		{
			return  source.T_FirePath?source.T_FirePath.replace("../",WebServiceVO.BASE_WSDL):source.T_FirePath;	
		}
		
		public function get T_ScentingPicPath():String
		{
			return  source.T_ScentingPicPath?source.T_ScentingPicPath.replace("../",WebServiceVO.BASE_WSDL):source.T_ScentingPicPath;	
		}		
		
		public function get TMB_descriptionPath():String
		{
			return  source.TMB_descriptionPath?source.TMB_descriptionPath.replace("../",WebServiceVO.BASE_WSDL):source.TMB_descriptionPath;	
		}	
		
		public function get TMB_SecurityOrgPath():String
		{
			return  source.TMB_SecurityOrgPath?source.TMB_SecurityOrgPath.replace("../",WebServiceVO.BASE_WSDL):source.TMB_SecurityOrgPath;	
		}	
		
		public function get TMB_FuncDivisionPath():String
		{
			return  source.TMB_FuncDivisionPath?source.TMB_FuncDivisionPath.replace("../",WebServiceVO.BASE_WSDL):source.TMB_FuncDivisionPath;	
		}	
		
		public function get TMB_EmergPath():String
		{
			return  source.TMB_EmergPath?source.TMB_EmergPath.replace("../",WebServiceVO.BASE_WSDL):source.TMB_EmergPath;	
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
		private var commandingHeightsIs:Boolean = false;
		public var CommandingHeights:ArrayCollection;		
		
		private var closeHandlesIs:Boolean = false;
		public var CloseHandles:ArrayCollection;		
		
		public var KeyUnits:ArrayCollection = new ArrayCollection;		
		public var Scenting:ArrayCollection = new ArrayCollection;		
		public var Traffic:ArrayCollection = new ArrayCollection;		
		public var Hazzard:ArrayCollection = new ArrayCollection;
		
		//信息
		public var Communicate:ArrayCollection = new ArrayCollection;
		public var Cabledrop:ArrayCollection = new ArrayCollection;
		public var Landing:ArrayCollection = new ArrayCollection;
		public var Windows:ArrayCollection = new ArrayCollection;
		public var Internalhigh:ArrayCollection = new ArrayCollection;
				
		//内部结构图
		//public var buildBitmapName:String;
		
		public var buildBitmap:Bitmap;
		
		public var floors:ArrayCollection = new ArrayCollection;
		
		//应急预案
		//public var contingencyPlans:String;
				
		public function BuildVO()
		{
		}
		
		public function Init(buildName:String):void
		{
			initBaseInfo(buildName);
		}
				
		private function initBaseInfo(buildName:String):void
		{
			send("InitBuild",onInitBaseInfo,buildName);
		}
		
		private function onInitBaseInfo(result:ArrayCollection):void
		{
			if(result.length == 0)
			{
				dispatchFault("101","没有找到建筑物信息！");
				return;
			}
			
			source = result[0];
			
			onComplete(BuildVO.INIT_BASEINFO);
			
			initCommandHeights();
			initCloseHandle();
		}
		
		private function initCommandHeights():void
		{
			send("InitCommandingHeights",onInitCommadHeight,this.TMB_ID);
			
			function onInitCommadHeight(result:ArrayCollection):void
			{
				CommandingHeights = new ArrayCollection;
				for each(var i:Object in result)
				{
					var command:CommandHeightVO = new CommandHeightVO(i);							
					command.addEventListener(Event.COMPLETE,onInitPics);
					command.addEventListener(FaultEvent.FAULT,onFault);						
					command.InitPics();
					
					CommandingHeights.addItem(command);
				}
				
				if(CommandingHeights.length == 0)
				{					
					commandingHeightsIs = true;
					
					onComplete(BuildVO.INIT_COMMANDHEIGHTS);
				}
			}
			
			function onInitPics(event:Event):void
			{
				var complete:Boolean = true;
				for each(var i:CommandHeightVO in CommandingHeights)
				{
					complete &&= i.pics;
				}
				
				if(complete)
				{
					commandingHeightsIs = true;
					
					onComplete(BuildVO.INIT_COMMANDHEIGHTS);
				}
			}
		}
			
		private function initCloseHandle():void
		{			
			send("InitClosedhandles",onInitClosedhandles,this.TMB_ID);
			
			function onInitClosedhandles(result:ArrayCollection):void
			{
				CloseHandles = new ArrayCollection;
				for each(var i:Object in result)
				{
					var closeHandle:ClosedhandleVO = new ClosedhandleVO(i);					
					closeHandle.addEventListener(Event.COMPLETE,onInitPics);
					closeHandle.addEventListener(FaultEvent.FAULT,onFault);						
					closeHandle.InitPics();
					
					CloseHandles.addItem(closeHandle);
				}
				
				if(CloseHandles.length == 0)
				{					
					closeHandlesIs = true;
					
					onComplete(BuildVO.INIT_CLOSEHANDLES);
				}
			}
			
			function onInitPics(event:Event):void
			{
				var complete:Boolean = true;
				for each(var i:ClosedhandleVO in CloseHandles)
				{
					complete &&= i.pics;
				}
				
				if(complete)
				{
					closeHandlesIs = true;
					
					onComplete(BuildVO.INIT_CLOSEHANDLES);
				}
			}
		}
		
		private function onComplete(name:String):void
		{
			dispatchEvent(new Event(name));
			
			if(
				this.commandingHeightsIs
				&& this.closeHandlesIs
			)
				dispatchEvent(new Event(Event.COMPLETE));
		}
		
		private function onFault(event:FaultEvent):void
		{
			dispatchEvent(event);
		}
	}
}