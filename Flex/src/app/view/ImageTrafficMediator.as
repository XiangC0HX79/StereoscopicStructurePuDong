package app.view
{
	import app.ApplicationFacade;
	import app.model.IconsProxy;
	import app.model.cosnt.PanelSurroundingTool;
	import app.model.vo.ConfigVO;
	import app.model.vo.TrafficVO;
	import app.view.components.ImageTraffic;
	
	import com.adobe.utils.DictionaryUtil;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Image;
	import mx.core.DragSource;
	import mx.managers.DragManager;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class ImageTrafficMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "ImageTrafficMediator";
		
		public function ImageTrafficMediator(tr:TrafficVO)
		{
			super(NAME + tr.T_TrafficID, new ImageTraffic);
						
			if(DictionaryUtil.getKeys(tr.pics).length > 0)
			{
				imageTraffic.buttonMode = true;
				imageTraffic.addEventListener(MouseEvent.CLICK,onClick);
			}
			
			if(ConfigVO.EDIT)
			{
				imageTraffic.addEventListener(MouseEvent.MOUSE_MOVE,onDragStart);
			}
			
			var iconsProxy:IconsProxy = facade.retrieveProxy(IconsProxy.NAME) as IconsProxy;
			imageTraffic.source = iconsProxy.icons.IconTraffic;
			
			imageTraffic.trafficInfo = tr;
		}
		
		protected function get imageTraffic():ImageTraffic
		{
			return viewComponent as ImageTraffic;
		}
		
		private function onClick(event:Event):void
		{				
			if(PanelSurroundingTool.Tool == PanelSurroundingTool.MOVE)
			{
				sendNotification(ApplicationFacade.NOTIFY_TITLEWINDOW_MEDIA,imageTraffic.trafficInfo.pics);
			}
		}
		
		private function onDragStart(e:MouseEvent):void
		{						
			var imageProxy:Image = new Image;
			imageProxy.source = imageTraffic.source;
			
			var ds:DragSource = new DragSource();  
			ds.addData(imageTraffic.trafficInfo,"TrafficInfoVO");
			ds.addData(new Point(e.localX,e.localY),"StartPoint");
			DragManager.doDrag(imageTraffic,ds,e,imageProxy); 
		}
	}
}