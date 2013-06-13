package app.view
{
	import app.ApplicationFacade;
	import app.model.BuildProxy;
	import app.model.vo.BuildVO;
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
				ApplicationFacade.NOTIFY_INIT_APP
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case ApplicationFacade.NOTIFY_INIT_APP:		
					for each(var closedHandle:ClosedhandleVO in (notification.getBody() as BuildVO).CloseHandles)
					{						
						var imageClosedHandle:ImageClosedHandle = new ImageClosedHandle;
						
						imageClosedHandle.closedhandle = closedHandle;
						
						facade.registerMediator(new ImageClosedHandleMediator("ImageClosedHandleMediator" + closedHandle.T_ClosedhandlesID,imageClosedHandle));
						
						layerClosedhandles.addElement(imageClosedHandle);
					}
					
					BindingUtils.bindProperty(layerClosedhandles,"visible",LayerVO.CLOSEHANDLE,"LayerVisible");
					break;
			}
		}
	}
}