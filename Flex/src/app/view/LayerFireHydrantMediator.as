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
				ApplicationFacade.NOTIFY_INIT_APP,
				
				ApplicationFacade.NOTIFY_FIRE_ADD,
				ApplicationFacade.NOTIFY_FIRE_DEL
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case ApplicationFacade.NOTIFY_INIT_APP:				
					for each(var i:FireHydrantVO in (notification.getBody() as BuildVO).FireHydrant)
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
			var imageFireHydrant:ImageFireHydrant = new ImageFireHydrant;
			
			imageFireHydrant.FireHydrant = fireHydrant;
			
			facade.registerMediator(new ImageFireHydrantMediator("ImageFireHydrantMediator" + fireHydrant.T_FireHydrantID,imageFireHydrant));
			
			layerFireHydrant.addElement(imageFireHydrant);
		}
		
		private function delFire(fireHydrant:FireHydrantVO):void
		{			
			var mn:String = "ImageFireHydrantMediator" + fireHydrant.T_FireHydrantID;
			
			var fm:ImageFireHydrantMediator = facade.retrieveMediator(mn) as ImageFireHydrantMediator;
			
			if(fm)
			{
				layerFireHydrant.removeElement(fm.getViewComponent() as IVisualElement);
				facade.removeMediator(mn);
			}
		}
	}
}