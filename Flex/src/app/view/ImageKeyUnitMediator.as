package app.view
{
	import app.ApplicationFacade;
	import app.view.components.ImageKeyUnit;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class ImageKeyUnitMediator extends Mediator implements IMediator
	{
		public function ImageKeyUnitMediator(mediatorName:String=null, viewComponent:Object=null)
		{
			super(mediatorName, viewComponent);
						
			imageKeyUnit.addEventListener(MouseEvent.CLICK,onClick);
		}
		
		protected function get imageKeyUnit():ImageKeyUnit
		{
			return viewComponent as ImageKeyUnit;
		}
		
		private function onClick(event:Event):void
		{				
			sendNotification(ApplicationFacade.NOTIFY_TITLEWINDOW_KEYUNIT,imageKeyUnit.keyUnit);
		}
	}
}