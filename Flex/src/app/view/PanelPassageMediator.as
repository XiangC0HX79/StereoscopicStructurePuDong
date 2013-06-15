package app.view
{
	import app.ApplicationFacade;
	import app.model.PassageProxy;
	import app.model.vo.ImportExportVO;
	import app.model.vo.VideoVO;
	import app.view.components.ImageImportExport;
	import app.view.components.ImageVideo;
	import app.view.components.PanelPassage;
	
	import flash.events.Event;
	
	import mx.core.IVisualElement;
	import mx.managers.CursorManager;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class PanelPassageMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "PanelPassageMediator";
		
		[Embed('assets/image/cursor_cam_add.png')]		
		private static const CURSOR_VIDEO_ADD:Class;
		
		[Embed('assets/image/cursor_cam_del.png')]		
		private static const CURSOR_VIDEO_DEL:Class;
		
		private var passageProxy:PassageProxy;
		
		public function PanelPassageMediator()
		{
			super(NAME, new PanelPassage);
			
			panelPassage.addEventListener(PanelPassage.IMAGE_READY,onImageReady);
			
			panelPassage.addEventListener(PanelPassage.ROLLOVER,onRollOver);	
			panelPassage.addEventListener(PanelPassage.ROLLOUT,onRollOut);	
			panelPassage.addEventListener(PanelPassage.MOUSECLICK,onClick);		
			
			passageProxy = facade.retrieveProxy(PassageProxy.NAME) as PassageProxy;
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
				CursorManager.setCursor(CURSOR_VIDEO_ADD,2,-12,-12);
			}
			else if(VideoVO.Tool == VideoVO.DEL)
			{
				CursorManager.setCursor(CURSOR_VIDEO_DEL,2,-12,-12);
			}
		}
		
		protected function onClick(event:Event):void
		{
			if(VideoVO.Tool == VideoVO.ADD)
			{				
				//var fireHydrantProxy:FireHydrantProxy = facade.retrieveProxy(FireHydrantProxy.NAME) as FireHydrantProxy;
				//fireHydrantProxy.AddFireHydrant(event.localX,event.localY);
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
			
			for each(var j:ImportExportVO in panelPassage.psg.DictImportExport)
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
				ApplicationFacade.NOTIFY_MENU_PASSAGE_SPECIAL
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
			}
		}
	}
}