package app.model
{
	import app.ApplicationFacade;
	import app.model.vo.ConfigVO;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class ConfigProxy extends Proxy implements IProxy
	{
		public static const NAME:String = "ConfigProxy";
		
		public function ConfigProxy()
		{
			super(NAME, new ConfigVO);
						
			var load:URLLoader = new URLLoader(new URLRequest("config.xml"));			
			load.addEventListener(Event.COMPLETE,onLocaleConfigResult);
			load.addEventListener(IOErrorEvent.IO_ERROR,onIOError);
		}
		
		public function get config():ConfigVO
		{
			return data as ConfigVO;
		}
		
		private function onIOError(event:IOErrorEvent):void
		{
			sendNotification(ApplicationFacade.NOTIFY_APP_ALERTERROR,event.text);
		}
		
		private function onLocaleConfigResult(event:Event):void
		{				
			try
			{
				var xml:XML = new XML(event.currentTarget.data);
			}
			catch(e:Object)
			{
				trace(e);
			}
			
			if(xml == null)
			{
				sendNotification(ApplicationFacade.NOTIFY_APP_ALERTERROR,"配置文件损坏，请检查config.xml文件正确性！");
				
				sendNotification(ApplicationFacade.NOTIFY_APP_LOADINGTEXT,"程序初始化：配置文件损坏，请检查config.xml文件正确性！");	
				
				return;
			}
			
			ConfigVO.BASE_URL = xml.WebServiceUrl;
			sendNotification(ApplicationFacade.NOTIFY_INIT_CONFIG);
		}
	}
}