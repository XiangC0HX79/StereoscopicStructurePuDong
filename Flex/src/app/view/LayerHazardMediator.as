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
				ApplicationFacade.NOTIFY_INIT_APP
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{					
				case ApplicationFacade.NOTIFY_INIT_APP:	
					BindingUtils.bindProperty(layerHazard,"visible",LayerVO.HAZARD,"LayerVisible");
					
					for each(var i:HazardVO in buildProxy.build.Hazzard)
					{
						var imageHazard:ImageHazard = new ImageHazard;
						imageHazard.Hazard = i;
						
						facade.registerMediator(new ImageHazardMediator("ImageHazardMediator" + i.T_HazardID,imageHazard));
						
						layerHazard.addElement(imageHazard);
					}
					break;
			}
		}
	}
}