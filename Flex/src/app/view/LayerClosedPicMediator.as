package app.view
{
	import app.ApplicationFacade;
	import app.model.vo.BuildVO;
	import app.model.vo.LayerVO;
	import app.view.components.LayerClosedPic;
	
	import mx.binding.utils.BindingUtils;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import spark.components.Image;
	
	public class LayerClosedPicMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "LayerClosedPicMediator";
		
		public function LayerClosedPicMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		protected function get layerClosedPic():Image
		{
			return viewComponent as Image;
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				ApplicationFacade.NOTIFY_INIT_BUILD
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case ApplicationFacade.NOTIFY_INIT_BUILD:				
					var build:BuildVO = notification.getBody() as BuildVO;
					layerClosedPic.source = build.T_ClosedPicPath;
										
					BindingUtils.bindProperty(layerClosedPic,"visible",LayerVO.CLOSEHANDLE,"LayerVisible");
					break;
			}
		}
	}
}