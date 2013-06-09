package app.view
{
	import app.ApplicationFacade;
	import app.model.BuildProxy;
	import app.model.LayerSettingSurroundingProxy;
	import app.model.vo.ClosedhandleVO;
	import app.model.vo.CommandHeightVO;
	import app.model.vo.LayerVO;
	import app.view.components.ImageClosedHandle;
	import app.view.components.LayerClosedhandles;
	
	import mx.binding.utils.BindingUtils;
	import mx.collections.ArrayCollection;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class LayerCloseHandlesMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "LayerCloseHandlesMediator";
		
		private var buildProxy:BuildProxy;
		
		public function LayerCloseHandlesMediator()
		{
			super(NAME, new LayerClosedhandles);
			
			buildProxy = facade.retrieveProxy(BuildProxy.NAME) as BuildProxy;
		}
		
		protected function get layerClosedhandles():LayerClosedhandles
		{
			return viewComponent as LayerClosedhandles;
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				ApplicationFacade.NOTIFY_APP_INIT,
				
				ApplicationFacade.NOTIFY_SURROUNDING_CLOSEDHANDDLES
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case ApplicationFacade.NOTIFY_APP_INIT:						
					var layerSettingSurroundingProxy:LayerSettingSurroundingProxy = facade.retrieveProxy(LayerSettingSurroundingProxy.NAME) as LayerSettingSurroundingProxy;
					var layer:LayerVO = layerSettingSurroundingProxy.Layers[1];
					BindingUtils.bindProperty(layerClosedhandles,"visible",layer,"LayerVisible");
					break;
					
				case ApplicationFacade.NOTIFY_SURROUNDING_CLOSEDHANDDLES:	
					if(!buildProxy.build.closeHandles)
					{						
						sendNotification(ApplicationFacade.NOTIFY_WEBSERVICE_SEND,
							["InitClosedhandles",onInitClosedhandles
								,[buildProxy.build.TMB_ID]
								,false]);
					}			
					break;
			}
		}
		
		private function onInitClosedhandles(result:ArrayCollection):void
		{
			buildProxy.build.closeHandles = new ArrayCollection;
			for each(var i:Object in result)
			{
				var closedHandle:ClosedhandleVO = new ClosedhandleVO(i);
				buildProxy.build.closeHandles.addItem(closedHandle);
				
				var imageClosedHandle:ImageClosedHandle = new ImageClosedHandle;
				imageClosedHandle.closedhandle = closedHandle;
				
				facade.registerMediator(new ImageClosedHandleMediator("ImageClosedHandleMediator" + closedHandle.T_ClosedhandlesID,imageClosedHandle));
				
				layerClosedhandles.addElement(imageClosedHandle);
			}
			
		}
	}
}