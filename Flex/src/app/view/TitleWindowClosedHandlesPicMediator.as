package app.view
{
	import app.ApplicationFacade;
	import app.model.vo.ClosedHandlePicVO;
	import app.model.vo.ClosedhandleVO;
	import app.model.vo.CommandHeightVO;
	import app.view.components.TitleWindowClosedHandlesPic;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	import mx.managers.PopUpManager;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class TitleWindowClosedHandlesPicMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "TitleWindowClosedHandlesPicMediator";
		
		public function TitleWindowClosedHandlesPicMediator()
		{
			super(NAME, new TitleWindowClosedHandlesPic);
			
			titleWindowClosedHandlesPic.addEventListener(Event.CLOSE,onClose);
		}
				
		protected function get titleWindowClosedHandlesPic():TitleWindowClosedHandlesPic
		{
			return viewComponent as TitleWindowClosedHandlesPic;
		}
		
		private function onClose(event:Event):void
		{
			PopUpManager.removePopUp(titleWindowClosedHandlesPic);
		}
				
		override public function listNotificationInterests():Array
		{
			return [
				ApplicationFacade.NOTIFY_TITLEWINDOW_CLOSED_IMGLST
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case ApplicationFacade.NOTIFY_TITLEWINDOW_CLOSED_IMGLST:
					titleWindowClosedHandlesPic.closedhandle = notification.getBody() as ClosedhandleVO; 
					
					if(!titleWindowClosedHandlesPic.closedhandle.pics)
					{						
						sendNotification(ApplicationFacade.NOTIFY_WEBSERVICE_SEND,
							["InitClosedhandlesPIC",onInitClosedhandlesPIC
								,[titleWindowClosedHandlesPic.closedhandle.T_ClosedhandlesID]
								,false]);
					}			
					else
					{
						titleWindowClosedHandlesPic.ImageIndex = 0;
					}
					break;
			}
		}
		
		private function onInitClosedhandlesPIC(result:ArrayCollection):void
		{
			titleWindowClosedHandlesPic.closedhandle.pics = new ArrayCollection;
			
			for each(var i:Object in result)
			{
				titleWindowClosedHandlesPic.closedhandle.pics.addItem(new ClosedHandlePicVO(i));
			}
			
			titleWindowClosedHandlesPic.ImageIndex = 0;
		}
	}
}