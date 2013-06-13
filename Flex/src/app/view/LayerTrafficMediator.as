package app.view
{
	import app.ApplicationFacade;
	import app.model.BuildProxy;
	import app.model.vo.LayerVO;
	import app.model.vo.TrafficInfoVO;
	import app.view.components.ImageTraffic;
	import app.view.components.LayerTraffic;
	
	import mx.binding.utils.BindingUtils;
	import mx.collections.ArrayCollection;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class LayerTrafficMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "LayerTrafficMediator";
		
		private var buildProxy:BuildProxy;
		
		public function LayerTrafficMediator()
		{
			super(NAME, new LayerTraffic);
			
			buildProxy = facade.retrieveProxy(BuildProxy.NAME) as BuildProxy;
		}
		
		protected function get layerTraffic():LayerTraffic
		{
			return viewComponent as LayerTraffic;
		}
		
		override public function listNotificationInterests():Array
		{
			return [				
				ApplicationFacade.NOTIFY_INIT_APP
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{					
				case ApplicationFacade.NOTIFY_INIT_APP:	
					BindingUtils.bindProperty(layerTraffic,"visible",LayerVO.TRAFFIC,"LayerVisible");
					
					for each(var i:TrafficInfoVO in buildProxy.build.Traffic)
					{
						var imageTraffic:ImageTraffic = new ImageTraffic;
						imageTraffic.trafficInfo = i;
						
						facade.registerMediator(new ImageTrafficMediator("ImageTrafficMediator" + i.T_TrafficID,imageTraffic));
						
						layerTraffic.addElement(imageTraffic);
					}
					break;
			}
		}
	}
}