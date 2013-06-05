package app.view
{
	import app.ApplicationFacade;
	import app.model.LayerSettingStereoScopicProxy;
	import app.view.components.MenuStereoScopicStructure;
	
	import flash.events.Event;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class MenuStereoScopicStructureMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "MenuStereoScopicStructureMediator";
		
		public function MenuStereoScopicStructureMediator()
		{
			super(NAME, new MenuStereoScopicStructure);			
			
			menuStereoScopicStructure.addEventListener(Event.CHANGE,onChange);
			
			var layerSettingStereoScopicProxy:LayerSettingStereoScopicProxy = facade.retrieveProxy(LayerSettingStereoScopicProxy.NAME) as LayerSettingStereoScopicProxy;
			menuStereoScopicStructure.dataProvider = layerSettingStereoScopicProxy.Layers;
		}
		
		protected function get menuStereoScopicStructure():MenuStereoScopicStructure
		{
			return viewComponent as MenuStereoScopicStructure;
		}
		
		private function onChange(event:Event):void
		{
			event.stopImmediatePropagation();
			
			sendNotification(ApplicationFacade.NOTIFY_STEREO_LAYER);
		}
	}
}