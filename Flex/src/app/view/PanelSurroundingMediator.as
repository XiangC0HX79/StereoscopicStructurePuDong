package app.view
{
	import app.ApplicationFacade;
	import app.model.BuildProxy;
	import app.model.ClosedHandleLineProxy;
	import app.model.FireHydrantProxy;
	import app.model.IconsProxy;
	import app.model.ScentingLineProxy;
	import app.model.cosnt.PanelSurroundingTool;
	import app.model.vo.BuildVO;
	import app.model.vo.ClosedHandleVO;
	import app.model.vo.CommandHeightVO;
	import app.model.vo.CursorVO;
	import app.model.vo.FireHydrantVO;
	import app.model.vo.HazardVO;
	import app.model.vo.KeyUnitVO;
	import app.model.vo.ScentingVO;
	import app.model.vo.TrafficVO;
	import app.view.components.PanelSurrounding;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Mouse;
	import flash.utils.getDefinitionByName;
	
	import mx.core.IVisualElement;
	import mx.events.DragEvent;
	import mx.managers.CursorManager;
	import mx.managers.DragManager;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import spark.components.Image;
	
	public class PanelSurroundingMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "PanelSurroundingMediator";
		
		[Embed('assets/image/CursorAdd.png')]		
		private static const CURSOR_ADD:Class;
		
		[Embed('assets/image/CursorDel.png')]		
		private static const CURSOR_DEL:Class;
		
		private var iconsProxy:IconsProxy; 
		
		public function PanelSurroundingMediator()
		{
			super(NAME, new PanelSurrounding);
			
			panelSurrounding.contentGroup.addElement(facade.retrieveMediator(LayerScentingPicMediator.NAME).getViewComponent() as IVisualElement);	
			
			panelSurrounding.contentGroup.addElement(facade.retrieveMediator(LayerClosedPicMediator.NAME).getViewComponent() as IVisualElement);	
						
			panelSurrounding.contentGroup.addElement(facade.retrieveMediator(ImageBuildingMediator.NAME).getViewComponent() as IVisualElement);	
			
			panelSurrounding.contentGroup.addElement(facade.retrieveMediator(LayerDrawMediator.NAME).getViewComponent() as IVisualElement);						

			panelSurrounding.contentGroup.addElement(facade.retrieveMediator(LayerCommandingHeightMediator.NAME).getViewComponent() as IVisualElement);
			
			panelSurrounding.contentGroup.addElement(facade.retrieveMediator(LayerCloseHandlesMediator.NAME).getViewComponent() as IVisualElement);
			
			panelSurrounding.contentGroup.addElement(facade.retrieveMediator(LayerTrafficMediator.NAME).getViewComponent() as IVisualElement);
			
			panelSurrounding.contentGroup.addElement(facade.retrieveMediator(LayerHazardMediator.NAME).getViewComponent() as IVisualElement);
						
			panelSurrounding.contentGroup.addElement(facade.retrieveMediator(LayerFireHydrantMediator.NAME).getViewComponent() as IVisualElement);
			
			panelSurrounding.contentGroup.addElement(facade.retrieveMediator(LayerKeyUnitsMediator.NAME).getViewComponent() as IVisualElement);
			
			panelSurrounding.contentGroup.addElement(facade.retrieveMediator(LayerScentingMediator.NAME).getViewComponent() as IVisualElement);
			
			panelSurrounding.contentGroup.addEventListener(DragEvent.DRAG_ENTER,onDragEnter);
			panelSurrounding.contentGroup.addEventListener(DragEvent.DRAG_DROP,onDragDrop);		
			
			panelSurrounding.contentGroup.addEventListener(MouseEvent.ROLL_OVER,onRollOver);	
			panelSurrounding.contentGroup.addEventListener(MouseEvent.ROLL_OUT,onRollOut);	
			panelSurrounding.contentGroup.addEventListener(MouseEvent.CLICK,onClick);		
			panelSurrounding.contentGroup.addEventListener(MouseEvent.DOUBLE_CLICK,onDoubleClick);	
			
			panelSurrounding.contentGroup.addEventListener(MouseEvent.MOUSE_MOVE,onMove);					
									
			iconsProxy = facade.retrieveProxy(IconsProxy.NAME) as IconsProxy;
		}
		
		protected function get panelSurrounding():PanelSurrounding
		{
			return viewComponent as PanelSurrounding;
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
				|| e.dragSource.hasFormat("BuildVO")				
			)
			{  
				DragManager.acceptDragDrop(panelSurrounding.contentGroup);	
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
				
				sendNotification(ApplicationFacade.NOTIFY_SELECT_MOVE,commandHeight);		
			}
			else if(e.dragSource.hasFormat("ClosedhandleVO"))
			{
				var closeHandle:ClosedHandleVO = e.dragSource.dataForFormat("ClosedhandleVO") as ClosedHandleVO;
				closeHandle.T_ClosedX = e.localX - sp.x + e.dragInitiator.width / 2;
				closeHandle.T_ClosedY = e.localY - sp.y + e.dragInitiator.height / 2;		
				
				sendNotification(ApplicationFacade.NOTIFY_SELECT_MOVE,closeHandle);				
			}			
			else if(e.dragSource.hasFormat("TrafficInfoVO"))
			{
				var ti:TrafficVO = e.dragSource.dataForFormat("TrafficInfoVO") as TrafficVO;
				ti.T_TrafficX = e.localX - sp.x + e.dragInitiator.width / 2;
				ti.T_TrafficY = e.localY - sp.y + e.dragInitiator.height / 2;	
				
				sendNotification(ApplicationFacade.NOTIFY_SELECT_MOVE,ti);					
			}			
			else if(e.dragSource.hasFormat("HazardVO"))
			{
				var ha:HazardVO = e.dragSource.dataForFormat("HazardVO") as HazardVO;
				ha.T_HazardX = e.localX - sp.x;
				ha.T_HazardY = e.localY - sp.y;				
				
				sendNotification(ApplicationFacade.NOTIFY_SELECT_MOVE,ha);			
			}				
			else if(e.dragSource.hasFormat("FireHydrantVO"))
			{
				var fh:FireHydrantVO = e.dragSource.dataForFormat("FireHydrantVO") as FireHydrantVO;
				fh.T_FireHydrantX = e.localX - sp.x + e.dragInitiator.width / 2;
				fh.T_FireHydrantY = e.localY - sp.y + e.dragInitiator.height / 2;	
				
				sendNotification(ApplicationFacade.NOTIFY_SELECT_MOVE,fh);					
			}					
			else if(e.dragSource.hasFormat("KeyUnitVO"))
			{
				var ku:KeyUnitVO = e.dragSource.dataForFormat("KeyUnitVO") as KeyUnitVO;
				ku.T_KeyUnitsX = e.localX - sp.x + e.dragInitiator.width / 2;
				ku.T_KeyUnitsY = e.localY - sp.y + e.dragInitiator.height / 2;		
				
				sendNotification(ApplicationFacade.NOTIFY_SELECT_MOVE,ku);						
			}						
			else if(e.dragSource.hasFormat("ScentingVO"))
			{
				var sc:ScentingVO = e.dragSource.dataForFormat("ScentingVO") as ScentingVO;
				sc.T_ScentingX = e.localX - sp.x;
				sc.T_ScentingY = e.localY - sp.y;		
				
				sendNotification(ApplicationFacade.NOTIFY_SELECT_MOVE,sc);					
			}						
			else if(e.dragSource.hasFormat("BuildVO"))
			{
				var bd:BuildVO = e.dragSource.dataForFormat("BuildVO") as BuildVO;
				bd.TMB_X = e.localX - sp.x + e.dragInitiator.width / 2;
				bd.TMB_Y = e.localY - sp.y + e.dragInitiator.height / 2;		
				
				sendNotification(ApplicationFacade.NOTIFY_SELECT_MOVE,bd);					
			}		
		}
				
		private function onRollOver(event:Event):void
		{						
			if(PanelSurroundingTool.Tool == PanelSurroundingTool.FIRE_ADD)
			{
				var bitmap:Bitmap = iconsProxy.icons.CursorFireAdd;
				CursorVO.customBitmapData = bitmap.bitmapData;
				CursorManager.setCursor(CursorVO,2,-bitmap.width / 2 ,-bitmap.height / 2);	
			}
			else if(PanelSurroundingTool.Tool == PanelSurroundingTool.FIRE_DEL)
			{
				bitmap = iconsProxy.icons.CursorFireDel;
				CursorVO.customBitmapData = bitmap.bitmapData;
				CursorManager.setCursor(CursorVO,2,-bitmap.width / 2 ,-bitmap.height / 2);			
			}
			else if(
				(PanelSurroundingTool.Tool == PanelSurroundingTool.CLOSE_ADD_START)
				||
				(PanelSurroundingTool.Tool == PanelSurroundingTool.CLOSE_ADD_END)
				||
				(PanelSurroundingTool.Tool == PanelSurroundingTool.SCENTING_ADD)
				)
			{
				CursorManager.setCursor(CURSOR_ADD,2,-5,0);
			}
			else if(
				(PanelSurroundingTool.Tool == PanelSurroundingTool.CLOSE_DEL)
				||
				(PanelSurroundingTool.Tool == PanelSurroundingTool.SCENTING_DEL)
				)
			{
				CursorManager.setCursor(CURSOR_DEL,2,-5,0);
			}
		}
				
		private function onRollOut(event:Event):void
		{
			CursorManager.removeAllCursors();
		}
		
		private function onClick(event:MouseEvent):void
		{			
			if(PanelSurroundingTool.Tool == PanelSurroundingTool.FIRE_ADD)
			{				
				var fireHydrantProxy:FireHydrantProxy = facade.retrieveProxy(FireHydrantProxy.NAME) as FireHydrantProxy;
				fireHydrantProxy.AddFireHydrant(event.localX,event.localY);
			}
			else if(PanelSurroundingTool.Tool == PanelSurroundingTool.CLOSE_ADD_START)
			{
				PanelSurroundingTool.Tool = PanelSurroundingTool.CLOSE_ADD_END;
				
				var pt:Point = (event.target as DisplayObject).localToGlobal(new Point(event.localX,event.localY));
				pt = panelSurrounding.contentGroup.globalToLocal(pt);
				
				sendNotification(ApplicationFacade.NOTIFY_CLOSE_ADD_START,pt);
			}
			else if(PanelSurroundingTool.Tool == PanelSurroundingTool.CLOSE_ADD_END)
			{
				PanelSurroundingTool.Tool = PanelSurroundingTool.CLOSE_ADD_START;
				
				pt = (event.target as DisplayObject).localToGlobal(new Point(event.localX,event.localY));
				pt = panelSurrounding.contentGroup.globalToLocal(pt);
				
				sendNotification(ApplicationFacade.NOTIFY_CLOSE_ADD_END,pt);				
			}
			else if(PanelSurroundingTool.Tool == PanelSurroundingTool.CLOSE_DEL)
			{				
				pt = (event.target as DisplayObject).localToGlobal(new Point(event.localX,event.localY));
				pt = panelSurrounding.contentGroup.globalToLocal(pt);
				
				var closedHandleLineProxy:ClosedHandleLineProxy = facade.retrieveProxy(ClosedHandleLineProxy.NAME) as ClosedHandleLineProxy;
				closedHandleLineProxy.DelFireHydrant(pt);
			}
			else if(PanelSurroundingTool.Tool == PanelSurroundingTool.SCENTING_ADD)
			{				
				pt = (event.target as DisplayObject).localToGlobal(new Point(event.localX,event.localY));
				pt = panelSurrounding.contentGroup.globalToLocal(pt);
				
				sendNotification(ApplicationFacade.NOTIFY_SCENTING_ADD_START,pt);	
			}
			else if(PanelSurroundingTool.Tool == PanelSurroundingTool.SCENTING_DEL)
			{				
				pt = (event.target as DisplayObject).localToGlobal(new Point(event.localX,event.localY));
				pt = panelSurrounding.contentGroup.globalToLocal(pt);
								
				var scentingLineProxy:ScentingLineProxy = facade.retrieveProxy(ScentingLineProxy.NAME) as ScentingLineProxy;
				scentingLineProxy.DelScentingLine(pt);
			}
		}
		
		private function onDoubleClick(event:MouseEvent):void
		{			
			if(PanelSurroundingTool.Tool == PanelSurroundingTool.SCENTING_ADD)
			{				
				var pt:Point = (event.target as DisplayObject).localToGlobal(new Point(event.localX,event.localY));
				pt = panelSurrounding.contentGroup.globalToLocal(pt);
				
				sendNotification(ApplicationFacade.NOTIFY_SCENTING_ADD_END,pt);	
			}
		}
		
		private function onMove(event:MouseEvent):void
		{
			if(PanelSurroundingTool.Tool == PanelSurroundingTool.CLOSE_ADD_END)
			{								
				var pt:Point = (event.target as DisplayObject).localToGlobal(new Point(event.localX,event.localY));
				pt = panelSurrounding.contentGroup.globalToLocal(pt);
				
				sendNotification(ApplicationFacade.NOTIFY_CLOSE_ADD_MOVE,pt);
			}
			else if(PanelSurroundingTool.Tool == PanelSurroundingTool.SCENTING_ADD)
			{				
				pt = (event.target as DisplayObject).localToGlobal(new Point(event.localX,event.localY));
				pt = panelSurrounding.contentGroup.globalToLocal(pt);
				
				sendNotification(ApplicationFacade.NOTIFY_SCENTING_ADD_MOVE,pt);	
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