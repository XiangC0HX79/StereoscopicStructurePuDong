package app.view
{
	import app.ApplicationFacade;
	import app.model.vo.BuildVO;
	import app.view.components.MainPanel;
	
	import flash.events.Event;
	
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
			mainPanel.addEventListener(MainPanel.STEREOSCOPIC,onStereoScopic);
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
					mainPanel.Build = notification.getBody() as BuildVO;
										
					contentGroupAddElement(PanelSurroundingMediator.NAME);
					break;
			}
		}
	}
}