package app.view
{
	import app.ApplicationFacade;
	import app.model.BuildProxy;
	import app.model.vo.HazardVO;
	import app.model.vo.LayerVO;
	import app.view.components.ImageHazard;
	import app.view.components.LayerHazard;
	
	import mx.binding.utils.BindingUtils;
	import mx.collections.ArrayCollection;
	import mx.core.IVisualElement;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class LayerHazardMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "LayerHazardMediator";
		
		private var buildProxy:BuildProxy;
		
		public function LayerHazardMediator()
		{
			super(NAME, new LayerHazard);
			
			buildProxy = facade.retrieveProxy(BuildProxy.NAME) as BuildProxy;
		}
		
		protected function get layerHazard():LayerHazard
		{
			return viewComponent as LayerHazard;
		}
		
		override public function listNotificationInterests():Array
		{
			return [				
				ApplicationFacade.NOTIFY_INIT_HAZZARD
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{					
				case ApplicationFacade.NOTIFY_INIT_HAZZARD:						
					for each(var i:HazardVO in notification.getBody())
					{
						var hzm:ImageHazardMediator = new ImageHazardMediator(i);
						
						facade.registerMediator(hzm);
						
						layerHazard.addElement(hzm.getViewComponent() as IVisualElement);
					}
					
					BindingUtils.bindProperty(layerHazard,"visible",LayerVO.HAZARD,"LayerVisible");
					break;
			}
		}
	}
}