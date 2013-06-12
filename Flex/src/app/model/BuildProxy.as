package app.model
{
	import app.ApplicationFacade;
	import app.model.vo.BuildVO;
	import app.model.vo.ClosedHandlePicVO;
	import app.model.vo.ClosedhandleVO;
	import app.model.vo.CommandHeightPicVO;
	import app.model.vo.CommandHeightVO;
	import app.model.vo.ComponentVO;
	import app.model.vo.FireHydrantVO;
	import app.model.vo.FloorVO;
	import app.model.vo.HazardVO;
	import app.model.vo.KeyUnitVO;
	import app.model.vo.ScentingVO;
	import app.model.vo.TaticalVO;
	import app.model.vo.TrafficInfoVO;
	
	import flash.display.Bitmap;
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.FaultEvent;
	
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
		
		private function onInitBaseInfo(result:ArrayCollection):void
		{			
			if(result.length == 0)
			{
				sendNotification(ApplicationFacade.NOTIFY_APP_ALERTERROR,"没有找到建筑物信息！");
				return;
			}
			
			setData(new BuildVO(result[0]));
			
			sendNotification(ApplicationFacade.NOTIFY_APP_LOADINGTEXT,"系统初始化：基础信息加载完成...");
			
			send("InitCommandingHeights",onInitCommadHeight,build.TMB_ID);
		}
				
		private function onInitCommadHeight(result:ArrayCollection):void
		{			
			build.CommandingHeights = new ArrayCollection;
			for each(var i:Object in result)
			{
				var command:CommandHeightVO = new CommandHeightVO(i);					
				build.CommandingHeights.addItem(command);
				initCommandPics(command);
			}
			
			onInitCommandPics();
		}
		
		private function initCommandPics(command:CommandHeightVO):void
		{
			send("InitCommandingHeightsPic",onInitPics,command.TCH_ID);		
			
			function onInitPics(result:ArrayCollection):void
			{				
				command.pics = new ArrayCollection;
				
				for each(var i:Object in result)
				{
					command.pics.addItem(new CommandHeightPicVO(i));
				}
				
				onInitCommandPics();
			}
		}
		
		private function onInitCommandPics():void
		{
			for each(var i:CommandHeightVO in build.CommandingHeights)
			{
				if(!i.pics)
					return;
			}
				
			sendNotification(ApplicationFacade.NOTIFY_APP_LOADINGTEXT,"系统初始化：制高点加载完成...");
			
			send("InitClosedhandles",onInitClosedhandles,build.TMB_ID);
		}
		
		private function onInitClosedhandles(result:ArrayCollection):void
		{			
			build.CloseHandles = new ArrayCollection;
			for each(var i:Object in result)
			{
				var closeHandle:ClosedhandleVO = new ClosedhandleVO(i);						
				build.CloseHandles.addItem(closeHandle);
				initCloseHandlePics(closeHandle);
			}
			
			onInitCloseHandlePics();
		}
		
		private function initCloseHandlePics(closeHandle:ClosedhandleVO):void
		{
			send("InitClosedhandlesPic",onInitPics,closeHandle.T_ClosedhandlesID);
			
			function onInitPics(result:ArrayCollection):void
			{				
				closeHandle.pics = new ArrayCollection;
				
				for each(var i:Object in result)
				{
					closeHandle.pics.addItem(new ClosedHandlePicVO(i));
				}
				
				onInitCloseHandlePics();		
			}
		}
		
		private function onInitCloseHandlePics():void
		{			
			for each(var i:ClosedhandleVO in build.CloseHandles)
			{
				if(!i.pics)
					return;
			}
				
			sendNotification(ApplicationFacade.NOTIFY_APP_LOADINGTEXT,"系统初始化：封控范围加载完成...");
			
			send("InitTraffic",onInitTraffic,build.TMB_ID);
		}
		
		private function onInitTraffic(result:ArrayCollection):void
		{			
			build.Traffic = new ArrayCollection;
			
			for each(var i:Object in result)
			{					
				build.Traffic.addItem(new TrafficInfoVO(i));
			}
			
			sendNotification(ApplicationFacade.NOTIFY_APP_LOADINGTEXT,"系统初始化：重要交通信息加载完成...");
			
			send("InitHazard",onInitHazard,build.TMB_ID);
		}
		
		private function onInitHazard(result:ArrayCollection):void
		{			
			build.Hazzard = new ArrayCollection;
			
			for each(var i:Object in result)
			{					
				build.Hazzard.addItem(new HazardVO(i));
			}
			
			sendNotification(ApplicationFacade.NOTIFY_APP_LOADINGTEXT,"系统初始化：危险源信息加载完成...");
			
			send("InitFireHydrant",onInitFireHydrant,build.TMB_ID);
		}
		
		private function onInitFireHydrant(result:ArrayCollection):void
		{			
			build.FireHydrant = new ArrayCollection;
			
			for each(var i:Object in result)
			{					
				build.FireHydrant.addItem(new FireHydrantVO(i));
			}
			
			sendNotification(ApplicationFacade.NOTIFY_APP_LOADINGTEXT,"系统初始化：消防栓信息加载完成...");
			
			send("InitKeyUnits",onInitKeyUnits,build.TMB_ID);
		}
		
		private function onInitKeyUnits(result:ArrayCollection):void
		{			
			build.KeyUnits = new ArrayCollection;
			
			for each(var i:Object in result)
			{					
				build.KeyUnits.addItem(new KeyUnitVO(i));
			}
			
			sendNotification(ApplicationFacade.NOTIFY_APP_LOADINGTEXT,"系统初始化：重点单位信息加载完成...");
			
			send("InitScenting",onInitScenting,build.TMB_ID);
		}
		
		private function onInitScenting(result:ArrayCollection):void
		{			
			build.Scenting = new ArrayCollection;
			
			for each(var i:Object in result)
			{					
				build.Scenting.addItem(new ScentingVO(i));
			}
			
			sendNotification(ApplicationFacade.NOTIFY_APP_LOADINGTEXT,"系统初始化：窨井信息加载完成...");
			
			send("InitTatics",onInitTatics,build.TMB_ID);
		}
	
		private function onInitTatics(result:ArrayCollection):void
		{			
			for each(var i:Object in result)
			{
				var tatical:TaticalVO = new TaticalVO(i);
				switch(tatical.TP_Type)
				{
					case 1:
						build.Communicate.addItem(tatical);
						break;
					case 2:
						build.Cabledrop.addItem(tatical);
						break;
					case 3:
						build.Landing.addItem(tatical);
						break;
					case 4:
						build.Windows.addItem(tatical);
						break;
					case 5:
						build.Internalhigh.addItem(tatical);
						break;
				}
				
			}
			
			sendNotification(ApplicationFacade.NOTIFY_APP_LOADINGTEXT,"系统初始化：战术信息加载完成...");
			
			send("InitFloor",onInitFloor,build.TMB_ID);
		}
		
		private function onInitFloor(result:ArrayCollection):void
		{													
			for each(var i:Object in result)
			{
				var floor:FloorVO = new FloorVO(i);
				build.floors.addItem(floor);
				initFloorInfo(floor);
			}			
			
			sendNotification(ApplicationFacade.NOTIFY_APP_LOADINGTEXT,"系统初始化：楼层信息加载完成...");
			
			onInitFloorPics();
		}
		
		private function initFloorInfo(floor:FloorVO):void
		{
			var layerSettingStereoScopicProxy:LayerSettingStereoScopicProxy = facade.retrieveProxy(LayerSettingStereoScopicProxy.NAME) as LayerSettingStereoScopicProxy;
			
			load(floor.T_FloorPicPath,onInitFloorPic);
			
			send("InitComponent",onInitComponent,build.TMB_ID,floor.floorID);
			
			function onInitFloorPic(bitmap:Bitmap):void
			{
				floor.floorBitmap = bitmap;
				
				sendNotification(ApplicationFacade.NOTIFY_APP_LOADINGTEXT,"系统初始化：楼层图片" + floor.floorID + "加载完成...");
				
				onInitFloorPics();
			}
			
			function onInitComponent(result:ArrayCollection):void
			{
				floor.components = new ArrayCollection;
				
				for each(var i:Object in result)
				{
					var component:ComponentVO = new ComponentVO(i);					
					component.layer = layerSettingStereoScopicProxy.getLayer(i.T_FloorDetailType);					
					floor.components.addItem(component);
					
					initComponentPic(component);
				}
				
				sendNotification(ApplicationFacade.NOTIFY_APP_LOADINGTEXT,"系统初始化：组件" + floor.floorID + "加载完成...");
				
				onInitFloorPics();
			}
		}
		
		private function initComponentPic(component:ComponentVO):void
		{			
			load(component.T_FloorPicimgPath,onInitComponentPic);
			
			function onInitComponentPic(bitmap:Bitmap):void
			{
				component.componentBitmap = bitmap;
				
				sendNotification(ApplicationFacade.NOTIFY_APP_LOADINGTEXT,"系统初始化：组件图片" + component.componentID + "加载完成...");
				
				onInitFloorPics();
			}
		}
		
		private function onInitFloorPics():void
		{
			for each(var i:FloorVO in build.floors)
			{
				if((!i.floorBitmap)
					|| (!i.components))
					return;
				
				for each(var c:ComponentVO in i.components)
				{
					if(!c.componentBitmap)
						return;
				}
			}
			
			sendNotification(ApplicationFacade.NOTIFY_INIT_BUILD,build);
		}
		
		public function AddFireHydrant(x:Number,y:Number):void
		{
			var fh:FireHydrantVO = new FireHydrantVO({});
			fh.T_FireHydrantX = x;
			fh.T_FireHydrantY = y;
			build.FireHydrant.addItem(fh);
			
			sendNotification(ApplicationFacade.NOTIFY_FIRE_ADD,fh);
		}
		
		public function DelFireHydrant(fireHydrant:FireHydrantVO):void
		{
			for each(var fh:FireHydrantVO in build.FireHydrant)
			{
				if(fh == fireHydrant)
				{
					build.FireHydrant.removeItemAt(build.FireHydrant.getItemIndex(fireHydrant));
					break;
				}
			}
			
			sendNotification(ApplicationFacade.NOTIFY_FIRE_DEL,fireHydrant);
		}
		
		public function SaveSurrouding():void
		{
			var data:String = "";
			for each(var ch:CommandHeightVO in build.CommandingHeights)
			{
				data += "1 " + ch.TCH_ID + " " + ch.TCH_X + " " + ch.TCH_Y + ";"
			}
			
			for each(var cl:ClosedhandleVO in build.CloseHandles)
			{
				data += "2 " + cl.T_ClosedhandlesID + " " + cl.T_ClosedX + " " + cl.T_ClosedY + ";"
			}
			
			for each(var tr:TrafficInfoVO in build.Traffic)
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
		}
		
		public function SaveFloors():void
		{			
			var data:String = "";
			
			for each(var floor:FloorVO in build.floors)
			{			
				if(floor.edit)
				{
					data += floor.floorID + ";" + floor.scale + ";" + floor.xOffset + ";" + floor.yOffset + ";" + floor.xRotation + ";" + floor.yRotation + ";" + floor.zRotation + ";" + floor.alpha + "@";
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