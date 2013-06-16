package app.view
{
	import app.ApplicationFacade;
	import app.model.IconsProxy;
	import app.model.vo.ConfigVO;
	import app.model.vo.ImportExportPicVO;
	import app.model.vo.ImportExportVO;
	import app.view.components.ImageImportExport;
	
	import com.adobe.utils.DictionaryUtil;
	
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Image;
	import mx.core.DragSource;
	import mx.managers.DragManager;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
		
	public class ImageImportExportMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "ImageImportExportMediator";
		
		public function ImageImportExportMediator(importExport:ImportExportVO)
		{
			super(NAME + importExport.T_ImportExportID, new ImageImportExport);
								
			if(DictionaryUtil.getKeys(importExport.DictImportExportPic).length > 0)
			{
				imageImportExport.buttonMode = true;
				
				imageImportExport.addEventListener(MouseEvent.CLICK,onComponentClick);
			}
			
			if(ConfigVO.EDIT)
			{
				imageImportExport.addEventListener(MouseEvent.MOUSE_MOVE,onDragStart);
			}
			
			var iconsProxy:IconsProxy = facade.retrieveProxy(IconsProxy.NAME) as IconsProxy;
			imageImportExport.source = iconsProxy.icons.IconImportExport;
			
			imageImportExport.ImportExport = importExport;			
		}
		
		protected function get imageImportExport():ImageImportExport
		{
			return viewComponent as ImageImportExport;
		}
				
		private function onComponentClick(event:MouseEvent):void
		{						
			sendNotification(ApplicationFacade.NOTIFY_TITLEWINDOW_MEDIA,imageImportExport.ImportExport.DictImportExportPic);
		}
		
		private function onDragStart(e:MouseEvent):void
		{						
			var imageProxy:Image = new Image;
			imageProxy.source = imageImportExport.source;
			
			var ds:DragSource = new DragSource();  
			ds.addData(imageImportExport.ImportExport,"ImportExportVO");
			ds.addData(new Point(e.localX,e.localY),"StartPoint");
			DragManager.doDrag(imageImportExport,ds,e,imageProxy); 
		}	
	}
}