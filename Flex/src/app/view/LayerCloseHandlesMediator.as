package app.view
{
	import app.ApplicationFacade;
	import app.model.BuildProxy;
	import app.model.vo.BuildVO;
	import app.model.vo.ClosedHandleVO;
	import app.model.vo.CommandHeightVO;
	import app.model.vo.LayerVO;
	import app.view.components.ImageClosedHandle;
	import app.view.components.LayerClosedhandles;
	
	import flash.utils.Dictionary;
	
	import mx.binding.utils.BindingUtils;
	import mx.collections.ArrayCollection;
	import mx.core.IVisualElement;
	
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
				ApplicationFacade.NOTIFY_INIT_CLOSEDHANDLE
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case ApplicationFacade.NOTIFY_INIT_CLOSEDHANDLE:		
					for each(var ch:ClosedHandleVO in notification.getBody() as Dictionary)
					{						
						var chm:ImageClosedHandleMediator = new ImageClosedHandleMediator(ch);
												
						facade.registerMediator(chm);
						
						layerClosedhandles.addElement(chm.getViewComponent() as IVisualElement);
					}
					
					BindingUtils.bindProperty(layerClosedhandles,"visible",LayerVO.CLOSEHANDLE,"LayerVisible");
					break;
			}
		}
	}
}