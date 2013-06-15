package app.view
{
	import app.ApplicationFacade;
	import app.model.BuildProxy;
	import app.model.vo.LayerVO;
	import app.model.vo.ScentingVO;
	import app.view.components.ImageScenting;
	import app.view.components.LayerScenting;
	
	import mx.binding.utils.BindingUtils;
	import mx.collections.ArrayCollection;
	import mx.core.IVisualElement;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class LayerScentingMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "LayerScentingMediator";
		
		private var buildProxy:BuildProxy;
		
		public function LayerScentingMediator()
		{
			super(NAME, new LayerScenting);
			
			buildProxy = facade.retrieveProxy(BuildProxy.NAME) as BuildProxy;
		}
		
		protected function get layerScenting():LayerScenting
		{
			return viewComponent as LayerScenting;
		}
		
		override public function listNotificationInterests():Array
		{
			return [				
				ApplicationFacade.NOTIFY_INIT_SCENTING
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{					
				case ApplicationFacade.NOTIFY_INIT_SCENTING:									
					for each(var i:ScentingVO in notification.getBody())
					{
						var scm:ImageScentingMediator = new ImageScentingMediator(i);
						
						facade.registerMediator(scm);
						
						layerScenting.addElement(scm.getViewComponent() as IVisualElement);
					}
					
					BindingUtils.bindProperty(layerScenting,"visible",LayerVO.SCENTING,"LayerVisible");
					break;
			}
		}
	}
}