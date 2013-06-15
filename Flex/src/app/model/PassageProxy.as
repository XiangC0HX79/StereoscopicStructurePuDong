package app.model
{
	import app.ApplicationFacade;
	import app.model.vo.ConfigVO;
	import app.model.vo.ImportExportPicVO;
	import app.model.vo.ImportExportVO;
	import app.model.vo.PassageVO;
	import app.model.vo.VideoVO;
	
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.ResultEvent;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class PassageProxy extends WebServiceProxy implements IProxy
	{
		public static const NAME:String = "PassageProxy";
		
		public function PassageProxy()
		{
			super(NAME, new Dictionary);
		}
		
		public function get dict():Dictionary
		{
			return data as Dictionary
		}
		
		public function get ArrPlan():ArrayCollection
		{
			var arr:Array = new Array;
			for each(var psg:PassageVO in dict)
			{
				if(psg.T_PassageType == 1)
					arr.push(psg);
			}
			
			return new ArrayCollection(arr);
		}
				
		public function get ArrUnderGround():ArrayCollection
		{
			var arr:Array = new Array;
			for each(var psg:PassageVO in dict)
			{
				if(psg.T_PassageType == 2)
					arr.push(psg);
			}
			
			return new ArrayCollection(arr);
		}
		
		public function get ArrGround():ArrayCollection
		{
			var arr:Array = new Array;
			for each(var psg:PassageVO in dict)
			{
				if(psg.T_PassageType == 3)
					arr.push(psg);
			}
			
			return new ArrayCollection(arr);
		}
		
		public function get ArrTopFloor():ArrayCollection
		{
			var arr:Array = new Array;
			for each(var psg:PassageVO in dict)
			{
				if(psg.T_PassageType == 4)
					arr.push(psg);
			}
			
			return new ArrayCollection(arr);
		}
		
		public function get ArrFreshAir():ArrayCollection
		{
			var arr:Array = new Array;
			for each(var psg:PassageVO in dict)
			{
				if(psg.T_PassageType == 5)
					arr.push(psg);
			}
			
			return new ArrayCollection(arr);
		}
		
		public function get ArrSpecial():ArrayCollection
		{
			var arr:Array = new Array;
			for each(var psg:PassageVO in dict)
			{
				if(psg.T_PassageType == 6)
					arr.push(psg);
			}
			
			return new ArrayCollection(arr);
		}
		
		public function Init():void
		{
			send("InitPassage",onInitPassage,ConfigVO.TMB_ID);			
		}
		
		private function onInitPassage(event:ResultEvent):void
		{
			for each(var i:Object in event.result.Tables.Table.Rows)
			{
				var psg:PassageVO = new PassageVO(i);				
				dict[psg.T_PassageID] = psg;
			}
			
			sendNotification(ApplicationFacade.NOTIFY_APP_LOADINGTEXT,"系统初始化：通道信息加载完成...");
			
			send("InitImportExport",onInitImportExport,ConfigVO.TMB_ID);
		}
		
		private function onInitImportExport(event:ResultEvent):void
		{			
			for each(var i:Object in event.result.Tables.Table.Rows)
			{
				var ie:ImportExportVO = new ImportExportVO(i);	
				
				var psg:PassageVO = dict[ie.T_PassageID];
				if(psg)
					psg.DictImportExport[ie.T_ImportExportID] = ie;
			}
			
			sendNotification(ApplicationFacade.NOTIFY_APP_LOADINGTEXT,"系统初始化：出入口信息加载完成...");
			
			send("InitImportExportPic",onInitImportExportPic,ConfigVO.TMB_ID);
		}
		
		private function onInitImportExportPic(event:ResultEvent):void
		{			
			for each(var i:Object in event.result.Tables.Table.Rows)
			{
				var iep:ImportExportPicVO = new ImportExportPicVO(i);	
				
				var psg:PassageVO = dict[iep.T_PassageID];
				if(psg)
				{
					var ie:ImportExportVO = psg.DictImportExport[iep.containerID];
					
					if(ie)
						ie.DictImportExportPic[iep.mediaID] = iep;
				}
			}
			
			sendNotification(ApplicationFacade.NOTIFY_APP_LOADINGTEXT,"系统初始化：出入口图片加载完成...");
			
			send("InitVideo",onInitVideo,ConfigVO.TMB_ID);
		}
		
		private function onInitVideo(event:ResultEvent):void
		{			
			for each(var i:Object in event.result.Tables.Table.Rows)
			{
				var video:VideoVO = new VideoVO(i);	
				
				var psg:PassageVO = dict[video.T_PassageID];
				if(psg)
				{
					psg.dictVideo[video.T_VideoID] = video;
				}
			}
			
			sendNotification(ApplicationFacade.NOTIFY_APP_LOADINGTEXT,"系统初始化：视频信息加载完成...");
			
			sendNotification(ApplicationFacade.NOTIFY_INIT_PASSAGE);
		}
	}
}