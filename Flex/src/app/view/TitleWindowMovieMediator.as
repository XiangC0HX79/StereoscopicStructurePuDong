package app.view
{
	import app.ApplicationFacade;
	import app.controller.WebServiceCommand;
	import app.view.components.TitleWindowMovie;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import mx.controls.MovieClipSWFLoader;
	import mx.managers.PopUpManager;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import spark.components.VideoPlayer;
	
	public class TitleWindowMovieMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "TitleWindowMovieMediator";
		
		public function TitleWindowMovieMediator()
		{
			super(NAME, new TitleWindowMovie);
			
			titleWindowMovie.addEventListener(TitleWindowMovie.WIN_CLOSE,onClose);
		}
		
		protected function get titleWindowMovie():TitleWindowMovie
		{
			return viewComponent as TitleWindowMovie;
		}
		
		private function onClose(event:Event):void
		{
			PopUpManager.removePopUp(titleWindowMovie);
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				ApplicationFacade.NOTIFY_TITLEWINDOW_MOVIE
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case ApplicationFacade.NOTIFY_TITLEWINDOW_MOVIE:					
					titleWindowMovie.source = notification.getBody() as String;	
					break;
			}
		}
	}
}