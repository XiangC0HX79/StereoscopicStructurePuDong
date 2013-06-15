package app.view
{
	import app.ApplicationFacade;
	import app.model.BuildProxy;
	import app.model.vo.BuildVO;
	import app.model.vo.FireHydrantVO;
	import app.model.vo.LayerVO;
	import app.view.components.ImageFireHydrant;
	import app.view.components.LayerFireHydrant;
	
	import mx.binding.utils.BindingUtils;
	import mx.core.IVisualElement;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class LayerFireHydrantMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "LayerFireHydrantMediator";
		
		public function LayerFireHydrantMediator()
		{
			super(NAME, new LayerFireHydrant);
		}
		
		protected function get layerFireHydrant():LayerFireHydrant
		{
			return viewComponent as LayerFireHydrant;
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				ApplicationFacade.NOTIFY_INIT_FIREHYDRANT,
				
				ApplicationFacade.NOTIFY_FIRE_ADD,
				ApplicationFacade.NOTIFY_FIRE_DEL
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case ApplicationFacade.NOTIFY_INIT_FIREHYDRANT:				
					for each(var i:FireHydrantVO in notification.getBody())
						addFire(i);
					
					BindingUtils.bindProperty(layerFireHydrant,"visible",LayerVO.FIRE,"LayerVisible");
					break;
				
				case ApplicationFacade.NOTIFY_FIRE_ADD:
					addFire(notification.getBody() as FireHydrantVO);
					break;
				
				case ApplicationFacade.NOTIFY_FIRE_DEL:
					delFire(notification.getBody() as FireHydrantVO);
					break;
			}
		}
		
		private function addFire(fireHydrant:FireHydrantVO):void
		{			
			var fhm:ImageFireHydrantMediator = new ImageFireHydrantMediator(fireHydrant);
						
			facade.registerMediator(fhm);
			
			layerFireHydrant.addElement(fhm.getViewComponent() as IVisualElement);
		}
		
		private function delFire(fireHydrant:FireHydrantVO):void
		{						
			var fhm:ImageFireHydrantMediator = facade.retrieveMediator(ImageFireHydrantMediator.NAME + fireHydrant.T_FireHydrantID) as ImageFireHydrantMediator;
			
			if(fhm)
			{
				layerFireHydrant.removeElement(fhm.getViewComponent() as IVisualElement);
				facade.removeMediator(fhm.getMediatorName());
			}
		}
	}
}