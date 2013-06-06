package app.view
{
	import app.model.LayerSettingSurroundingProxy;
	import app.view.components.MenuSub;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class MenuSurroundingMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "MenuSurroundingMediator";
		
		public function MenuSurroundingMediator()
		{
			super(NAME, new MenuSub);
			
			var layerSettingSurroundingProxy:LayerSettingSurroundingProxy = facade.retrieveProxy(LayerSettingSurroundingProxy.NAME) as LayerSettingSurroundingProxy;
			menuSurrounding.dataProvider = layerSettingSurroundingProxy.Layers;
		}
		
		protected function get menuSurrounding():MenuSub
		{
			return viewComponent as MenuSub;
		}
	}
}