package app.view
{
	import app.ApplicationFacade;
	import app.view.components.ImageScenting;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class ImageScentingMediator extends Mediator implements IMediator
	{
		public function ImageScentingMediator(mediatorName:String=null, viewComponent:Object=null)
		{
			super(mediatorName, viewComponent);
						
			imageScenting.addEventListener(MouseEvent.CLICK,onClick);
		}
		
		protected function get imageScenting():ImageScenting
		{
			return viewComponent as ImageScenting;
		}
		
		private function onClick(event:Event):void
		{				
			sendNotification(ApplicationFacade.NOTIFY_TITLEWINDOW_SCENTING,imageScenting.scenting);
		}
	}
}