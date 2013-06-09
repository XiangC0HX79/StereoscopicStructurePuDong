package app.view
{
	import app.ApplicationFacade;
	import app.view.components.ImageTraffic;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class ImageTrafficMediator extends Mediator implements IMediator
	{
		public function ImageTrafficMediator(mediatorName:String=null, viewComponent:Object=null)
		{
			super(mediatorName, viewComponent);
						
			imageTraffic.addEventListener(MouseEvent.CLICK,onClick);
		}
		
		protected function get imageTraffic():ImageTraffic
		{
			return viewComponent as ImageTraffic;
		}
		
		private function onClick(event:Event):void
		{				
			sendNotification(ApplicationFacade.NOTIFY_TITLEWINDOW_TRAFFIC,imageTraffic.trafficInfo);
		}
	}
}