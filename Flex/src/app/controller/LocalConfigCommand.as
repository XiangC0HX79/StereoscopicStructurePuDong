package app.controller
{	
	import app.ApplicationFacade;
	import app.model.BuildProxy;
	import app.model.LayerSettingStereoScopicProxy;
	import app.model.vo.BuildVO;
	import app.model.vo.CommandHeightVO;
	import app.model.vo.ComponentVO;
	import app.model.vo.FloorVO;
	import app.model.vo.HazardVO;
	import app.model.vo.KeyUnitVO;
	import app.model.vo.ScentingVO;
	import app.model.vo.TaticalVO;
	import app.model.vo.TrafficInfoVO;
	import app.view.TitleWindowFloorMediator;
	import app.view.components.TitleWindowFloor;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	import mx.managers.PopUpManager;
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import spark.components.Application;
	import spark.components.Image;
	import spark.components.TitleWindow;
	
	public class LocalConfigCommand extends SimpleCommand implements ICommand
	{
		private var paramName:String;
		
		private var buildProxy:BuildProxy;
		
		private var layerSettingStereoScopicProxy:LayerSettingStereoScopicProxy;
		
		override public function execute(note:INotification):void
		{						
			sendNotification(ApplicationFacade.NOTIFY_APP_LOADINGSHOW,"系统初始化：加载数据...");
						
			var application:Application = note.getBody() as Application;	
			paramName = application.parameters.build;	
			//buildProxy.build.edit = (application.parameters.edit == "1");
			
			var request:URLRequest = new URLRequest("config.xml");
			var load:URLLoader = new URLLoader(request);
			load.addEventListener(Event.COMPLETE,onLocaleConfigResult);
			load.addEventListener(IOErrorEvent.IO_ERROR,onIOError);
			
			buildProxy = facade.retrieveProxy(BuildProxy.NAME) as BuildProxy;
			
			layerSettingStereoScopicProxy = facade.retrieveProxy(LayerSettingStereoScopicProxy.NAME) as LayerSettingStereoScopicProxy;
		}
				
		private function onIOError(event:IOErrorEvent):void
		{
			sendNotification(ApplicationFacade.NOTIFY_APP_ALERTERROR,event.text);
		}
		
		private function onLocaleConfigResult(event:Event):void
		{				
			try
			{
				var xml:XML = new XML(event.currentTarget.data);
			}
			catch(e:Object)
			{
				trace(e);
			}
			
			if(xml == null)
			{
				sendNotification(ApplicationFacade.NOTIFY_APP_ALERTERROR,"配置文件损坏，请检查config.xml文件正确性！");
				
				sendNotification(ApplicationFacade.NOTIFY_APP_LOADINGSHOW,"程序初始化：本地配置加载失败！");	
			}
			else
			{				
				WebServiceCommand.WSDL = xml.WebServiceUrl;
				
				//加载图标				
				sendNotification(ApplicationFacade.NOTIFY_WEBSERVICE_SEND,
					["InitIcon",onInitIcon
						,[]
						,false]);
			}
		}
		
		private function onInitIcon(result:ArrayCollection):void
		{							
			for each(var item:Object in result)
			{
				switch(item.IconID)
				{
					/*case "1":
						sendNotification(ApplicationFacade.NOTIFY_COMMAND_LOADIMAGE
							,[
								item.IconPath,
								function(bitmap:Bitmap):void{CommandingHeightVO.Icon = bitmap;}
							]);						
						break;*/
				}
			}
						
			sendNotification(ApplicationFacade.NOTIFY_WEBSERVICE_SEND,
				["InitBuild",onInitBuild
					,[paramName]
					,false]);	
		}
		
		private function onInitBuild(result:ArrayCollection):void
		{								
			if(result.length == 0)
				return;

			buildProxy.setData(new BuildVO(result[0]));
			//buildProxy.build.buildID = result[0].TMB_ID;	
			
			if(result[0].TMB_StereoPicPath)
				sendNotification(ApplicationFacade.NOTIFY_COMMAND_LOADIMAGE,[result[0].TMB_StereoPicPath,loaderImageHandle]);
			else
				sendNotification(ApplicationFacade.NOTIFY_COMMAND_LOADIMAGE,[result[0].TMB_PicPath,loaderImageHandle]);
			
			function loaderImageHandle(bitmap:Bitmap):void   
			{   						
				buildProxy.build.TMB_StereoPic = bitmap;
				
				//加载制高点
				sendNotification(ApplicationFacade.NOTIFY_WEBSERVICE_SEND,
					["InitCommandingHeights",onInitCommandingHeights
						,[buildProxy.build.TMB_ID]
						,false]);
			}
		}
				
		private function onInitCommandingHeights(result:ArrayCollection):void
		{						
			for each(var item:Object in result)
			{
				buildProxy.build.CommandingHeights.addItem(new CommandHeightVO(item));
			}
					
			sendNotification(ApplicationFacade.NOTIFY_WEBSERVICE_SEND,
				["InitKeyUnits",onInitKeyUnits
					,[buildProxy.build.TMB_ID]
					,false]);
		}
		
		private function onInitKeyUnits(result:ArrayCollection):void
		{
			for each(var i:Object in result)
			{
				buildProxy.build.keyUnits.addItem(new KeyUnitVO(i));
			}
			
			sendNotification(ApplicationFacade.NOTIFY_WEBSERVICE_SEND,
				["InitScenting",onInitScenting
					,[buildProxy.build.TMB_ID]
					,false]);		
		}
		
		private function onInitScenting(result:ArrayCollection):void
		{			
			for each(var i:Object in result)
			{
				buildProxy.build.Scenting.addItem(new ScentingVO(i));
			}
						
			sendNotification(ApplicationFacade.NOTIFY_WEBSERVICE_SEND,
				["InitTraffic",onInitTraffic
					,[buildProxy.build.TMB_ID]
					,false]);			
		}
		
		private function onInitTraffic(result:ArrayCollection):void
		{			
			for each(var i:Object in result)
			{
				buildProxy.build.Traffic.addItem(new TrafficInfoVO(i));
			}
			
			sendNotification(ApplicationFacade.NOTIFY_WEBSERVICE_SEND,
				["InitHazard",onInitHazard
					,[buildProxy.build.TMB_ID]
					,false]);	
		}
		
		private function onInitHazard(result:ArrayCollection):void
		{			
			for each(var i:Object in result)
			{
				buildProxy.build.Hazzard.addItem(new HazardVO(i));
			}
			
			sendNotification(ApplicationFacade.NOTIFY_WEBSERVICE_SEND,
				["InitTatics",onInitTatics
					,[buildProxy.build.TMB_ID]
					,false]);	
		}
		
		private function onInitTatics(result:ArrayCollection):void
		{			
			for each(var i:Object in result)
			{
				var tatical:TaticalVO = new TaticalVO(i);
				switch(tatical.TP_Type)
				{
					case 1:
						buildProxy.build.Communicate.addItem(tatical);
						break;
					case 2:
						buildProxy.build.Cabledrop.addItem(tatical);
						break;
					case 3:
						buildProxy.build.Landing.addItem(tatical);
						break;
					case 4:
						buildProxy.build.Windows.addItem(tatical);
						break;
					case 5:
						buildProxy.build.Internalhigh.addItem(tatical);
						break;
				}
				
			}
			
			sendNotification(ApplicationFacade.NOTIFY_APP_INIT);
			
			sendNotification(ApplicationFacade.NOTIFY_APP_LOADINGHIDE,"程序初始化完成！");	
		}
		
		private function onInitControlRange(result:ArrayCollection):void
		{								
			if(result.length > 0)
			{				
				sendNotification(ApplicationFacade.NOTIFY_COMMAND_LOADIMAGE,[result[0].TMB_ControlRangeBitmap,loaderImageHandle]);
			}
			else
			{
				//加载建筑信息
				//sendNotification(ApplicationFacade.NOTIFY_WEBSERVICE_SEND,
				//	["InitBuild",onInitBuild
				//		,[buildProxy.build.buildName]
				//		,false]);	
			}
			
			function loaderImageHandle(bitmap:Bitmap):void   
			{   										
				//加载建筑信息
				//sendNotification(ApplicationFacade.NOTIFY_WEBSERVICE_SEND,
				//	["InitBuild",onInitBuild
				//		,[buildProxy.build.buildName]
				//		,false]);	
			}
		}
		
		/*private function onInitBuild(result:ArrayCollection):void
		{					
			if(result.length == 0)
				return;
							
			sendNotification(ApplicationFacade.NOTIFY_COMMAND_LOADIMAGE,[result[0].TMB_PicPath,loaderImageHandle]);
			
			function loaderImageHandle(bitmap:Bitmap):void   
			{   								
				buildProxy.build.buildBitmap = bitmap;
				
				//加载楼层
				sendNotification(ApplicationFacade.NOTIFY_WEBSERVICE_SEND,
					["InitFloor",onInitFloor
						,[buildProxy.build.buildID]
						,false]);
			}   
		}*/
		
		private function onInitFloor(resultFloors:ArrayCollection):void
		{							
			if(resultFloors.length == 0)
				return;		
						
			var indexFloor:Number = 0;
			var indexComponent:Number = 0;
			var floor:FloorVO;
			var component:ComponentVO;
			
			for each(var item:Object in resultFloors)
			{
				buildProxy.build.floors.addItem(new FloorVO(item));
			}
						
			floor = buildProxy.build.floors[indexFloor];	
			
			sendNotification(ApplicationFacade.NOTIFY_COMMAND_LOADIMAGE,[floor.floorBitmapName,loaderFloorImageHandle]);
			
			function loaderFloorImageHandle(bitmap:Bitmap):void   
			{   	
				floor.floorBitmap = bitmap;
				
				//加载组件
				sendNotification(ApplicationFacade.NOTIFY_WEBSERVICE_SEND,
					["InitComponent",onInitComponent
						,[buildProxy.build.TMB_ID,floor.floorID]
						,false]);
			}   
			
			function onInitComponent(resultComponents:ArrayCollection):void
			{						
				if(resultComponents.length == 0)
				{
					nextFloor();
				}
				else	
				{
					for each(var item:Object in resultComponents)
					{
						component = new ComponentVO(item);
						component.layer = layerSettingStereoScopicProxy.getLayer(item.T_FloorDetailType);
						
						floor.components.addItem(component);
					}
					
					component = floor.components[indexComponent] as ComponentVO;	
					
					sendNotification(ApplicationFacade.NOTIFY_COMMAND_LOADIMAGE,[component.componentBitmapName,loaderComponentImageHandle]);
				}
			}
			
			function loaderComponentImageHandle(bitmap:Bitmap):void   
			{   					
				component.componentBitmap = bitmap;
				
				indexComponent ++;
				
				if(indexComponent < floor.components.length)
				{
					component = floor.components[indexComponent];
						
					sendNotification(ApplicationFacade.NOTIFY_COMMAND_LOADIMAGE,[component.componentBitmapName,loaderComponentImageHandle]);
				}
				else
				{
					nextFloor();
				}
			}
			
			function nextFloor():void
			{
				indexComponent = 0;
				
				indexFloor ++;
				
				if(indexFloor <  buildProxy.build.floors.length)
				{
					floor = buildProxy.build.floors[indexFloor];	
					
					sendNotification(ApplicationFacade.NOTIFY_COMMAND_LOADIMAGE,[floor.floorBitmapName,loaderFloorImageHandle]);
				}
				else
				{
					//加载组件
					sendNotification(ApplicationFacade.NOTIFY_WEBSERVICE_SEND,
						["InitContingencyPlans",onInitContingencyPlans
							,[buildProxy.build.TMB_ID]
							,false]);
				}
			}
		}
		
		private function onInitContingencyPlans(result:ArrayCollection):void
		{							
			if(result.length > 0)
			{
				buildProxy.build.contingencyPlans = result[0].TMB_ContingencyPlans;
			}
						
			sendNotification(ApplicationFacade.NOTIFY_APP_INIT);
			
			sendNotification(ApplicationFacade.NOTIFY_APP_LOADINGHIDE,"程序初始化完成！");	
		}		
	}
}