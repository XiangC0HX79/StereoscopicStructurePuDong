package app.view
{
	import app.ApplicationFacade;
	import app.model.PassageProxy;
	import app.model.vo.ImportExportVO;
	import app.view.components.ImageImportExport;
	import app.view.components.PanelPassage;
	
	import flash.events.Event;
	
	import mx.core.IVisualElement;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class PanelPassageMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "PanelPassageMediator";
		
		private var passageProxy:PassageProxy;
		
		public function PanelPassageMediator()
		{
			super(NAME, new PanelPassage);
			
			panelPassage.addEventListener(PanelPassage.IMAGE_READY,onImageReady);
			
			passageProxy = facade.retrieveProxy(PassageProxy.NAME) as PassageProxy;
		}
		
		protected function get panelPassage():PanelPassage
		{
			return viewComponent as PanelPassage
		}
		
		private function onImageReady(event:Event):void
		{
			panelPassage.groupImportExport.removeAllElements();
			
			for each(var i:ImportExportVO in panelPassage.psg.DictImportExport)
			{
				var imageImportExportMediator:ImageImportExportMediator = new ImageImportExportMediator(i);
				
				facade.registerMediator(imageImportExportMediator);
				
				panelPassage.groupImportExport.addElement(imageImportExportMediator.getViewComponent() as IVisualElement);
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