package app.view
{
	import app.ApplicationFacade;
	import app.model.vo.BuildVO;
	import app.view.components.PanelSurrounding;
	
	import flash.events.Event;
	
	import mx.core.IVisualElement;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class PanelSurroundingMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "PanelSurroundingMediator";
		
		public function PanelSurroundingMediator()
		{
			super(NAME, new PanelSurrounding);
						
			panelSurrounding.addElement(facade.retrieveMediator(LayerDrawMediator.NAME).getViewComponent() as IVisualElement);
			
			panelSurrounding.addElement(facade.retrieveMediator(LayerClosedPicMediator.NAME).getViewComponent() as IVisualElement);

			panelSurrounding.addElement(facade.retrieveMediator(LayerCommandingHeightMediator.NAME).getViewComponent() as IVisualElement);
			
			panelSurrounding.addElement(facade.retrieveMediator(LayerCloseHandlesMediator.NAME).getViewComponent() as IVisualElement);
			
			panelSurrounding.addElement(facade.retrieveMediator(LayerTrafficMediator.NAME).getViewComponent() as IVisualElement);
			
			panelSurrounding.addElement(facade.retrieveMediator(LayerHazardMediator.NAME).getViewComponent() as IVisualElement);
						
			panelSurrounding.addElement(facade.retrieveMediator(LayerFireHydrantMediator.NAME).getViewComponent() as IVisualElement);
			
			panelSurrounding.addElement(facade.retrieveMediator(LayerKeyUnitsMediator.NAME).getViewComponent() as IVisualElement);
			
			panelSurrounding.addElement(facade.retrieveMediator(LayerScentingMediator.NAME).getViewComponent() as IVisualElement);
			
			panelSurrounding.addEventListener(PanelSurrounding.BUILDCLICK,onBuildClick);			
		}
		
		protected function get panelSurrounding():PanelSurrounding
		{
			return viewComponent as PanelSurrounding;
		}
		
		private function onBuildClick(event:Event):void
		{			
			sendNotification(ApplicationFacade.NOTIFY_TITLEWINDOW_MOVIE,panelSurrounding.Build.TMB_videoPath);
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
					panelSurrounding.Build = notification.getBody() as BuildVO;
					break;
			}
		}
	}
}