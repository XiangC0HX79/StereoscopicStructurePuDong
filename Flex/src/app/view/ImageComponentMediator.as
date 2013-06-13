package app.view
{
	import app.ApplicationFacade;
	import app.model.BuildProxy;
	import app.model.vo.ConfigVO;
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
			var buildProxy:BuildProxy = facade.retrieveProxy(BuildProxy.NAME) as BuildProxy;
			buildProxy.LoadComponentMedia(imageComponent.component,onLoadComponentMedia);
		}
		
		private function onLoadComponentMedia(result:ArrayCollection):void
		{						
			var video:String;
			var medias:ArrayCollection = new ArrayCollection;
			
			for each(var item:Object in result)
			{
				if(item.T_FloorMediaType == 1)
				{
					medias.addItem(new MediaVO(item));
				}
				else if(item.T_FloorMediaType == 2)
				{
					video = item.T_FloorMediaPicPath.replace("../",ConfigVO.BASE_URL);
				}
			}
			
			if(medias.length > 0)
				sendNotification(ApplicationFacade.NOTIFY_TITLEWINDOW_IMAGE,[video,medias]);
		}
	}
}