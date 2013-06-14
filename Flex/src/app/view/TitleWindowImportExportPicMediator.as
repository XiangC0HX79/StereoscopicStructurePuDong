package app.view
{
	import app.ApplicationFacade;
	import app.view.components.TitleWindowImportExportPic;
	
	import mx.collections.ArrayCollection;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class TitleWindowImportExportPicMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "TitleWindowImportExportPicMediator";
		
		public function TitleWindowImportExportPicMediator()
		{
			super(NAME, new TitleWindowImportExportPic);
		}
				
		protected function get titleWindowImportExportPic():TitleWindowImportExportPic
		{
			return viewComponent as TitleWindowImportExportPic;
		}
				
		override public function listNotificationInterests():Array
		{
			return [
				ApplicationFacade.NOTIFY_TITLEWINDOW_IMPORTEXPORTPIC
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case ApplicationFacade.NOTIFY_TITLEWINDOW_IMPORTEXPORTPIC:
					titleWindowImportExportPic.importExportPics = notification.getBody() as ArrayCollection;
					
					titleWindowImportExportPic.ImageIndex = 0;
					break;
			}
		}
	}
}