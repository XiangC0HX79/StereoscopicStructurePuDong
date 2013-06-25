package app.model
{
	import app.ApplicationFacade;
	import app.model.vo.BuildVO;
	import app.model.vo.ClosedHandlePicVO;
	import app.model.vo.ClosedHandleVO;
	import app.model.vo.CommandHeightPicVO;
	import app.model.vo.CommandHeightVO;
	import app.model.vo.ConfigVO;
	import app.model.vo.FireHydrantVO;
	import app.model.vo.FloorDetailVO;
	import app.model.vo.FloorPicVO;
	import app.model.vo.FloorVO;
	import app.model.vo.HazardVO;
	import app.model.vo.KeyUnitVO;
	import app.model.vo.ScentingVO;
	import app.model.vo.TaticalVO;
	import app.model.vo.TrafficVO;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class BuildProxy extends WebServiceProxy implements IProxy
	{
		public static const NAME:String = "BuildProxy";
		
		public function BuildProxy()
		{
			super(NAME, new BuildVO);
		}
		
		public function get build():BuildVO
		{
			return data as BuildVO;
		}
		
		public function Init(build:String):void
		{			
			send("InitBuild",onInitBaseInfo,build);
		}
		
		private function onInitBaseInfo(event:ResultEvent):void
		{			
			var arr:ArrayCollection = event.result.Tables.Table.Rows;
			
			if(arr.length == 0)
			{
				sendNotification(ApplicationFacade.NOTIFY_APP_ALERTERROR,"没有找到建筑物信息！");
				return;
			}
			
			setData(new BuildVO(arr[0]));
			
			ConfigVO.TMB_ID = build.TMB_ID;
			
			send("GetBitmapSize",onGetBuildBitmapSize,build.TMB_StereoPicPath);
		}
				
		private function onGetBuildBitmapSize(event:ResultEvent):void
		{
			var s:Array = event.result.split(' ');
			build.BitmapWidth = s[0];
			build.BitmapHeight = s[1];
			
			sendNotification(ApplicationFacade.NOTIFY_APP_LOADINGTEXT,"系统初始化：基础信息加载完成...");		
			
			sendNotification(ApplicationFacade.NOTIFY_INIT_BUILD,build);	
		}
	}
}