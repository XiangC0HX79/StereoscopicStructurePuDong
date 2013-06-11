package app.model.vo
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	[Bindable]
	public class IconVO implements IEventDispatcher
	{		
		public static var BASE_URL:String = "";
		
		public var icon:Bitmap;
		
		protected var _listener:EventDispatcher;  
		
		protected var _loader:Loader;
		
		public function IconVO()
		{
			_listener = new EventDispatcher(this);  
		}
		
		public function load(url:String):void
		{			
			var u:String = url.replace("../",IconVO.BASE_URL);
			
			var urlRequest:URLRequest = new URLRequest(encodeURI(u))
			
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onError);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,loaderCompleteHandler);   
			loader.load(urlRequest);
			
			function loaderCompleteHandler(event:Event):void
			{							
				var loaderInfo:LoaderInfo = event.currentTarget as LoaderInfo;
				
				var bitmap:Bitmap = Bitmap(loaderInfo.content);
				
				onLoad(bitmap);
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
				onLoad(bitmap);
			}
		}
		
		private function onLoad(bitmap:Bitmap):void
		{
			icon = bitmap;
			
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public function hasEventListener(type:String):Boolean 
		{            
			return _listener.hasEventListener(type);        
		}               
		
		public function willTrigger(type:String):Boolean 
		{            
			return _listener.willTrigger(type);        
		}               
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean=false,priority:int=0.0, useWeakReference:Boolean=false):void        
		{            
			_listener.addEventListener(type, listener, useCapture,priority, useWeakReference);        
		}               
		
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void        
		{           
			_listener.removeEventListener(type, listener, useCapture);        
		}               
		
		public function dispatchEvent(event:Event):Boolean 
		{            
			return _listener.dispatchEvent(event);        
		} 
	}
}