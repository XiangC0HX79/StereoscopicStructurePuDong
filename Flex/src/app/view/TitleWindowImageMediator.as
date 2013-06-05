package app.view
{
	import app.ApplicationFacade;
	import app.controller.WebServiceCommand;
	import app.model.vo.ComponentVO;
	import app.model.vo.MediaVO;
	import app.view.components.TitleWindowImage;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	
	import mx.collections.ArrayCollection;
	import mx.events.CloseEvent;
	import mx.events.FlexEvent;
	import mx.managers.PopUpManager;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import spark.components.Button;
	
	public class TitleWindowImageMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "TitleWindowImageMediator";
		
		public function TitleWindowImageMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
			
			titleWindowImage.addEventListener(TitleWindowImage.WIN_CLOSE,onClose);
			
			titleWindowImage.addEventListener(TitleWindowImage.PREIMAGE,onPreImage);
			titleWindowImage.addEventListener(TitleWindowImage.NEXTIMAGE,onNextImage);
			
			titleWindowImage.addEventListener(TitleWindowImage.VIDEO,onVideo);
		}
		
		protected function get titleWindowImage():TitleWindowImage
		{
			return viewComponent as TitleWindowImage;
		}
				
		private function onClose(event:Event):void
		{
			PopUpManager.removePopUp(titleWindowImage);
		}
		
		private function onPreImage(event:Event):void
		{
			if(titleWindowImage.indexImage > 0)
				titleWindowImage.indexImage --;
			
			titleWindowImage.imagePre.enabled = (titleWindowImage.indexImage > 0);
			
			titleWindowImage.media = titleWindowImage.component.listMedia[titleWindowImage.indexImage] as MediaVO;
						
			//loadImage(titleWindowImage.media.mediaBimapName,loaderImageHandler);		
			sendNotification(ApplicationFacade.NOTIFY_COMMAND_LOADIMAGE,[titleWindowImage.media.mediaBimapName,loaderImageHandler]);
		}
		
		private function onNextImage(event:Event):void
		{
			if(titleWindowImage.indexImage < titleWindowImage.component.listMedia.length - 1)
				titleWindowImage.indexImage ++;
			
			titleWindowImage.imageNext.enabled = (titleWindowImage.indexImage < titleWindowImage.component.listMedia.length - 1);
			
			titleWindowImage.media = titleWindowImage.component.listMedia[titleWindowImage.indexImage] as MediaVO;
						
			//loadImage(titleWindowImage.media.mediaBimapName,loaderImageHandler);	
			sendNotification(ApplicationFacade.NOTIFY_COMMAND_LOADIMAGE,[titleWindowImage.media.mediaBimapName,loaderImageHandler]);
		}
		
		private function onVideo(event:Event):void
		{
			sendNotification(ApplicationFacade.NOTIFY_TITLEWINDOW_MOVIE,titleWindowImage.component.videoName);
		}
		
		private function loadImage(imageName:String,loaderImageHandler:Function):void
		{			
			sendNotification(ApplicationFacade.NOTIFY_APP_LOADINGSHOW,"正在加载图片...");
			
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
				
				sendNotification(ApplicationFacade.NOTIFY_APP_LOADINGHIDE);
			}
			
			function onError(event:IOErrorEvent):void
			{						
				var bitmap:Bitmap = new Bitmap(new BitmapData(500,400));
				
				loaderImageHandler(bitmap);
			}
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				ApplicationFacade.NOTIFY_TITLEWINDOW_IMAGE
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case ApplicationFacade.NOTIFY_TITLEWINDOW_IMAGE:
					titleWindowImage.component = notification.getBody() as ComponentVO;
										
					titleWindowImage.indexImage = 0;
					
					titleWindowImage.media = titleWindowImage.component.listMedia[titleWindowImage.indexImage] as MediaVO;
										
					//loadImage(titleWindowImage.media.mediaBimapName,loaderImageHandler);	
					sendNotification(ApplicationFacade.NOTIFY_COMMAND_LOADIMAGE,[titleWindowImage.media.mediaBimapName,loaderImageHandler]);
					break;
			}
		}
		
		private function loaderImageHandler(bitmap:Bitmap):void
		{			
			titleWindowImage.imagePre.enabled = (titleWindowImage.indexImage > 0);
			
			titleWindowImage.imageNext.enabled = (titleWindowImage.indexImage < titleWindowImage.component.listMedia.length - 1);
			
			titleWindowImage.media.mediaBimap = bitmap;
			
			if((titleWindowImage.component.videoName == "")
				&& titleWindowImage.groupBottom.containsElement(titleWindowImage.imageVideo))
			{
				titleWindowImage.groupBottom.removeElement(titleWindowImage.imageVideo);
			}
			else if((titleWindowImage.component.videoName != "")
				&& !titleWindowImage.groupBottom.containsElement(titleWindowImage.imageVideo))
			{
				titleWindowImage.groupBottom.addElementAt(titleWindowImage.imageVideo,0);
			}
		}
	}
}