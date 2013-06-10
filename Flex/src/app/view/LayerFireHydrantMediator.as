package app.view
{
	import app.ApplicationFacade;
	import app.model.BuildProxy;
	import app.model.LayerSettingSurroundingProxy;
	import app.model.vo.LayerVO;
	import app.view.components.LayerFireHydrant;
	
	import mx.binding.utils.BindingUtils;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class LayerFireHydrantMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "LayerFireHydrantMediator";
		
		public function LayerFireHydrantMediator()
		{
			super(NAME, new LayerFireHydrant);
		}
		
		protected function get layerFireHydrant():LayerFireHydrant
		{
			return viewComponent as LayerFireHydrant;
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
					layerFireHydrant.pic = buildProxy.build.T_FirePath;
										
					var layerSettingSurroundingProxy:LayerSettingSurroundingProxy = facade.retrieveProxy(LayerSettingSurroundingProxy.NAME) as LayerSettingSurroundingProxy;
					BindingUtils.bindProperty(layerFireHydrant,"visible",LayerVO.FIRE,"LayerVisible");
					break;
			}
		}
	}
}