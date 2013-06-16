package app.model
{
	import app.ApplicationFacade;
	import app.model.vo.ConfigVO;
	import app.model.vo.FloorPicVO;
	
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	
	import mx.rpc.events.ResultEvent;
	
	import org.puremvc.as3.interfaces.IProxy;
	
	public class FloorPicProxy extends WebServiceProxy implements IProxy
	{
		public static const NAME:String = "FloorPicProxy";
		
		public function FloorPicProxy()
		{
			super(NAME, new Dictionary);
		}
		
		public function get dict():Dictionary
		{
			return data as Dictionary
		}
		
		public function Init():void
		{
			send("InitFloorPic",onInitFloorPic,ConfigVO.TMB_ID);
		}
		
		private function onInitFloorPic(event:ResultEvent):void
		{						
			for each(var i:Object in event.result.Tables.Table.Rows)
			{
				var fp:FloorPicVO = new FloorPicVO(i);					
				dict[fp.T_FloorPicID] = fp;
								
				var token:Object = load(fp.T_FloorPicimgPath,onloadFloorPic);
				token.floorPic = fp;
			}
			
			onInit();
		}
		
		private function onloadFloorPic(bitmap:Bitmap,token:Object):void
		{
			var fp:FloorPicVO = token.floorPic;
			
			fp.bitmap = bitmap;
			
			sendNotification(ApplicationFacade.NOTIFY_APP_LOADINGTEXT,"系统初始化：组件图片" + fp.T_FloorPicID + "加载完成...");
			
			onInit();
		}
		
		private function onInit():void
		{
			for each(var fp:FloorPicVO in dict)
			{
				if(!fp.bitmap)
					return;
			}			
			
			sendNotification(ApplicationFacade.NOTIFY_INIT_FLOORPIC,dict);	
		}
	}
}