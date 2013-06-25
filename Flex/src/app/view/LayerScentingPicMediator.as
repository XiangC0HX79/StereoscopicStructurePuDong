package app.view
{
	import app.ApplicationFacade;
	import app.model.BuildProxy;
	import app.model.vo.BuildVO;
	import app.model.vo.CommandHeightVO;
	import app.model.vo.LayerVO;
	import app.view.components.LayerScentingPic;
	
	import mx.binding.utils.BindingUtils;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import spark.components.Image;
	
	public class LayerScentingPicMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "LayerScentingPicMediator";
		
		public function LayerScentingPicMediator(viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		
		protected function get layerScentingPic():Image
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
					
					layerScentingPic.source = build.T_ScentingPicPath;
										
					BindingUtils.bindProperty(layerScentingPic,"visible",LayerVO.SCENTING,"LayerVisible");
					break;
			}
		}
	}
}