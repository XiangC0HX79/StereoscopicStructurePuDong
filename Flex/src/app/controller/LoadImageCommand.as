package app.controller
{
	import app.ApplicationFacade;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.engine.GraphicElement;
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import spark.components.Label;
		
	public class LoadImageCommand extends SimpleCommand implements ICommand
	{
		override public function execute(note:INotification):void
		{			 		
			//sendNotification(ApplicationFacade.NOTIFY_APP_LOADINGSHOW,"正在加载图片...");
			
			var imageName:String = note.getBody()[0];
			
			var loaderImageHandler:Function = note.getBody()[1];
			
			var url:String =  imageName.replace("../",WebServiceCommand.WSDL);
			
			var urlRequest:URLRequest = new URLRequest(encodeURI(url))
			
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onError);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,loaderCompleteHandler);   
			loader.load(urlRequest);
			
			function loaderCompleteHandler(event:Event):void
			{							
				var loaderInfo:LoaderInfo = event.currentTarget as LoaderInfo;
				
				var bitmap:Bitmap = Bitmap(loaderInfo.content);
				
				loaderImageHandler(bitmap);
				
				//sendNotification(ApplicationFacade.NOTIFY_APP_LOADINGHIDE);
			}
			
			function onError(event:IOErrorEvent):void
			{					
				var text:TextField = new TextField;
				text.text = "未找到图片";
				//text.autoSize = TextFieldAutoSize.CENTER;
				text.width = 500;
				text.height = 400;
				
				var textFmt:TextFormat = new TextFormat;
				textFmt.size = 30;
				textFmt.bold = true;
				textFmt.color = 0x0;	
								
				text.setTextFormat(textFmt);
				
				var bitmapData:BitmapData = new BitmapData(500,400);
				bitmapData.draw(text);
				
				var bitmap:Bitmap = new Bitmap(bitmapData);
				loaderImageHandler(bitmap);
				
				//sendNotification(ApplicationFacade.NOTIFY_APP_LOADINGHIDE);
			}
		}
	}
}