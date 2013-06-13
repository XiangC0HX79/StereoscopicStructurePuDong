package app.model
{
	import app.ApplicationFacade;
	import app.model.vo.ConfigVO;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.soap.Operation;
	import mx.rpc.soap.WebService;
	import mx.utils.ObjectProxy;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class WebServiceProxy extends Proxy implements IProxy
	{		
		public function WebServiceProxy(proxyName:String=null, data:Object=null)
		{
			super(proxyName, data);
		}
				
		protected function send(name:String,listener:Function,...args):void
		{
			var webService:WebService = new WebService;
			webService.loadWSDL(ConfigVO.BASE_URL + "Service.asmx?wsdl");
			
			var operation:Operation = webService.getOperation(name) as Operation;
			operation.addEventListener(ResultEvent.RESULT,onResult);
			operation.addEventListener(FaultEvent.FAULT,onFault);
			operation.arguments = args;
			operation.resultFormat = "object";
			operation.send();	
			
			function onResult(event:ResultEvent):void
			{									
				if(event.result == null)
					return;
				
				if(event.result is ObjectProxy)
				{
					if(event.result.hasOwnProperty("Tables"))
					{
						var tables:Object = event.result.Tables;
						if(tables.hasOwnProperty("Table"))
						{
							listener(tables.Table.Rows);
						}
						if(tables.hasOwnProperty("Count"))
						{
							listener(tables.Count.Rows[0].Count);
						}
						else if(tables.hasOwnProperty("Error"))
						{							
							sendNotification(ApplicationFacade.NOTIFY_APP_ALERTERROR,"后台服务错误" + "\n" + tables.Error.Rows[0]["ErrorInfo"]);
						}
					}
					else
					{
						listener(event.result);
					}
				}
				else 
				{
					listener(event.result);
				}
			}
			
			function onFault(event:FaultEvent):void
			{				
				sendNotification(ApplicationFacade.NOTIFY_APP_ALERTERROR,event.fault.faultString + "\n" + event.fault.faultDetail);
			}
		}
				
		protected function load(url:String,listener:Function):void
		{			
			var downloadURL:URLRequest = new URLRequest(encodeURI(url));	
			downloadURL.method = URLRequestMethod.POST;
			
			var urlLoader:URLLoader = new URLLoader;
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR,onError);
			urlLoader.addEventListener(Event.COMPLETE,completeHandler);				
			urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
			urlLoader.load(downloadURL);
			
			function completeHandler(event:Event):void   
			{   								
				var loader:Loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE,loaderCompleteHandler);  
				loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onError);  
				loader.loadBytes(event.currentTarget.data);
			}
			
			function loaderCompleteHandler(event:Event):void
			{							
				var bitmap:Bitmap = Bitmap((event.currentTarget as LoaderInfo).content);  
				listener(bitmap);
			}
									
			function onError(event:IOErrorEvent):void
			{					
				var text:TextField = new TextField;
				text.text = "未找到图片";
				
				var url2:String = url;
				while(url2.length > 30)
				{
					var trim:String = url.substr(0,30);
					text.appendText("\n" + trim);
					url2 = url2.substring(30);
				}
				text.appendText("\n" + url2);				
				text.width = 500;
				text.multiline = true;
				text.height = 400;
				
				var textFmt:TextFormat = new TextFormat;
				textFmt.size = 30;
				textFmt.bold = true;
				textFmt.color = 0x0;	
				
				text.setTextFormat(textFmt);
				
				var bitmapData:BitmapData = new BitmapData(500,400);
				bitmapData.draw(text);
				
				listener(new Bitmap(bitmapData));
			}
		}
	}
}