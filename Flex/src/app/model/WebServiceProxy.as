package app.model
{
	import app.ApplicationFacade;
	import app.model.vo.ConfigVO;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.GraphicsPathCommand;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import mx.rpc.AsyncToken;
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
				
		protected function send(name:String,listener:Function,...args):AsyncToken
		{
			var webService:WebService = new WebService;
			webService.loadWSDL(ConfigVO.BASE_URL + "Service.asmx?wsdl");
			
			var operation:Operation = webService.getOperation(name) as Operation;
			operation.addEventListener(ResultEvent.RESULT,listener);
			operation.addEventListener(FaultEvent.FAULT,onFault);
			operation.arguments = args;
			operation.resultFormat = "object";
			
			return operation.send();
		}
				
		private function onResult(event:ResultEvent):void
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
						event.token.listener(tables.Table.Rows);
					}
					if(tables.hasOwnProperty("Count"))
					{
						event.token.listener(tables.Count.Rows[0].Count);
					}
					else if(tables.hasOwnProperty("Error"))
					{							
						sendNotification(ApplicationFacade.NOTIFY_APP_ALERTERROR,"后台服务错误" + "\n" + tables.Error.Rows[0]["ErrorInfo"]);
					}
				}
				else
				{
					event.token.listener(event.result);
				}
			}
			else 
			{
				event.token.listener(event.result);
			}
		}
		
		private function onFault(event:FaultEvent):void
		{				
			sendNotification(ApplicationFacade.NOTIFY_APP_ALERTERROR,event.fault.faultString + "\n" + event.fault.faultDetail);
		}
		
		protected function load(url:String,listener:Function):Object
		{			
			var downloadURL:URLRequest = new URLRequest(encodeURI(url));	
			downloadURL.method = URLRequestMethod.POST;
			
			var urlLoader:URLLoader = new URLLoader;
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR,onError);
			urlLoader.addEventListener(Event.COMPLETE,completeHandler);				
			urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
			urlLoader.load(downloadURL);
			
			var token:Object = {};
			return token;
			
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
				listener(bitmap,token);
			}
									
			function onError(event:IOErrorEvent):void
			{					
				var sprite:Sprite = new Sprite;
				
				var coords:Vector.<Number> = new Vector.<Number>;
				var commands:Vector.<int> = new Vector.<int>;
				
				coords.push(0,0);
				commands.push(GraphicsPathCommand.MOVE_TO);
				
				coords.push(0,18);
				commands.push(GraphicsPathCommand.LINE_TO);
				
				coords.push(18,18);
				commands.push(GraphicsPathCommand.LINE_TO);
				
				coords.push(18,0);
				commands.push(GraphicsPathCommand.LINE_TO);
				
				coords.push(0,0);
				commands.push(GraphicsPathCommand.LINE_TO);
				
				coords.push(20,20);
				commands.push(GraphicsPathCommand.LINE_TO);
				
				coords.push(20,0);
				commands.push(GraphicsPathCommand.MOVE_TO);
				
				coords.push(0,20);
				commands.push(GraphicsPathCommand.LINE_TO);
				
				sprite.graphics.lineStyle(3,0xFF0000);
				sprite.graphics.drawPath(commands,coords);
				
				var bitmapData:BitmapData = new BitmapData(20,20,false,0xFFFFFF);
				bitmapData.draw(sprite);
				
				var bitmap:Bitmap = new Bitmap(bitmapData);  
				listener(bitmap,token);	
				
				if(ConfigVO.EDIT)
				{
					sendNotification(ApplicationFacade.NOTIFY_APP_ALERTERROR,"图片未找到。\n" + url);
				}
			}
		}
	}
}