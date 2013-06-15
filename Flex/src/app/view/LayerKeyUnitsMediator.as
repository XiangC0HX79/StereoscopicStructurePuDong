package app.view
{
	import app.ApplicationFacade;
	import app.model.BuildProxy;
	import app.model.vo.KeyUnitVO;
	import app.model.vo.LayerVO;
	import app.view.components.ImageKeyUnit;
	import app.view.components.LayerKeyUnits;
	
	import mx.binding.utils.BindingUtils;
	import mx.collections.ArrayCollection;
	import mx.core.IVisualElement;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class LayerKeyUnitsMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "LayerKeyUnitsMediator";
		
		private var buildProxy:BuildProxy;
		
		public function LayerKeyUnitsMediator()
		{
			super(NAME, new LayerKeyUnits);
			
			buildProxy = facade.retrieveProxy(BuildProxy.NAME) as BuildProxy;
		}
		
		protected function get layerKeyUnits():LayerKeyUnits
		{
			return viewComponent as LayerKeyUnits;
		}
		
		override public function listNotificationInterests():Array
		{
			return [				
				ApplicationFacade.NOTIFY_INIT_KEYUNIT
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{					
				case ApplicationFacade.NOTIFY_INIT_KEYUNIT:						
					for each(var i:KeyUnitVO in notification.getBody())
					{
						var kum:ImageKeyUnitMediator = new ImageKeyUnitMediator(i);
						
						facade.registerMediator(kum);
						
						layerKeyUnits.addElement(kum.getViewComponent() as IVisualElement);
					}
					
					BindingUtils.bindProperty(layerKeyUnits,"visible",LayerVO.KEYUNITS,"LayerVisible");
					break;
			}
		}
	}
}