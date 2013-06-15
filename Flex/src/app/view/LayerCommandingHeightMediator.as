package app.view
{
	import app.ApplicationFacade;
	import app.model.BuildProxy;
	import app.model.vo.BuildVO;
	import app.model.vo.CommandHeightVO;
	import app.model.vo.LayerVO;
	import app.view.components.LayerCommandingHeightPoint;
	
	import mx.binding.utils.BindingUtils;
	import mx.core.IUIComponent;
	import mx.core.IVisualElement;
	import mx.events.DragEvent;
	import mx.managers.DragManager;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import spark.components.Group;
	
	public class LayerCommandingHeightMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "LayerCommandingHeightMediator";
		
		public function LayerCommandingHeightMediator()
		{
			super(NAME, new LayerCommandingHeightPoint);
		}
		
		protected function get layerCommandingHeight():LayerCommandingHeightPoint
		{
			return viewComponent as LayerCommandingHeightPoint;
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				ApplicationFacade.NOTIFY_INIT_COMMANDHEIGHT
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case ApplicationFacade.NOTIFY_INIT_COMMANDHEIGHT:									
					for each(var ch:CommandHeightVO in notification.getBody())
					{						
						var chm:ImageCommandHeightMediator = new ImageCommandHeightMediator(ch);
												
						facade.registerMediator(chm);
						
						layerCommandingHeight.addElement(chm.getViewComponent() as IVisualElement);
					}
					
					BindingUtils.bindProperty(layerCommandingHeight,"visible",LayerVO.COMMANDHEIGHT,"LayerVisible");
					break;
			}
		}
	}
}