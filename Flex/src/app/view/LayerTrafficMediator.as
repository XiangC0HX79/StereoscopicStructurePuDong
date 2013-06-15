package app.view
{
	import app.ApplicationFacade;
	import app.model.vo.LayerVO;
	import app.model.vo.TrafficVO;
	import app.view.components.ImageTraffic;
	import app.view.components.LayerTraffic;
	
	import mx.binding.utils.BindingUtils;
	import mx.collections.ArrayCollection;
	import mx.core.IVisualElement;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class LayerTrafficMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "LayerTrafficMediator";
				
		public function LayerTrafficMediator()
		{
			super(NAME, new LayerTraffic);
		}
		
		protected function get layerTraffic():LayerTraffic
		{
			return viewComponent as LayerTraffic;
		}
		
		override public function listNotificationInterests():Array
		{
			return [				
				ApplicationFacade.NOTIFY_INIT_TRAFFIC
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{					
				case ApplicationFacade.NOTIFY_INIT_TRAFFIC:						
					for each(var i:TrafficVO in notification.getBody())
					{
						var trm:ImageTrafficMediator = new ImageTrafficMediator(i);
						
						facade.registerMediator(trm);
						
						layerTraffic.addElement(trm.getViewComponent() as IVisualElement);
					}
					
					BindingUtils.bindProperty(layerTraffic,"visible",LayerVO.TRAFFIC,"LayerVisible");
					break;
			}
		}
	}
}