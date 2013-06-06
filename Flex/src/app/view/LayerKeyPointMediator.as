package app.view
{
	import app.ApplicationFacade;
	import app.model.BuildProxy;
	import app.model.LayerSettingSurroundingProxy;
	import app.model.vo.KeyPointVO;
	import app.model.vo.LayerVO;
	import app.view.components.ImageKeyPoint;
	import app.view.components.LayerKeyPoint;
	
	import mx.binding.utils.BindingUtils;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class LayerKeyPointMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "LayerKeyPointMediator";
		
		public function LayerKeyPointMediator()
		{
			super(NAME, new LayerKeyPoint);
		}
		
		protected function get layerKeyPoint():LayerKeyPoint
		{
			return viewComponent as LayerKeyPoint;
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
					
					for(var i:Number = 0;i<buildProxy.build.keyPoints.length;i++)
					{
						var keyPoint:KeyPointVO = buildProxy.build.keyPoints[i];
						
						var imageKeyPoint:ImageKeyPoint = new ImageKeyPoint;
						imageKeyPoint.keyPoint = keyPoint;
						
						facade.registerMediator(new ImageKeyPointMediator("ImageKeyPointMediator" + keyPoint.KeyPointId,imageKeyPoint));
						
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