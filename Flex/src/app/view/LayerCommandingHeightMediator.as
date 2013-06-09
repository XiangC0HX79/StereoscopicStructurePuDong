package app.view
{
	import app.ApplicationFacade;
	import app.model.BuildProxy;
	import app.model.LayerSettingSurroundingProxy;
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
					var buildProxy:BuildProxy = facade.retrieveProxy(BuildProxy.NAME) as BuildProxy;
					
					for(var i:Number = 0;i<buildProxy.build.CommandingHeights.length;i++)
					{
						var commandingHeight:CommandHeightVO = buildProxy.build.CommandingHeights[i];
						
						var imageKeyPoint:ImageCommandingHeight = new ImageCommandingHeight;
						imageKeyPoint.commandingHeight = commandingHeight;
						
						facade.registerMediator(new ImageCommandHeightMediator("ImageKeyPointMediator" + commandingHeight.TCH_ID,imageKeyPoint));
						
						layerKeyPoint.addElement(imageKeyPoint);
					}
					
					var layerSettingSurroundingProxy:LayerSettingSurroundingProxy = facade.retrieveProxy(LayerSettingSurroundingProxy.NAME) as LayerSettingSurroundingProxy;
					var layerSurrounding:LayerVO = layerSettingSurroundingProxy.Layers[0];
					BindingUtils.bindProperty(layerKeyPoint,"visible",layerSurrounding,"LayerVisible");
					break;
			}
		}
	}
}