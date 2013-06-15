package app.model
{
	import app.ApplicationFacade;
	import app.model.vo.ConfigVO;
	import app.model.vo.IconsVO;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.ResultEvent;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class IconsProxy extends WebServiceProxy implements IProxy
	{		
		public static const NAME:String = "IconsProxy";
		
		public function IconsProxy()
		{
			super(NAME, new IconsVO);			
		}
		
		public function get icons():IconsVO
		{
			return data as IconsVO;
		}
				
		public function Init():void
		{
			send("InitIcon",onInitIcon);
		}
				
		private function onInitIcon(event:ResultEvent):void
		{
			for each(var i:Object in event.result.Tables.Table.Rows)
			{
				var url:String = i.IconPath.replace("../",ConfigVO.BASE_URL);
				var token:* = load(url,onLoadIcon);
				token.IconID = i.IconID;
			}
		}
		
		private function onLoadIcon(token:*):void
		{
			switch(token.IconID)
			{
				case "1":
					icons.IconCommandHeight = token.bitmap;
					break;
				
				case "2":
					icons.IconCloseHandle = token.bitmap;
					break;
				
				case "3":
					icons.IconTraffic = token.bitmap;
					break;
				
				case "41":
					icons.IconEletric = token.bitmap;
					break;
				
				case "42":
					icons.IconGas = token.bitmap;
					break;
				
				case "43":
					icons.IconCan = token.bitmap;
					break;
				
				case "6":
					icons.IconFireHydrant = token.bitmap;
					break;
				
				case "7":
					icons.IconKeyUnit = token.bitmap;
					break;
				
				case "8":
					icons.IconScenting = token.bitmap;
					break;
				
				case "9":
					icons.IconImportExport = token.bitmap;
					break;
				
				case "10":
					icons.IconVideo = token.bitmap;
					break;
			}
			
			if(
				icons.IconCommandHeight
				&& icons.IconCloseHandle
				&& icons.IconTraffic
				&& icons.IconEletric
				&& icons.IconGas
				&& icons.IconCan
				&& icons.IconFireHydrant
				&& icons.IconKeyUnit
				&& icons.IconScenting
				&& icons.IconImportExport
				&& icons.IconVideo
			)
			{
				sendNotification(ApplicationFacade.NOTIFY_APP_LOADINGTEXT,"系统初始化：图标加载完成...");	
				
				sendNotification(ApplicationFacade.NOTIFY_INIT_ICONS);
			}			
		}
	}
}