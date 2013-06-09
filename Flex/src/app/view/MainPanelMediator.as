package app.view
{
	import app.ApplicationFacade;
	import app.model.BuildProxy;
	import app.view.components.MainPanel;
	
	import flash.events.Event;
	
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
			mainPanel.addEventListener(MainPanel.STEREOSCOPIC,onStereoScopic);
		}
		
		protected function get mainPanel():MainPanel
		{
			return viewComponent as MainPanel;
		}
		
		private function contentGroupAddElement(mediatorName:String):void
		{			
			mainPanel.ContentGroup.removeAllElements();
			
			var element:IVisualElement = facade.retrieveMediator(mediatorName).getViewComponent() as IVisualElement;
			mainPanel.ContentGroup.addElement(element);
			
			mainPanel.ContentGroup.validateNow();
			
			if(element.width > mainPanel.ContentGroup.width)
				mainPanel.ContentGroup.horizontalScrollPosition = (element.width - mainPanel.ContentGroup.width) / 2;
			
			if(element.height > mainPanel.ContentGroup.height)
				mainPanel.ContentGroup.verticalScrollPosition = (element.height - mainPanel.ContentGroup.height) / 2;
		}
		
		private function onSurrounding(event:Event):void
		{
			mainPanel.Menu.addElementAt(facade.retrieveMediator(MenuSurroundingMediator.NAME).getViewComponent() as IVisualElement,mainPanel.ButtonIndex + 1);
			
			contentGroupAddElement(PanelSurroundingMediator.NAME);
		}
		
		private function onInfo(event:Event):void
		{
			mainPanel.Menu.addElementAt(facade.retrieveMediator(MenuInfoMediator.NAME).getViewComponent() as IVisualElement,mainPanel.ButtonIndex + 1);
		}
		
		private function onStereoScopic(event:Event):void
		{
			mainPanel.Menu.addElementAt(facade.retrieveMediator(MenuStereoScopicStructureMediator.NAME).getViewComponent() as IVisualElement,mainPanel.ButtonIndex + 1);
			
			contentGroupAddElement(PanelStereoScopicStructureMediator.NAME);
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				ApplicationFacade.NOTIFY_APP_INIT
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case ApplicationFacade.NOTIFY_APP_INIT:
					var buildProxy:BuildProxy = facade.retrieveProxy(BuildProxy.NAME) as BuildProxy;
					mainPanel.Build = buildProxy.build;
					
					contentGroupAddElement(PanelSurroundingMediator.NAME);
					break;
			}
		}
	}
}