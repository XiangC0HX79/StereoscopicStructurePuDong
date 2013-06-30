package app.model
{
	import app.ApplicationFacade;
	import app.model.vo.ConfigVO;
	import app.model.vo.CursorVO;
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
	import mx.core.BitmapAsset;
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
				var token:Object = load(url,onLoadIcon);
				token.IconID = i.IconID;
			}
		}
		
		private function onLoadIcon(bitmap:Bitmap,token:Object):void
		{
			switch(token.IconID)
			{
				case "1":
					icons.IconCommandHeight = bitmap;
					break;
				
				case "2":
					icons.IconCloseHandle = bitmap;
					break;
				
				case "3":
					icons.IconTraffic = bitmap;
					break;
				
				case "41":
					icons.IconEletric = bitmap;
					break;
				
				case "42":
					icons.IconGas = bitmap;
					break;
				
				case "43":
					icons.IconCan = bitmap;
					break;
				
				case "6":
					icons.IconFireHydrant = bitmap;
					break;
				
				case "7":
					icons.IconKeyUnit = bitmap;
					break;
				
				case "8":
					icons.IconScenting = bitmap;
					break;
				
				case "9":
					icons.IconImportExport = bitmap;
					break;
				
				case "10":
					icons.IconVideo = bitmap;
					break;
				
				case "c2":
					icons.CursorVideoAdd = bitmap;
					break;
				
				case "c3":
					icons.CursorVideoDel = bitmap;
					break;
				
				case "c4":
					icons.CursorFireAdd = bitmap;
					break;
				
				case "c5":
					icons.CursorFireDel = bitmap;
					break;
				
				case "m0":
					icons.MenuDefault = bitmap;
					break;
				
				case "m1":
					icons.MenuSave = bitmap;
					break;
				
				case "m2":
					icons.MenuFireAdd = bitmap;
					break;
				
				case "m3":
					icons.MenuFireDel = bitmap;
					break;
				
				case "m4":
					icons.MenuClosedAdd = bitmap;
					break;
				
				case "m5":
					icons.MenuClosedDel = bitmap;
					break;
				
				case "m6":
					icons.MenuScentingAdd = bitmap;
					break;
				
				case "m7":
					icons.MenuScentingDel = bitmap;
					break;
				
				case "m8":
					icons.MenuVideoAdd = bitmap;
					break;
				
				case "m9":
					icons.MenuVideoDel = bitmap;
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
				
				&& icons.CursorFireAdd
				&& icons.CursorFireDel
				&& icons.CursorVideoAdd
				&& icons.CursorVideoDel
				
				&& icons.MenuClosedAdd
				&& icons.MenuClosedDel
				&& icons.MenuDefault
				&& icons.MenuFireAdd
				&& icons.MenuFireDel
				&& icons.MenuSave
				&& icons.MenuScentingAdd
				&& icons.MenuScentingDel
				&& icons.MenuVideoAdd
				&& icons.MenuVideoDel
			)
			{
				sendNotification(ApplicationFacade.NOTIFY_APP_LOADINGTEXT,"系统初始化：图标加载完成...");	
				
				sendNotification(ApplicationFacade.NOTIFY_INIT_ICONS,icons);
			}			
		}	
	}
}