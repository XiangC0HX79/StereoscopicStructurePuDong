package app.view
{
	import app.ApplicationFacade;
	import app.model.BuildProxy;
	import app.model.LayerSettingSurroundingProxy;
	import app.model.vo.LayerVO;
	import app.view.components.LayerControlRange;
	
	import mx.binding.utils.BindingUtils;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class LayerControlRangeMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "LayerControlRangeMediator";
		
		public function LayerControlRangeMediator()
		{
			super(NAME, new LayerControlRange);
		}
		
		protected function get layerControlRange():LayerControlRange
		{
			return viewComponent as LayerControlRange;
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				ApplicationFacade.NOTIFY_APP_INIT
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case ApplicationFacade.NOTIFY_APP_INIT:				
					var buildProxy:BuildProxy = facade.retrieveProxy(BuildProxy.NAME) as BuildProxy;
					if(buildProxy.build.controlRange)
					{
						layerControlRange.controlRange = buildProxy.build.controlRange;
					
						var layerSettingSurroundingProxy:LayerSettingSurroundingProxy = facade.retrieveProxy(LayerSettingSurroundingProxy.NAME) as LayerSettingSurroundingProxy;
						var layerSurrounding:LayerVO = layerSettingSurroundingProxy.Layers[1];
						BindingUtils.bindProperty(layerControlRange,"visible",layerSurrounding,"LayerVisible");
					}
					break;
			}
		}
	}
}