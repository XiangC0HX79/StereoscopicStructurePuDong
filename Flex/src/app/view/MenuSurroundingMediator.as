package app.view
{
	import app.ApplicationFacade;
	import app.model.BuildProxy;
	import app.model.LayerSettingSurroundingProxy;
	import app.model.vo.KeyUnitVO;
	import app.model.vo.LayerVO;
	import app.view.components.MenuSub;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class MenuSurroundingMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "MenuSurroundingMediator";
				
		public function MenuSurroundingMediator()
		{
			super(NAME, new MenuSub);
			
			menuSurrounding.addEventListener(Event.CHANGE,onChange);
			
			var layerSettingSurroundingProxy:LayerSettingSurroundingProxy = facade.retrieveProxy(LayerSettingSurroundingProxy.NAME) as LayerSettingSurroundingProxy;
			menuSurrounding.dataProvider = layerSettingSurroundingProxy.Layers;
			
		}
		
		protected function get menuSurrounding():MenuSub
		{
			return viewComponent as MenuSub;
		}
		
		private function onChange(event:Event):void
		{
			var buildProxy:BuildProxy = facade.retrieveProxy(BuildProxy.NAME) as BuildProxy;
			
			event.stopImmediatePropagation();
			
			var layer:LayerVO = event.target.data as LayerVO;
			if(layer.LayerName == "分控范围")
			{
				sendNotification(ApplicationFacade.NOTIFY_SURROUNDING_CLOSEDHANDDLES);
			}
			else if(layer.LayerName == "救援信息")
			{
				sendNotification(ApplicationFacade.NOTIFY_SURROUNDING_RESCUE,layer.LayerVisible);
			}
			else if(layer == LayerVO.KEYUNITS)
			{
			}			
		}
	}
}