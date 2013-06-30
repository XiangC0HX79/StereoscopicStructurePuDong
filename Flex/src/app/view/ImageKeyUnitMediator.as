package app.view
{
	import app.ApplicationFacade;
	import app.model.IconsProxy;
	import app.model.cosnt.PanelSurroundingTool;
	import app.model.vo.ConfigVO;
	import app.model.vo.KeyUnitVO;
	import app.view.components.ImageKeyUnit;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Image;
	import mx.core.DragSource;
	import mx.managers.DragManager;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class ImageKeyUnitMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "ImageKeyUnitMediator";
		
		public function ImageKeyUnitMediator(ku:KeyUnitVO)
		{
			super(NAME + ku.T_KeyUnitsID, new ImageKeyUnit);
						
			imageKeyUnit.addEventListener(MouseEvent.CLICK,onClick);
			
			if(ConfigVO.EDIT)
			{
				imageKeyUnit.addEventListener(MouseEvent.MOUSE_MOVE,onDragStart);
			}
			
			var iconsProxy:IconsProxy = facade.retrieveProxy(IconsProxy.NAME) as IconsProxy;
			imageKeyUnit.source = iconsProxy.icons.IconKeyUnit;
			
			imageKeyUnit.keyUnit = ku;
		}
		
		protected function get imageKeyUnit():ImageKeyUnit
		{
			return viewComponent as ImageKeyUnit;
		}
		
		private function onClick(event:Event):void
		{				
			if(PanelSurroundingTool.Tool == PanelSurroundingTool.MOVE)
			{
				sendNotification(ApplicationFacade.NOTIFY_TITLEWINDOW_KEYUNIT,imageKeyUnit.keyUnit);
			}
		}
		
		private function onDragStart(e:MouseEvent):void
		{						
			var imageProxy:Image = new Image;
			imageProxy.source = imageKeyUnit.source;
			
			var ds:DragSource = new DragSource();  
			ds.addData(imageKeyUnit.keyUnit,"KeyUnitVO");
			ds.addData(new Point(e.localX,e.localY),"StartPoint");
			DragManager.doDrag(imageKeyUnit,ds,e,imageProxy); 
		}
	}
}