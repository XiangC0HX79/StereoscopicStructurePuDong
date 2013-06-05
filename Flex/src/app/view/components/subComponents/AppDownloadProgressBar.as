package app.view.components.subComponents
{
	import flash.display.Bitmap;
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.geom.Matrix;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	import mx.core.BitmapAsset;
	import mx.events.FlexEvent;
	import mx.events.RSLEvent;
	import mx.preloaders.DownloadProgressBar;
	
	import org.bytearray.gif.player.GIFPlayer;
		
	public class AppDownloadProgressBar extends DownloadProgressBar
	{						
		private var progressText:TextField;
		
		public function AppDownloadProgressBar()
		{
			super();		
			
			progressText = new TextField();
		}		
		
		override public function set preloader(preloader:Sprite):void
		{			         
			//Listen for 正在下载
			preloader.addEventListener(ProgressEvent.PROGRESS, handleProgress);
			//Listen for 下载完成
			preloader.addEventListener(Event.COMPLETE, handleComplete);
			//Listen for 正在初始化
			preloader.addEventListener(FlexEvent.INIT_PROGRESS, handleInitProgress);
			//Listen for 初始化完成
			preloader.addEventListener(FlexEvent.INIT_COMPLETE, handleInitComplete);			
		}
									
		private function addProgressBarSprit():void
		{					
			var loaderWidth:Number = 190;
			var loaderHeight:Number = 14;
			//加载进度条
			var request:URLRequest = new URLRequest("assets/image/loading.gif"); 			
			var player:GIFPlayer = new GIFPlayer(); 			
			player.x = this.stage.stageWidth/2 -  loaderWidth / 2;
			player.y = this.stage.stageHeight/2 - loaderHeight / 2;			
			player.load(request); 			
			addChild(player);	
			
			//加载进度条文字			
			addChild(progressText);		
			progressText.width = loaderWidth;
			progressText.x = player.x;
			progressText.y = player.y + loaderHeight;
		}		
		
		private var _addProgressBarSprit:Boolean = false;
		private function handleProgress(event:ProgressEvent):void 
		{			
			if((!_addProgressBarSprit) && (this.stage.stageWidth != 0))
			{
				addProgressBarSprit();
				
				_addProgressBarSprit = true;
			}
			else if(this.stage.stageWidth == 0)
			{
				trace("stageWidth is 0!");
			}
			
			if(_addProgressBarSprit)
			{
				progressText.text = "下载程序文件：" + event.bytesLoaded;
			}
		}
		
		private function handleComplete(e:Event):void
		{
			progressText.text = "下载程序文件：文件下载完成 ！";
		}
		
		private var _initcount:Number = 0;
		private function handleInitProgress(e:FlexEvent):void
		{
			progressText.text="界面初始化：" + (++_initcount);
		}
		
		private function handleInitComplete(e:FlexEvent):void
		{      
			progressText.text="界面初始化：界面初始化完成！";   
			
			var timer:Timer = new Timer(100,1);
			timer.addEventListener(TimerEvent.TIMER, dispatchComplete);
			timer.start();
		}
		
		private function dispatchComplete(event:TimerEvent):void 
		{
			dispatchEvent(new Event(Event.COMPLETE));
		}
	}
} 