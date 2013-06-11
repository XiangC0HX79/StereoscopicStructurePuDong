package app.view
{
	import app.ApplicationFacade;
	import app.model.vo.BuildVO;
	import app.model.vo.ClosedhandleVO;
	import app.model.vo.CommandHeightVO;
	import app.view.components.PanelSurrounding;
	
	import flash.events.Event;
	
	import mx.core.IVisualElement;
	import mx.events.DragEvent;
	import mx.managers.DragManager;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class PanelSurroundingMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "PanelSurroundingMediator";
		
		public function PanelSurroundingMediator()
		{
			super(NAME, new PanelSurrounding);
			
			panelSurrounding.addElement(facade.retrieveMediator(LayerClosedPicMediator.NAME).getViewComponent() as IVisualElement);
			
			panelSurrounding.addElement(facade.retrieveMediator(LayerDrawMediator.NAME).getViewComponent() as IVisualElement);			

			panelSurrounding.addElement(facade.retrieveMediator(LayerCommandingHeightMediator.NAME).getViewComponent() as IVisualElement);
			
			panelSurrounding.addElement(facade.retrieveMediator(LayerCloseHandlesMediator.NAME).getViewComponent() as IVisualElement);
			
			panelSurrounding.addElement(facade.retrieveMediator(LayerTrafficMediator.NAME).getViewComponent() as IVisualElement);
			
			panelSurrounding.addElement(facade.retrieveMediator(LayerHazardMediator.NAME).getViewComponent() as IVisualElement);
						
			panelSurrounding.addElement(facade.retrieveMediator(LayerFireHydrantMediator.NAME).getViewComponent() as IVisualElement);
			
			panelSurrounding.addElement(facade.retrieveMediator(LayerKeyUnitsMediator.NAME).getViewComponent() as IVisualElement);
			
			panelSurrounding.addElement(facade.retrieveMediator(LayerScentingMediator.NAME).getViewComponent() as IVisualElement);
			
			panelSurrounding.addEventListener(PanelSurrounding.BUILDCLICK,onBuildClick);			
			
			panelSurrounding.addEventListener(DragEvent.DRAG_ENTER,onDragEnter);
			panelSurrounding.addEventListener(DragEvent.DRAG_DROP,onDragDrop);		
		}
		
		protected function get panelSurrounding():PanelSurrounding
		{
			return viewComponent as PanelSurrounding;
		}
		
		private function onBuildClick(event:Event):void
		{			
			sendNotification(ApplicationFacade.NOTIFY_TITLEWINDOW_MOVIE,panelSurrounding.Build.TMB_videoPath);
		}
				
		private function onDragEnter(e:DragEvent):void
		{			
			if(
				e.dragSource.hasFormat("CommandHeightVO")
				|| e.dragSource.hasFormat("ClosedhandleVO")
			)
			{  
				DragManager.acceptDragDrop(panelSurrounding);	
			}  
		}
		
		private function onDragDrop(e:DragEvent):void
		{			
			if(e.dragSource.hasFormat("CommandHeightVO"))
			{  
				var commandHeight:CommandHeightVO = e.dragSource.dataForFormat("CommandHeightVO") as CommandHeightVO;
				commandHeight.TCH_X = panelSurrounding.mouseX;
				commandHeight.TCH_Y = panelSurrounding.mouseY;
			}
			else if(e.dragSource.hasFormat("ClosedhandleVO"))
			{
				var closeHandle:ClosedhandleVO = e.dragSource.dataForFormat("ClosedhandleVO") as ClosedhandleVO;
				closeHandle.T_ClosedX = panelSurrounding.mouseX;
				closeHandle.T_ClosedY = panelSurrounding.mouseY;				
			}				
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