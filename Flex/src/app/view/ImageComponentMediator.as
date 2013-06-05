package app.view
{
	import app.ApplicationFacade;
	import app.model.BuildProxy;
	import app.model.vo.MediaVO;
	import app.view.components.ImageComponent;
	
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import spark.components.Image;
	
	public class ImageComponentMediator extends Mediator implements IMediator
	{
		public function ImageComponentMediator(mediatorName:String=null, viewComponent:Object=null)
		{
			super(mediatorName, viewComponent);
			
			imageComponent.addEventListener(MouseEvent.CLICK,onComponentClick);
		}
		
		protected function get imageComponent():ImageComponent
		{
			return viewComponent as ImageComponent;
		}
				
		private function onComponentClick(event:MouseEvent):void
		{
			sendNotification(ApplicationFacade.NOTIFY_WEBSERVICE_SEND,
				["InitComponentMedia",onInitComponentMedia
					,[imageComponent.component.componentID]
					,true]);
			
			function onInitComponentMedia(result:ArrayCollection):void
			{						
				imageComponent.component.listMedia.removeAll();
				
				imageComponent.component.videoName = "";
				
				for each(var item:Object in result)
				{
					if(item.T_FloorMediaType == 1)
					{
						imageComponent.component.listMedia.addItem(new MediaVO(item));
					}
					else if(item.T_FloorMediaType == 2)
					{
						imageComponent.component.videoName = item.T_FloorMediaPicPath;
					}
				}
				
				if(imageComponent.component.listMedia.length > 0)
					sendNotification(ApplicationFacade.NOTIFY_TITLEWINDOW_IMAGE,imageComponent.component);
			}
		}
	}
}