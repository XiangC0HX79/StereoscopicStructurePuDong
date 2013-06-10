package app.view
{
	import app.ApplicationFacade;
	import app.model.BuildProxy;
	import app.model.LayerSettingSurroundingProxy;
	import app.model.vo.BuildVO;
	import app.model.vo.CommandHeightVO;
	import app.model.vo.LayerVO;
	import app.view.components.ImageCommandingHeight;
	import app.view.components.LayerCommandingHeightPoint;
	
	import mx.binding.utils.BindingUtils;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class LayerCommandingHeightMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "LayerKeyPointMediator";
		
		public function LayerCommandingHeightMediator()
		{
			super(NAME, new LayerCommandingHeightPoint);
		}
		
		protected function get layerKeyPoint():LayerCommandingHeightPoint
		{
			return viewComponent as LayerCommandingHeightPoint;
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
					for each(var commandingHeight:CommandHeightVO in (notification.getBody() as BuildVO).CommandingHeights)
					{						
						var imageCommandingHeight:ImageCommandingHeight = new ImageCommandingHeight;
						
						imageCommandingHeight.commandingHeight = commandingHeight;
						
						facade.registerMediator(new ImageCommandHeightMediator("ImageCommandHeightMediator" + commandingHeight.TCH_ID,imageCommandingHeight));
						
						layerKeyPoint.addElement(imageCommandingHeight);
					}
					
					var layerSettingSurroundingProxy:LayerSettingSurroundingProxy = facade.retrieveProxy(LayerSettingSurroundingProxy.NAME) as LayerSettingSurroundingProxy;
					BindingUtils.bindProperty(layerKeyPoint,"visible",LayerVO.COMMANDHEIGHT,"LayerVisible");
					break;
			}
		}
	}
}