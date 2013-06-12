package app.controller
{
	import app.ApplicationFacade;
	import app.model.vo.ConfigVO;
	
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
			var imageName:String = note.getBody()[0];
			
			var loaderImageHandler:Function = note.getBody()[1];
						
			var url:String =  imageName.replace("../",ConfigVO.BASE_URL);
			
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
				
				var bitmap:Bitmap = new Bitmap(bitmapData);
				loaderImageHandler(bitmap);
			}
		}
	}
}