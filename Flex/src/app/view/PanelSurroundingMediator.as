package app.view
{
	import app.ApplicationFacade;
	import app.model.BuildProxy;
	import app.model.FireHydrantProxy;
	import app.model.vo.BuildVO;
	import app.model.vo.ClosedHandleVO;
	import app.model.vo.CommandHeightVO;
	import app.model.vo.FireHydrantVO;
	import app.model.vo.HazardVO;
	import app.model.vo.KeyUnitVO;
	import app.model.vo.ScentingVO;
	import app.model.vo.TrafficVO;
	import app.view.components.PanelSurrounding;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.core.IVisualElement;
	import mx.events.DragEvent;
	import mx.managers.CursorManager;
	import mx.managers.DragManager;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class PanelSurroundingMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "PanelSurroundingMediator";
		
		[Embed('assets/image/cursor_fire_add.png')]		
		private static const CURSOR_FIRE_ADD:Class;
		
		[Embed('assets/image/cursor_fire_del.png')]		
		private static const CURSOR_FIRE_DEL:Class;
		
		public function PanelSurroundingMediator()
		{
			super(NAME, new PanelSurrounding);
			
			panelSurrounding.addElement(facade.retrieveMediator(LayerClosedPicMediator.NAME).getViewComponent() as IVisualElement);
			
			panelSurrounding.addElement(facade.retrieveMediator(LayerScentingPicMediator.NAME).getViewComponent() as IVisualElement);
			
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
			
			panelSurrounding.addEventListener(MouseEvent.ROLL_OVER,onRollOver);	
			panelSurrounding.addEventListener(MouseEvent.ROLL_OUT,onRollOut);	
			panelSurrounding.addEventListener(MouseEvent.CLICK,onClick);			
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
				|| e.dragSource.hasFormat("TrafficInfoVO")
				|| e.dragSource.hasFormat("HazardVO")		
				|| e.dragSource.hasFormat("FireHydrantVO")		
				|| e.dragSource.hasFormat("KeyUnitVO")				
				|| e.dragSource.hasFormat("ScentingVO")				
			)
			{  
				DragManager.acceptDragDrop(panelSurrounding);	
			}  
		}
		
		private function onDragDrop(e:DragEvent):void
		{		
			var sp:Point = e.dragSource.dataForFormat("StartPoint") as Point;
			
			if(e.dragSource.hasFormat("CommandHeightVO"))
			{  
				var commandHeight:CommandHeightVO = e.dragSource.dataForFormat("CommandHeightVO") as CommandHeightVO;
				commandHeight.TCH_X = e.localX - sp.x + e.dragInitiator.width / 2;
				commandHeight.TCH_Y = e.localY - sp.y + e.dragInitiator.height / 2;
			}
			else if(e.dragSource.hasFormat("ClosedhandleVO"))
			{
				var closeHandle:ClosedHandleVO = e.dragSource.dataForFormat("ClosedhandleVO") as ClosedHandleVO;
				closeHandle.T_ClosedX = e.localX - sp.x + e.dragInitiator.width / 2;
				closeHandle.T_ClosedY = e.localY - sp.y + e.dragInitiator.height / 2;						
			}			
			else if(e.dragSource.hasFormat("TrafficInfoVO"))
			{
				var ti:TrafficVO = e.dragSource.dataForFormat("TrafficInfoVO") as TrafficVO;
				ti.T_TrafficX = e.localX - sp.x + e.dragInitiator.width / 2;
				ti.T_TrafficY = e.localY - sp.y + e.dragInitiator.height / 2;						
			}			
			else if(e.dragSource.hasFormat("HazardVO"))
			{
				var ha:HazardVO = e.dragSource.dataForFormat("HazardVO") as HazardVO;
				ha.T_HazardX = e.localX - sp.x;
				ha.T_HazardY = e.localY - sp.y;				
			}				
			else if(e.dragSource.hasFormat("FireHydrantVO"))
			{
				var fh:FireHydrantVO = e.dragSource.dataForFormat("FireHydrantVO") as FireHydrantVO;
				fh.T_FireHydrantX = e.localX - sp.x + e.dragInitiator.width / 2;
				fh.T_FireHydrantY = e.localY - sp.y + e.dragInitiator.height / 2;				
			}					
			else if(e.dragSource.hasFormat("KeyUnitVO"))
			{
				var ku:KeyUnitVO = e.dragSource.dataForFormat("KeyUnitVO") as KeyUnitVO;
				ku.T_KeyUnitsX = e.localX - sp.x + e.dragInitiator.width / 2;
				ku.T_KeyUnitsY = e.localY - sp.y + e.dragInitiator.height / 2;				
			}						
			else if(e.dragSource.hasFormat("ScentingVO"))
			{
				var sc:ScentingVO = e.dragSource.dataForFormat("ScentingVO") as ScentingVO;
				sc.T_ScentingX = e.localX - sp.x + e.dragInitiator.width / 2;
				sc.T_ScentingY = e.localY - sp.y + e.dragInitiator.height / 2;				
			}		
		}
				
		private function onRollOver(event:Event):void
		{
			if(FireHydrantVO.Tool == FireHydrantVO.ADD)
			{
				CursorManager.setCursor(CURSOR_FIRE_ADD,2,-12,-12);
			}
			else if(FireHydrantVO.Tool == FireHydrantVO.DEL)
			{
				CursorManager.setCursor(CURSOR_FIRE_DEL,2,-12,-12);
			}
		}
				
		private function onRollOut(event:Event):void
		{
			CursorManager.removeAllCursors();
		}
		
		private function onClick(event:MouseEvent):void
		{			
			if(FireHydrantVO.Tool == FireHydrantVO.ADD)
			{				
				var fireHydrantProxy:FireHydrantProxy = facade.retrieveProxy(FireHydrantProxy.NAME) as FireHydrantProxy;
				fireHydrantProxy.AddFireHydrant(event.localX,event.localY);
			}
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				ApplicationFacade.NOTIFY_INIT_BUILD
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case ApplicationFacade.NOTIFY_INIT_BUILD:				
					panelSurrounding.Build = notification.getBody() as BuildVO;
					break;
			}
		}
	}
}