package app.view
{
	import app.ApplicationFacade;
	import app.model.vo.BuildVO;
	import app.model.vo.ConfigVO;
	import app.view.components.MainPanel;
	
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import mx.controls.Button;
	import mx.core.IVisualElement;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class MainPanelMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "MainPanelMediator";
		
		public function MainPanelMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
			
			mainPanel.addEventListener(MainPanel.SURROUNDING,onSurrounding);
			mainPanel.addEventListener(MainPanel.INFO,onInfo);
			mainPanel.addEventListener(MainPanel.PASSAGE,onPassage);
			mainPanel.addEventListener(MainPanel.STEREOSCOPIC,onStereoScopic);
			mainPanel.addEventListener(MainPanel.EMERGENCY,onEmergency);
		}
		
		protected function get mainPanel():MainPanel
		{
			return viewComponent as MainPanel;
		}
		
		private function contentGroupAddElement(mediator:String):void
		{			
			mainPanel.ContentGroup.removeAllElements();
			
			var element:IVisualElement = facade.retrieveMediator(mediator).getViewComponent() as IVisualElement;
			
			mainPanel.ContentGroup.addElement(element);
		}
		
		private function onSurrounding(event:Event):void
		{
			sendNotification(ApplicationFacade.NOTIFY_SHOW_INFO,false);
			
			mainPanel.Menu.addElementAt(facade.retrieveMediator(MenuSurroundingMediator.NAME).getViewComponent() as IVisualElement,mainPanel.ButtonIndex + 1);
			
			contentGroupAddElement(PanelSurroundingMediator.NAME);
		}
		
		private function onInfo(event:Event):void
		{
			sendNotification(ApplicationFacade.NOTIFY_SHOW_INFO,false);
			
			mainPanel.Menu.addElementAt(facade.retrieveMediator(MenuInfoMediator.NAME).getViewComponent() as IVisualElement,mainPanel.ButtonIndex + 1);
		}
		
		private function onPassage(event:Event):void
		{
			sendNotification(ApplicationFacade.NOTIFY_SHOW_INFO,false);
			
			mainPanel.Menu.addElementAt(facade.retrieveMediator(MenuPassageMediator.NAME).getViewComponent() as IVisualElement,mainPanel.ButtonIndex + 1);
			
			contentGroupAddElement(PanelPassageMediator.NAME);
		}
		
		private function onStereoScopic(event:Event):void
		{
			sendNotification(ApplicationFacade.NOTIFY_SHOW_INFO,false);
			
			if(ConfigVO.EDIT)
			{
				mainPanel.Menu.addElementAt(facade.retrieveMediator(MenuStereoScopicEditMediator.NAME).getViewComponent() as IVisualElement,mainPanel.ButtonIndex + 1);
			}
			else
			{
				mainPanel.Menu.addElementAt(facade.retrieveMediator(MenuStereoScopicStructureMediator.NAME).getViewComponent() as IVisualElement,mainPanel.ButtonIndex + 1);
			}
			
			contentGroupAddElement(PanelStereoScopicStructureMediator.NAME);
		}
		
		private function onEmergency(event:Event):void
		{			
			if(mainPanel.Build.TMB_EmergPath)
				flash.net.navigateToURL(new URLRequest(mainPanel.Build.TMB_EmergPath));
			else
				sendNotification(ApplicationFacade.NOTIFY_SHOW_INFO,true);
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				ApplicationFacade.NOTIFY_INIT_BUILD,
				
				ApplicationFacade.NOTIFY_SHOW_INFO
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case ApplicationFacade.NOTIFY_INIT_BUILD:
					mainPanel.Build = notification.getBody() as BuildVO;
										
					contentGroupAddElement(PanelSurroundingMediator.NAME);
					break;
				
				case ApplicationFacade.NOTIFY_SHOW_INFO:
					var visible:Boolean = notification.getBody() as Boolean;
					mainPanel.groupNoInfo.visible = visible;
					break;
			}
		}
	}
}