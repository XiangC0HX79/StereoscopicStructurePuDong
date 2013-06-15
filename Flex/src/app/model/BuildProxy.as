package app.model
{
	import app.ApplicationFacade;
	import app.model.vo.BuildVO;
	import app.model.vo.ClosedHandlePicVO;
	import app.model.vo.ClosedHandleVO;
	import app.model.vo.CommandHeightPicVO;
	import app.model.vo.CommandHeightVO;
	import app.model.vo.ComponentVO;
	import app.model.vo.ConfigVO;
	import app.model.vo.FireHydrantVO;
	import app.model.vo.FloorPicVO;
	import app.model.vo.FloorVO;
	import app.model.vo.HazardVO;
	import app.model.vo.KeyUnitVO;
	import app.model.vo.ScentingVO;
	import app.model.vo.TaticalVO;
	import app.model.vo.TrafficVO;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class BuildProxy extends WebServiceProxy implements IProxy
	{
		public static const NAME:String = "BuildProxy";
		
		public function BuildProxy()
		{
			super(NAME, new BuildVO);
			
			build.addEventListener(FaultEvent.FAULT,onFault);
		}
		
		public function get build():BuildVO
		{
			return data as BuildVO;
		}
		
		public function Init(build:String):void
		{			
			send("InitBuild",onInitBaseInfo,build);
		}
		
		private function onInitBaseInfo(event:ResultEvent):void
		{			
			var arr:ArrayCollection = event.result.Tables.Table.Rows;
			
			if(arr.length == 0)
			{
				sendNotification(ApplicationFacade.NOTIFY_APP_ALERTERROR,"没有找到建筑物信息！");
				return;
			}
			
			setData(new BuildVO(arr[0]));
			
			ConfigVO.TMB_ID = build.TMB_ID;
			
			send("GetBitmapSize",onGetBuildBitmapSize,build.TMB_PicPath);
		}
				
		private function onGetBuildBitmapSize(result:String):void
		{
			var s:Array = result.split(' ');
			build.BitmapWidth = s[0];
			build.BitmapHeight = s[1];
			
			sendNotification(ApplicationFacade.NOTIFY_APP_LOADINGTEXT,"系统初始化：基础信息加载完成...");		
			
			sendNotification(ApplicationFacade.NOTIFY_INIT_BUILD,build);	
		}
					
		private function onInitTatics(result:ArrayCollection):void
		{			
			
			sendNotification(ApplicationFacade.NOTIFY_APP_LOADINGTEXT,"系统初始化：战术信息加载完成...");
			
			send("InitFloorPic",onInitFloorPic,build.TMB_ID);
		}
		
		private function onInitFloorPic(result:ArrayCollection):void
		{				
			build.floorPics = new ArrayCollection;
			
			for each(var i:Object in result)
			{
				var floorPic:FloorPicVO = new FloorPicVO(i);
				build.floorPics.addItem(floorPic);
				loadFloorPic(floorPic);
			}			
			
			onInitFloorPicComplete();
		}
		
		private function loadFloorPic(floorPic:FloorPicVO):void
		{
			load(floorPic.T_FloorPicimgPath,onloadFloorPic);
			
			function onloadFloorPic(bitmap:Bitmap):void
			{
				floorPic.bitmap = bitmap;
				
				sendNotification(ApplicationFacade.NOTIFY_APP_LOADINGTEXT,"系统初始化：组件图片" + floorPic.T_FloorPicID + "加载完成...");
				
				onInitFloorPicComplete();
			}
		}
		
		private function onInitFloorPicComplete():void
		{
			for each(var floorPic:FloorPicVO in build.floorPics)
			{
				if(!floorPic.bitmap)
					return;
			}
			
			send("InitFloor",onInitFloor,build.TMB_ID);
		}
		
		private function onInitFloor(result:ArrayCollection):void
		{						
			build.floors = new ArrayCollection;
			
			for each(var i:Object in result)
			{
				var floor:FloorVO = new FloorVO(i);
				build.floors.addItem(floor);
				initFloorInfo(floor);
			}			
			
			sendNotification(ApplicationFacade.NOTIFY_APP_LOADINGTEXT,"系统初始化：楼层信息加载完成...");
			
			onInitFloorComplete();
		}
		
		private function initFloorInfo(floor:FloorVO):void
		{			
			send("InitComponent",onInitComponent,build.TMB_ID,floor.T_FloorID);
			
			send("GetBitmapSize",onGetFloorBitmapSize,floor.T_FloorPicPath);
			
			function onInitComponent(result:ArrayCollection):void
			{
				floor.components = new ArrayCollection;
				
				for each(var i:Object in result)
				{
					var component:ComponentVO = new ComponentVO(i);	
					
					for each(var floorPic:FloorPicVO in build.floorPics)
					{
						if(component.T_FloorPicID == floorPic.T_FloorPicID)
							component.floorPic = floorPic;
					}							
					
					floor.components.addItem(component);
				}
				
				sendNotification(ApplicationFacade.NOTIFY_APP_LOADINGTEXT,"系统初始化：组件信息" + floor.T_FloorID + "加载完成...");
				
				onInitFloorComplete();
			}
			
			function onGetFloorBitmapSize(result:String):void
			{				
				var s:Array = result.split(' ');
				floor.BitmapWidth = s[0];
				floor.BitmapHeight = s[1];
				
				var url:String =  ConfigVO.BASE_URL + "Download.aspx";
				url += "?w=" + build.BitmapWidth;
				url += "&h=" + build.BitmapHeight;
				url += "&img=" + floor.T_FloorPicPath;
				url += "&scale=" + floor.T_FloorScale;
				
				load(url,onLoadFloorPic);
			}
			
			function onLoadFloorPic(bitmap:Bitmap):void
			{
				floor.floorBitmap = bitmap;
				
				if(!floor.T_FloorScale)
					floor.T_FloorScale = Math.min(bitmap.width / floor.BitmapWidth,bitmap.height / floor.BitmapHeight);
				
				sendNotification(ApplicationFacade.NOTIFY_APP_LOADINGTEXT,"系统初始化：楼层图片" + floor.T_FloorID + "加载完成...");
				
				onInitFloorComplete();
			}
		}
				
		private function onInitFloorComplete():void
		{
			for each(var i:FloorVO in build.floors)
			{
				if((!i.floorBitmap)
					|| (!i.components))
					return;
			}
			
			sendNotification(ApplicationFacade.NOTIFY_INIT_BUILD,build);
		}
		
		public function LoadFloorBitmap(floor:FloorVO,listener:Function):void
		{			
			var url:String =  ConfigVO.BASE_URL + "Download.aspx";
			url += "?w=" + build.BitmapWidth;
			url += "&h=" + build.BitmapHeight;
			url += "&img=" + floor.T_FloorPicPath;
			url += "&scale=" + floor.T_FloorScale;
			
			load(url,onInitFloorPic);
			
			function onInitFloorPic(bitmap:Bitmap):void
			{
				var s:Number = Math.round(bitmap.width / floor.BitmapWidth * 100) / 100;
				if(s == floor.T_FloorScale)
				{
					floor.floorBitmap = bitmap;									
					listener();
				}
			}
		}
		
		public function LoadComponentMedia(component:ComponentVO,listener:Function):void
		{						
			send("InitComponentMedia",listener,component.T_FloorDetailID);
		}
				
		/*public function SaveSurrouding():void
		{
			var data:String = "";			
			for each(var cl:ClosedHandleVO in build.CloseHandles)
			{
				data += "2 " + cl.T_ClosedhandlesID + " " + cl.T_ClosedX + " " + cl.T_ClosedY + ";"
			}
			
			for each(var tr:TrafficVO in build.Traffic)
			{
				data += "3 " + tr.T_TrafficID + " " + tr.T_TrafficX + " " + tr.T_TrafficY + ";"
			}
			
			for each(var ha:HazardVO in build.Hazzard)
			{
				data += "4 " + ha.T_HazardID + " " + ha.T_HazardX + " " + ha.T_HazardY + ";"
			}
			
			for each(var fh:FireHydrantVO in build.FireHydrant)
			{
				data += "6 " + build.TMB_ID + " " + fh.T_FireHydrantX + " " + fh.T_FireHydrantY + ";"
			}
			
			for each(var ku:KeyUnitVO in build.KeyUnits)
			{
				data += "7 " + ku.T_KeyUnitsID + " " + ku.T_KeyUnitsX + " " + ku.T_KeyUnitsY + ";"
			}
			
			for each(var sc:ScentingVO in build.Scenting)
			{
				data += "8 " + sc.T_ScentingID + " " + sc.T_ScentingX + " " + sc.T_ScentingY + ";"
			}
			
			send("SaveSurrouding",onSaveSurrouding,data);
		}
		
		private function onSaveSurrouding(r:Number):void
		{			
			sendNotification(ApplicationFacade.NOTIFY_APP_ALERTINFO,"周边环境信息保存成功。");
		}*/
		
		public function SaveFloors():void
		{			
			var data:String = "";
			
			for each(var floor:FloorVO in build.floors)
			{			
				if(floor.edit)
				{
					data += floor.T_FloorID + ";" + floor.T_FloorScale + ";" + floor.T_FloorX + ";" + floor.T_FloorY + ";" + floor.T_FloorXRotation + ";" + floor.T_FloorYRotation + ";" + floor.T_FloorZRotation + ";" + floor.T_FloorAlpha + "@";
					floor.edit = false;
				}
			}
			
			send("SaveFloor",onSaveFloor,build.TMB_ID,data);
		}
		
		private function onSaveFloor(r:Number):void
		{			
			sendNotification(ApplicationFacade.NOTIFY_APP_ALERTINFO,"楼层信息保存成功。");
		}		
		
		private function onFault(event:FaultEvent):void
		{
			sendNotification(ApplicationFacade.NOTIFY_APP_ALERTERROR,event.fault.faultString + "\n" + event.fault.faultDetail);
		}
	}
}