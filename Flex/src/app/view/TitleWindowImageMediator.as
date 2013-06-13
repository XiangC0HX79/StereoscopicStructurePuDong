package app.view
{
	import app.ApplicationFacade;
	import app.model.vo.ComponentVO;
	import app.model.vo.ConfigVO;
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
		
		public function TitleWindowImageMediator()
		{
			super(NAME, new TitleWindowImage);
						
			titleWindowImage.addEventListener(TitleWindowImage.VIDEO,onVideo);
		}
		
		protected function get titleWindowImage():TitleWindowImage
		{
			return viewComponent as TitleWindowImage;
		}
		
		private function onVideo(event:Event):void
		{
			sendNotification(ApplicationFacade.NOTIFY_TITLEWINDOW_MOVIE,titleWindowImage.video);
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
					titleWindowImage.video = notification.getBody()[0];
					titleWindowImage.medias = notification.getBody()[1];
					
					titleWindowImage.ImageIndex = 0;
					break;
			}
		}		
	}
}