package app.view
{		
	import app.ApplicationFacade;
	import app.view.components.TitleWindowMovie;
	import app.view.components.TitleWindowFloor;
	import app.view.components.TitleWindowImage;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.Timer;
	
	import mx.controls.ToolTip;
	import mx.core.IFlexDisplayObject;
	import mx.events.ResizeEvent;
	import mx.managers.PopUpManager;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
		
	public class ApplicationMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "ApplicationMediator";
		
		public function ApplicationMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
									
			facade.registerMediator(new AppAlertMediator);
			
			facade.registerMediator(new AppLoadingBarMediator(application.appLoadingBar));
			
			facade.registerMediator(new MainPanelMediator(application.mainPanel));
			
			facade.registerMediator(new TitleWindowFloorMediator(new TitleWindowFloor));
			facade.registerMediator(new TitleWindowImageMediator(new TitleWindowImage));			
			facade.registerMediator(new TitleWindowMovieMediator(new TitleWindowMovie));
		}
		
		protected function get application():StereoscopicStructure
		{
			return viewComponent as StereoscopicStructure;
		}	
		
		override public function listNotificationInterests():Array
		{
			return [
				ApplicationFacade.NOTIFY_TITLEWINDOW_FLOOR,
				ApplicationFacade.NOTIFY_TITLEWINDOW_IMAGE,
				ApplicationFacade.NOTIFY_TITLEWINDOW_MOVIE			
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case ApplicationFacade.NOTIFY_TITLEWINDOW_FLOOR:
					var popup:IFlexDisplayObject = facade.retrieveMediator(TitleWindowFloorMediator.NAME).getViewComponent() as IFlexDisplayObject;
					PopUpManager.addPopUp(popup,this.application,false);
					break;
				
				case ApplicationFacade.NOTIFY_TITLEWINDOW_IMAGE:
					popup = facade.retrieveMediator(TitleWindowImageMediator.NAME).getViewComponent() as IFlexDisplayObject;
					PopUpManager.addPopUp(popup,this.application,true);
					PopUpManager.centerPopUp(popup);
					break;
				
				case ApplicationFacade.NOTIFY_TITLEWINDOW_MOVIE:
					popup = facade.retrieveMediator(TitleWindowMovieMediator.NAME).getViewComponent() as IFlexDisplayObject;
					PopUpManager.addPopUp(popup,this.application,true);
					PopUpManager.centerPopUp(popup);
					break;
			}
		}	
	}
}