package app.view
{
	import app.ApplicationFacade;
	import app.model.BuildProxy;
	import app.view.components.PanelSurrounding;
	
	import mx.core.IVisualElement;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class PanelSurroundingMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "PanelSurroundingMediator";
		
		public function PanelSurroundingMediator()
		{
			super(NAME, new PanelSurrounding);
			
			var layerKeyPointMediator:LayerKeyPointMediator = facade.retrieveMediator(LayerKeyPointMediator.NAME) as LayerKeyPointMediator;
			panelSurrounding.addElement(layerKeyPointMediator.getViewComponent() as IVisualElement);
			
			var layerControlRangeMediator:LayerControlRangeMediator = facade.retrieveMediator(LayerControlRangeMediator.NAME) as LayerControlRangeMediator;
			panelSurrounding.addElement(layerControlRangeMediator.getViewComponent() as IVisualElement);
		}
		
		protected function get panelSurrounding():PanelSurrounding
		{
			return viewComponent as PanelSurrounding;
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
					panelSurrounding.SurroudingBitmap = buildProxy.build.surroundingBitmap;
					break;
			}
		}
	}
}