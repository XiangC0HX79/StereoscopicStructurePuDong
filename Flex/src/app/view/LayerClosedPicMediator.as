package app.view
{
	import app.ApplicationFacade;
	import app.model.BuildProxy;
	import app.model.LayerSettingSurroundingProxy;
	import app.model.vo.CommandHeightVO;
	import app.model.vo.LayerVO;
	import app.view.components.LayerClosedPic;
	
	import mx.binding.utils.BindingUtils;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class LayerClosedPicMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "LayerClosedPicMediator";
		
		public function LayerClosedPicMediator()
		{
			super(NAME, new LayerClosedPic);
		}
		
		protected function get layerClosedPic():LayerClosedPic
		{
			return viewComponent as LayerClosedPic;
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
					layerClosedPic.source = buildProxy.build.T_ClosedPicPath;
										
					var layerSettingSurroundingProxy:LayerSettingSurroundingProxy = facade.retrieveProxy(LayerSettingSurroundingProxy.NAME) as LayerSettingSurroundingProxy;
					BindingUtils.bindProperty(layerClosedPic,"visible",LayerVO.CLOSEHANDLE,"LayerVisible");
					break;
			}
		}
	}
}