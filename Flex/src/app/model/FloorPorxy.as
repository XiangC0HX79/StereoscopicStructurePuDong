package app.model
{
	import app.ApplicationFacade;
	import app.model.vo.BuildVO;
	import app.model.vo.ConfigVO;
	import app.model.vo.FloorDetailVO;
	import app.model.vo.FloorVO;
	import app.model.vo.LayerVO;
	import app.model.vo.MediaVO;
	
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.events.ResultEvent;
	
	import org.puremvc.as3.interfaces.IProxy;
	
	public class FloorPorxy extends WebServiceProxy implements IProxy
	{
		public static const NAME:String ="FloorPorxy";
		
		private var _buildWidth:Number;
		private var _buildHeight:Number;
		
		public function FloorPorxy()
		{
			super(NAME, new Dictionary);
		}
		
		public function get dict():Dictionary
		{
			return data as Dictionary
		}
		
		public function hasFloorDetail(layer:LayerVO):Boolean
		{
			for each(var floor:FloorVO in dict)
			{
				for each(var fd:FloorDetailVO in floor.floorDetails)
				{
					if(fd.layer == layer)
						return true;
				}
			}
			
			return false;
		}
		
		public function Init(build:BuildVO):void
		{
			_buildWidth = build.BitmapWidth;
			_buildHeight = build.BitmapHeight;
				
			send("InitFloor",onInitFloor,ConfigVO.TMB_ID);
		}
		
		private function onInitFloor(event:ResultEvent):void
		{									
			for each(var i:Object in event.result.Tables.Table.Rows)
			{
				var floor:FloorVO = new FloorVO(i);			
				
				dict[floor.T_FloorID] = floor;
				
				var token:Object = LoadFloorBitmap(floor,onLoadFloorBitmap);
				token.floor = floor;
			}
			
			initComponent();
		}
		
		private function onLoadFloorBitmap(bitmap:Bitmap,token:Object):void
		{
			var floor:FloorVO = token.floor;
			
			floor.floorBitmap = bitmap;
			if(!floor.T_FloorScale)
				floor.T_FloorScale = floor.floorBitmap.width / _buildWidth
						
			sendNotification(ApplicationFacade.NOTIFY_APP_LOADINGTEXT,"系统初始化：楼层图片" + floor.T_FloorID + "加载完成...");
			
			initComponent();
		}
		
		private function initComponent():void
		{
			for each(var floor:FloorVO in dict)
			{
				if(!floor.floorBitmap)
					return;
			}
			
			send("InitComponent",onInitComponent,ConfigVO.TMB_ID);
		}
		
		private function onInitComponent(event:ResultEvent):void
		{					
			for each(var i:Object in event.result.Tables.Table.Rows)
			{
				var fd:FloorDetailVO = new FloorDetailVO(i);		
				
				var floor:FloorVO = dict[fd.T_FloorID];
				
				if(floor)
				{
					floor.floorDetails[fd.T_FloorDetailID] = fd;
				}
				
				if(fd.T_FloorDetailchildfloor)
				{
					for each(var s:String in fd.T_FloorDetailchildfloor.split(','))
					{
						floor = dict[Number(s)];
						
						if(floor)
						{
							floor.floorDetails[fd.T_FloorDetailID] = fd;
						}
					}
				}
			}
			
			sendNotification(ApplicationFacade.NOTIFY_APP_LOADINGTEXT,"系统初始化：楼层信息加载完成...");
			
			send("InitComponentMedia",onInitComponentMedia,ConfigVO.TMB_ID);			
		}
		
		private function onInitComponentMedia(event:ResultEvent):void
		{			
			for each(var i:Object in event.result.Tables.Table.Rows)
			{
				var media:MediaVO = new MediaVO(i);
				
				var floor:FloorVO = dict[media.T_FloorID];
				
				if(floor)
				{
					var fd:FloorDetailVO = floor.floorDetails[media.containerID];
					
					if(fd)
					{
						fd.medias[media.mediaID] = media;
					}
				}
			}
			
			
			sendNotification(ApplicationFacade.NOTIFY_APP_LOADINGTEXT,"系统初始化：楼层内部信息加载完成...");
			
			sendNotification(ApplicationFacade.NOTIFY_INIT_FLOOR,dict);
		}
		
		public function LoadFloorBitmap(floor:FloorVO,listener:Function):Object
		{			
			var url:String = ConfigVO.BASE_URL + "Download.aspx";
			url += "?w=" + _buildWidth;
			url += "&h=" + _buildHeight;
			url += "&img=" + floor.T_FloorPicPath;
			url += "&scale=" + floor.T_FloorScale;
			
			return load(url,listener);
		}					
		
		public function SaveFloors():void
		{			
			var s:String = "";
			
			for each(var floor:FloorVO in dict)
			{			
				if(floor.edit)
				{
					s += floor.T_FloorID + ";" + floor.T_FloorScale + ";" + floor.T_FloorX + ";" + floor.T_FloorY + ";" + floor.T_FloorXRotation + ";" + floor.T_FloorYRotation + ";" + floor.T_FloorZRotation + ";" + floor.T_FloorAlpha + "@";
					floor.edit = false;
				}
			}
			
			send("SaveFloor",onSaveFloor,ConfigVO.TMB_ID,s);
		}
		
		private function onSaveFloor(r:Number):void
		{			
			sendNotification(ApplicationFacade.NOTIFY_APP_ALERTINFO,"楼层信息保存成功。");
		}		
	}
}