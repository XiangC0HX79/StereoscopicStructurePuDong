package app.view
{		
	import app.ApplicationFacade;
	import app.model.BuildProxy;
	import app.model.ClosedHandleProxy;
	import app.model.CommandHeightProxy;
	import app.model.FireHydrantProxy;
	import app.model.HazardProxy;
	import app.model.IconsProxy;
	import app.model.KeyUnitProxy;
	import app.model.PassageProxy;
	import app.model.ScentingProxy;
	import app.model.TaticsProxy;
	import app.model.TrafficProxy;
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
				ApplicationFacade.NOTIFY_INIT_COMMANDHEIGHT,
				ApplicationFacade.NOTIFY_INIT_CLOSEDHANDLE,
				ApplicationFacade.NOTIFY_INIT_TRAFFIC,
				ApplicationFacade.NOTIFY_INIT_HAZZARD,
				ApplicationFacade.NOTIFY_INIT_FIREHYDRANT,
				ApplicationFacade.NOTIFY_INIT_KEYUNIT,
				ApplicationFacade.NOTIFY_INIT_SCENTING,
				ApplicationFacade.NOTIFY_INIT_TATICS,
				ApplicationFacade.NOTIFY_INIT_PASSAGE,
				
				ApplicationFacade.NOTIFY_TITLEWINDOW_MEDIA,
				ApplicationFacade.NOTIFY_TITLEWINDOW_FLOOR,
				ApplicationFacade.NOTIFY_TITLEWINDOW_IMAGE,
				ApplicationFacade.NOTIFY_TITLEWINDOW_MOVIE,
				ApplicationFacade.NOTIFY_TITLEWINDOW_COMMAND,
				ApplicationFacade.NOTIFY_TITLEWINDOW_RESCUE,
				ApplicationFacade.NOTIFY_TITLEWINDOW_KEYUNIT,
				ApplicationFacade.NOTIFY_TITLEWINDOW_SCENTING,
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
					ConfigVO.EDIT = (application.parameters.edit == "1");
					
					var iconsProxy:IconsProxy = facade.retrieveProxy(IconsProxy.NAME) as IconsProxy;
					iconsProxy.Init();
					break;
				
				case ApplicationFacade.NOTIFY_INIT_ICONS:
					var buildProxy:BuildProxy = facade.retrieveProxy(BuildProxy.NAME) as BuildProxy;
					buildProxy.Init(application.parameters.build);
					break;
				
				case ApplicationFacade.NOTIFY_INIT_BUILD:
					var commandHeightProxy:CommandHeightProxy = facade.retrieveProxy(CommandHeightProxy.NAME) as CommandHeightProxy;
					commandHeightProxy.Init();
					break;
				
				case ApplicationFacade.NOTIFY_INIT_COMMANDHEIGHT:	
					var closedHandleProxy:ClosedHandleProxy = facade.retrieveProxy(ClosedHandleProxy.NAME) as ClosedHandleProxy;
					closedHandleProxy.Init();	
					break;
				
				case ApplicationFacade.NOTIFY_INIT_CLOSEDHANDLE:
					var trafficProxy:TrafficProxy = facade.retrieveProxy(TrafficProxy.NAME) as TrafficProxy;
					trafficProxy.Init();	
					break;
				
				case ApplicationFacade.NOTIFY_INIT_TRAFFIC:
					var hazzardProxy:HazardProxy = facade.retrieveProxy(HazardProxy.NAME) as HazardProxy;
					hazzardProxy.Init();	
					break;
				
				case ApplicationFacade.NOTIFY_INIT_HAZZARD:
					var fireHydrantProxy:FireHydrantProxy = facade.retrieveProxy(FireHydrantProxy.NAME) as FireHydrantProxy;
					fireHydrantProxy.Init();
					break;
				
				case ApplicationFacade.NOTIFY_INIT_FIREHYDRANT:
					var keyUnitProxy:KeyUnitProxy = facade.retrieveProxy(KeyUnitProxy.NAME) as KeyUnitProxy;
					keyUnitProxy.Init();
					break;
				
				case ApplicationFacade.NOTIFY_INIT_KEYUNIT:
					var scentingProxy:ScentingProxy = facade.retrieveProxy(ScentingProxy.NAME) as ScentingProxy;
					scentingProxy.Init();
					break;
				
				case ApplicationFacade.NOTIFY_INIT_SCENTING:
					var taticsProxy:TaticsProxy = facade.retrieveProxy(TaticsProxy.NAME) as TaticsProxy;
					taticsProxy.Init();
					break;
				
				case ApplicationFacade.NOTIFY_INIT_TATICS:
					var passage:PassageProxy = facade.retrieveProxy(PassageProxy.NAME) as PassageProxy;
					passage.Init();
					break;
				
				case ApplicationFacade.NOTIFY_INIT_PASSAGE:
					var buildProxy:BuildProxy = facade.retrieveProxy(BuildProxy.NAME) as BuildProxy;					
					sendNotification(ApplicationFacade.NOTIFY_INIT_APP,buildProxy.build);
					break;
				
				
				case ApplicationFacade.NOTIFY_TITLEWINDOW_MEDIA:					
					popup = facade.retrieveMediator(TitleWindowMediaMediator.NAME).getViewComponent() as IFlexDisplayObject;
					PopUpManager.addPopUp(popup,this.application,true);
					PopUpManager.centerPopUp(popup);
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