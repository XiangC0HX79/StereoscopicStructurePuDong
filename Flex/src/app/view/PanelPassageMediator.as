package app.view
{
	import app.ApplicationFacade;
	import app.model.IconsProxy;
	import app.model.PassageProxy;
	import app.model.vo.CursorVO;
	import app.model.vo.ImportExportVO;
	import app.model.vo.VideoVO;
	import app.view.components.ImageImportExport;
	import app.view.components.ImageVideo;
	import app.view.components.PanelPassage;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.media.Video;
	import flash.ui.Mouse;
	
	import mx.core.IVisualElement;
	import mx.events.DragEvent;
	import mx.managers.CursorManager;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import spark.components.Image;
	
	public class PanelPassageMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "PanelPassageMediator";
				
		private var passageProxy:PassageProxy;
		
		private var iconsProxy:IconsProxy; 
				
		public function PanelPassageMediator()
		{
			super(NAME, new PanelPassage);
			
			panelPassage.addEventListener(PanelPassage.IMAGE_READY,onImageReady);
			
			panelPassage.addEventListener(PanelPassage.ROLLOVER,onRollOver);	
			panelPassage.addEventListener(PanelPassage.ROLLOUT,onRollOut);	
			panelPassage.addEventListener(PanelPassage.MOUSECLICK,onClick);	
			panelPassage.addEventListener(DragEvent.DRAG_DROP,onDragDrop);
						
			passageProxy = facade.retrieveProxy(PassageProxy.NAME) as PassageProxy;
			
			iconsProxy = facade.retrieveProxy(IconsProxy.NAME) as IconsProxy;
		}
		
		protected function get panelPassage():PanelPassage
		{
			return viewComponent as PanelPassage
		}
		
		protected function onRollOut(event:Event):void
		{
			CursorManager.removeAllCursors();	
		}
		
		protected function onRollOver(event:Event):void
		{			
			if(VideoVO.Tool == VideoVO.ADD)
			{
				var bitmap:Bitmap = iconsProxy.icons.CursorVideoAdd;
				CursorVO.customBitmapData = bitmap.bitmapData;
				CursorManager.setCursor(CursorVO,2,-bitmap.width / 2 ,-bitmap.height / 2);
			}
			else if(VideoVO.Tool == VideoVO.DEL)
			{
				bitmap = iconsProxy.icons.CursorVideoDel;
				CursorVO.customBitmapData = bitmap.bitmapData;
				CursorManager.setCursor(CursorVO,2,-bitmap.width / 2 ,-bitmap.height / 2);
			}
		}
		
		protected function onClick(event:Event):void
		{
			if(VideoVO.Tool == VideoVO.ADD)
			{				
				var passageProxy:PassageProxy = facade.retrieveProxy(PassageProxy.NAME) as PassageProxy;
				passageProxy.AddVideo(panelPassage.psg,panelPassage.groupPassage.mouseX,panelPassage.groupPassage.mouseY);
			}
		}
		
		private function onDragDrop(e:DragEvent):void
		{			
			var sp:Point = e.dragSource.dataForFormat("StartPoint") as Point;
			
			if(e.dragSource.hasFormat("VideoVO"))
			{  
				var v:VideoVO = e.dragSource.dataForFormat("VideoVO") as VideoVO;
				v.T_VideoX = e.localX - sp.x + e.dragInitiator.width / 2;
				v.T_VideoY = e.localY - sp.y + e.dragInitiator.height / 2;
				
				sendNotification(ApplicationFacade.NOTIFY_SELECT_MOVE,v);			
			}
			else if(e.dragSource.hasFormat("ImportExportVO"))
			{  
				var ie:ImportExportVO = e.dragSource.dataForFormat("ImportExportVO") as ImportExportVO;
				ie.T_ImportExportX = e.localX - sp.x;
				ie.T_ImportExportY = e.localY - sp.y;
				
				sendNotification(ApplicationFacade.NOTIFY_SELECT_MOVE,ie);	
			}
		}
		
		private function onImageReady(event:Event):void
		{
			for(var i:Number = 0;i<panelPassage.groupImportExport.numElements;i++)
			{
				var ie:ImageImportExport = panelPassage.groupImportExport.getElementAt(i) as ImageImportExport;
				
				facade.removeMediator(ImageImportExportMediator.NAME + ie.ImportExport.T_ImportExportID);
			}
			
			panelPassage.groupImportExport.removeAllElements();
			
			for each(var j:ImportExportVO in panelPassage.psg.dictImportExport)
			{
				var imageImportExportMediator:ImageImportExportMediator = new ImageImportExportMediator(j);
				
				facade.registerMediator(imageImportExportMediator);
				
				panelPassage.groupImportExport.addElement(imageImportExportMediator.getViewComponent() as IVisualElement);
			}
			
			
			for(i = 0;i<panelPassage.groupVideo.numElements;i++)
			{
				var iv:ImageVideo = panelPassage.groupVideo.getElementAt(i) as ImageVideo;
				
				facade.removeMediator(ImageVideoMediator.NAME + iv.v.T_VideoID);
			}
			
			panelPassage.groupVideo.removeAllElements();
			
			for each(var k:VideoVO in panelPassage.psg.dictVideo)
			{
				var imageVideoMediator:ImageVideoMediator = new ImageVideoMediator(k);
				
				facade.registerMediator(imageVideoMediator);
				
				panelPassage.groupVideo.addElement(imageVideoMediator.getViewComponent() as IVisualElement);
			}
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				ApplicationFacade.NOTIFY_MENU_PASSAGE_PLAN,
				ApplicationFacade.NOTIFY_MENU_PASSAGE_UNDERGROUND,
				ApplicationFacade.NOTIFY_MENU_PASSAGE_GROUND,
				ApplicationFacade.NOTIFY_MENU_PASSAGE_TOPFLOOR,
				ApplicationFacade.NOTIFY_MENU_PASSAGE_FRESHAIR,
				ApplicationFacade.NOTIFY_MENU_PASSAGE_SPECIAL,
				
				ApplicationFacade.NOTIFY_VIDEO_ADD,
				ApplicationFacade.NOTIFY_VIDEO_DEL
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case ApplicationFacade.NOTIFY_MENU_PASSAGE_PLAN:		
					panelPassage.Datapro = passageProxy.ArrPlan;
					break;
				
				case ApplicationFacade.NOTIFY_MENU_PASSAGE_UNDERGROUND:		
					panelPassage.Datapro = passageProxy.ArrUnderGround;
					break;
				
				case ApplicationFacade.NOTIFY_MENU_PASSAGE_GROUND:		
					panelPassage.Datapro = passageProxy.ArrGround;
					break;
				
				case ApplicationFacade.NOTIFY_MENU_PASSAGE_TOPFLOOR:		
					panelPassage.Datapro = passageProxy.ArrTopFloor;
					break;
				
				case ApplicationFacade.NOTIFY_MENU_PASSAGE_FRESHAIR:		
					panelPassage.Datapro = passageProxy.ArrFreshAir;
					break;
				
				case ApplicationFacade.NOTIFY_MENU_PASSAGE_SPECIAL:		
					panelPassage.Datapro = passageProxy.ArrSpecial;
					break;
				
				case ApplicationFacade.NOTIFY_VIDEO_ADD:
					addVideo(notification.getBody() as VideoVO);
					break;
				
				case ApplicationFacade.NOTIFY_VIDEO_DEL:			
					delVideo(notification.getBody() as VideoVO);
					break;
			}
		}
		
		private function addVideo(v:VideoVO):void
		{			
			var imageVideoMediator:ImageVideoMediator = new ImageVideoMediator(v);
			
			facade.registerMediator(imageVideoMediator);
			
			panelPassage.groupVideo.addElement(imageVideoMediator.getViewComponent() as IVisualElement);
		}
		
		private function delVideo(v:VideoVO):void
		{			
			var vm:ImageVideoMediator = facade.retrieveMediator(ImageVideoMediator.NAME + v.T_VideoID) as ImageVideoMediator;
			
			if(vm)
			{
				panelPassage.groupVideo.removeElement(vm.getViewComponent() as IVisualElement);
				facade.removeMediator(vm.getMediatorName());
			}
		}
	}
}