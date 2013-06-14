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
				
		private function onInitIcon(result:ArrayCollection):void
		{
			for each(var i:Object in result)
			{
				var url:String = i.IconPath.replace("../",ConfigVO.BASE_URL);
				
				switch(i.IconID)
				{
					case "1":
						load(url,onLoadIconCommandHeight);
						break;
					
					case "2":
						load(url,onLoadIconCloseHandle);
						break;
					
					case "3":
						load(url,onLoadIconTraffic);
						break;
					
					case "6":
						load(url,onLoadIconFireHydrant);
						break;
					
					case "7":
						load(url,onLoadIconKeyUnit);
						break;
					
					case "8":
						load(url,onLoadIconScenting);
						break;
					
					case "9":
						load(url,onLoadIconImportExport);
						break;
				}
			}
		}
		
		private function onLoadIconCommandHeight(bitmap:Bitmap):void
		{			
			icons.IconCommandHeight = bitmap;
			
			onLoadBitmap();
		}		
				
		private function onLoadIconCloseHandle(bitmap:Bitmap):void
		{			
			icons.IconCloseHandle = bitmap;
			
			onLoadBitmap();
		}			
		
		private function onLoadIconTraffic(bitmap:Bitmap):void
		{			
			icons.IconTraffic = bitmap;
			
			onLoadBitmap();
		}		
		
		private function onLoadIconFireHydrant(bitmap:Bitmap):void
		{			
			icons.IconFireHydrant = bitmap;
			
			onLoadBitmap();
		}		
		
		private function onLoadIconKeyUnit(bitmap:Bitmap):void
		{			
			icons.IconKeyUnit = bitmap;
			
			onLoadBitmap();
		}		
		
		private function onLoadIconScenting(bitmap:Bitmap):void
		{			
			icons.IconScenting = bitmap;
			
			onLoadBitmap();
		}	
		
		private function onLoadIconImportExport(bitmap:Bitmap):void
		{			
			icons.IconImportExport = bitmap;
			
			onLoadBitmap();
		}
		
		private function onLoadBitmap():void
		{			
			if(
				icons.IconCommandHeight
				&& icons.IconCloseHandle
				&& icons.IconTraffic
				&& icons.IconFireHydrant
				&& icons.IconKeyUnit
				&& icons.IconScenting
			)
			{
				sendNotification(ApplicationFacade.NOTIFY_INIT_ICONS);
			}			
		}
	}
}