package app.view
{
	import app.ApplicationFacade;
	import app.model.vo.CommandHeightPicVO;
	import app.model.vo.CommandHeightVO;
	import app.view.components.TitleWindowCommandHeight;
	
	import com.adobe.utils.DictionaryUtil;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	import mx.managers.PopUpManager;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class TitleWindowCommandHeightMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "TitleWindowCommandHeightMediator";
		
		public function TitleWindowCommandHeightMediator()
		{
			super(NAME, new TitleWindowCommandHeight);
			
			titleWindowCommandHeight.addEventListener(TitleWindowCommandHeight.IMAGELIST,onImageList);
		}
		
		protected function get titleWindowCommandHeight():TitleWindowCommandHeight
		{
			return viewComponent as TitleWindowCommandHeight;
		}
		
		private function onImageList(event:Event):void
		{
			sendNotification(ApplicationFacade.NOTIFY_TITLEWINDOW_MEDIA,titleWindowCommandHeight.commandingHeight.pics);
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				ApplicationFacade.NOTIFY_TITLEWINDOW_COMMAND
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case ApplicationFacade.NOTIFY_TITLEWINDOW_COMMAND:
					var ch:CommandHeightVO = notification.getBody() as CommandHeightVO;
					titleWindowCommandHeight.currentState = (DictionaryUtil.getKeys(ch.pics).length > 0)?"Image":"NoImage";
					titleWindowCommandHeight.commandingHeight = ch;
					break;
			}
		}
	}
}