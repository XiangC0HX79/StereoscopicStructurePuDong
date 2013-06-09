package app.view
{
	import app.ApplicationFacade;
	import app.view.components.ImageHazard;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class ImageHazardMediator extends Mediator implements IMediator
	{
		public function ImageHazardMediator(mediatorName:String=null, viewComponent:Object=null)
		{
			super(mediatorName, viewComponent);
						
			imageHazard.addEventListener(MouseEvent.CLICK,onClick);
		}
		
		protected function get imageHazard():ImageHazard
		{
			return viewComponent as ImageHazard;
		}
		
		private function onClick(event:Event):void
		{				
			sendNotification(ApplicationFacade.NOTIFY_TITLEWINDOW_HAZARD,imageHazard.Hazard);
		}
	}
}