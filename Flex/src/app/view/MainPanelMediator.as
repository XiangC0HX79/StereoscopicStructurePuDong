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
			mainPanel.addEventListener(MainPanel.STEREOSCOPIC,onStereoScopic);
		}
		
		protected function get mainPanel():MainPanel
		{
			return viewComponent as MainPanel;
		}
		
		private function onSurrounding(event:Event):void
		{
			mainPanel.Menu.addElementAt(facade.retrieveMediator(MenuSurroundingMediator.NAME).getViewComponent() as IVisualElement,mainPanel.ButtonIndex + 1);
		}
		
		private function onStereoScopic(event:Event):void
		{
			mainPanel.Menu.addElementAt(facade.retrieveMediator(MenuStereoScopicStructureMediator.NAME).getViewComponent() as IVisualElement,mainPanel.ButtonIndex + 1);
			
			mainPanel.ContentGroup.addElement(facade.retrieveMediator(PanelStereoScopicStructureMediator.NAME).getViewComponent() as IVisualElement);
			
			mainPanel.ContentGroup.validateNow();
			
			var buildProxy:BuildProxy = facade.retrieveProxy(BuildProxy.NAME) as BuildProxy;
			if(buildProxy.build.buildBitmap.width > mainPanel.ContentGroup.width)
				mainPanel.ContentGroup.horizontalScrollPosition = (buildProxy.build.buildBitmap.width - mainPanel.ContentGroup.width) / 2;
			
			if(buildProxy.build.buildBitmap.height > mainPanel.ContentGroup.height)
				mainPanel.ContentGroup.verticalScrollPosition = (buildProxy.build.buildBitmap.height - mainPanel.ContentGroup.height) / 2;
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
					break;
			}
		}
	}
}