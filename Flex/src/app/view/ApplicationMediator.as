package app.view
{		
	import app.ApplicationFacade;
	import app.model.BuildProxy;
	import app.model.IconsProxy;
	import app.model.vo.ConfigVO;
	import app.view.components.TitleWindowFloor;
	import app.view.components.TitleWindowImage;
	import app.view.components.TitleWindowMovie;
	
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
	
	import spark.components.TitleWindow;
		
	public class ApplicationMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "ApplicationMediator";
		
		public function ApplicationMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
			
			facade.registerMediator(new AppLoadingBarMediator(application.appLoadingBar));			
			facade.registerMediator(new MainPanelMediator(application.mainPanel));
		}
		
		protected function get application():StereoscopicStructure
		{
			return viewComponent as StereoscopicStructure;
		}	
		
		override public function listNotificationInterests():Array
		{
			return [
				ApplicationFacade.NOTIFY_INIT_CONFIG,
				ApplicationFacade.NOTIFY_INIT_ICONS,
				ApplicationFacade.NOTIFY_INIT_BUILD,
				
				ApplicationFacade.NOTIFY_TITLEWINDOW_FLOOR,
				ApplicationFacade.NOTIFY_TITLEWINDOW_IMAGE,
				ApplicationFacade.NOTIFY_TITLEWINDOW_MOVIE,
				ApplicationFacade.NOTIFY_TITLEWINDOW_COMMAND,
				ApplicationFacade.NOTIFY_TITLEWINDOW_COMMAND_IMGLST,
				ApplicationFacade.NOTIFY_TITLEWINDOW_CLOSED_IMGLST,
				ApplicationFacade.NOTIFY_TITLEWINDOW_RESCUE,
				ApplicationFacade.NOTIFY_TITLEWINDOW_KEYUNIT,
				ApplicationFacade.NOTIFY_TITLEWINDOW_SCENTING,
				ApplicationFacade.NOTIFY_TITLEWINDOW_TRAFFIC,
				ApplicationFacade.NOTIFY_TITLEWINDOW_HAZARD,
				ApplicationFacade.NOTIFY_TITLEWINDOW_TATICS,
				ApplicationFacade.NOTIFY_TITLEWINDOW_TATICALPOINT
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case ApplicationFacade.NOTIFY_INIT_CONFIG:
					ConfigVO.EDIT = false;//(application.parameters.edit == "1");
					
					var iconsProxy:IconsProxy = facade.retrieveProxy(IconsProxy.NAME) as IconsProxy;
					iconsProxy.Init();
					break;
				
				case ApplicationFacade.NOTIFY_INIT_ICONS:
					var buildProxy:BuildProxy = facade.retrieveProxy(BuildProxy.NAME) as BuildProxy;
					buildProxy.Init(application.parameters.build);
					break;
				
				case ApplicationFacade.NOTIFY_INIT_BUILD:
					sendNotification(ApplicationFacade.NOTIFY_INIT_APP,notification.getBody());
					break;
				
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
				
				case ApplicationFacade.NOTIFY_TITLEWINDOW_COMMAND:					
					popup = facade.retrieveMediator(TitleWindowCommandHeightMediator.NAME).getViewComponent() as IFlexDisplayObject;
					PopUpManager.addPopUp(popup,this.application,true);
					break;
				
				case ApplicationFacade.NOTIFY_TITLEWINDOW_COMMAND_IMGLST:					
					popup = facade.retrieveMediator(TitleWindowCommandHeightPicMediator.NAME).getViewComponent() as IFlexDisplayObject;
					PopUpManager.addPopUp(popup,this.application,true);
					PopUpManager.centerPopUp(popup);
					break;
				
				case ApplicationFacade.NOTIFY_TITLEWINDOW_CLOSED_IMGLST:				
					popup = facade.retrieveMediator(TitleWindowClosedHandlesPicMediator.NAME).getViewComponent() as IFlexDisplayObject;
					PopUpManager.addPopUp(popup,this.application,true);
					PopUpManager.centerPopUp(popup);
					break;
				
				case ApplicationFacade.NOTIFY_TITLEWINDOW_RESCUE:			
					popup = facade.retrieveMediator(TitleWindowRescueImgMediator.NAME).getViewComponent() as IFlexDisplayObject;
					PopUpManager.addPopUp(popup,this.application,true);
					break;
				
				case ApplicationFacade.NOTIFY_TITLEWINDOW_KEYUNIT:	
					popup = facade.retrieveMediator(TitleWindowKeyUnitMediator.NAME).getViewComponent() as IFlexDisplayObject;
					PopUpManager.addPopUp(popup,this.application,true);
					break;
				
				case ApplicationFacade.NOTIFY_TITLEWINDOW_SCENTING:
					popup = facade.retrieveMediator(TitleWindowScentingMediator.NAME).getViewComponent() as IFlexDisplayObject;
					PopUpManager.addPopUp(popup,this.application,true);
					break;
				
				case ApplicationFacade.NOTIFY_TITLEWINDOW_TRAFFIC:
					popup = facade.retrieveMediator(TitleWindowTrafficMediator.NAME).getViewComponent() as IFlexDisplayObject;
					PopUpManager.addPopUp(popup,this.application,true);
					break;
				
				case ApplicationFacade.NOTIFY_TITLEWINDOW_HAZARD:
					popup = facade.retrieveMediator(TitleWindowHazardMediator.NAME).getViewComponent() as IFlexDisplayObject;
					PopUpManager.addPopUp(popup,this.application,true);
					break;
				
				case ApplicationFacade.NOTIFY_TITLEWINDOW_TATICS:
					popup = facade.retrieveMediator(TitleWindowTaticsMediator.NAME).getViewComponent() as IFlexDisplayObject;
					PopUpManager.addPopUp(popup,this.application,true);
					break;
				
				case ApplicationFacade.NOTIFY_TITLEWINDOW_TATICALPOINT:
					popup = facade.retrieveMediator(TitleWindowTaticalPointMediator.NAME).getViewComponent() as IFlexDisplayObject;
					PopUpManager.addPopUp(popup,this.application,true);
					PopUpManager.centerPopUp(popup);
					break;
			}
		}	
	}
}