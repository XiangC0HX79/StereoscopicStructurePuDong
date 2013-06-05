package app.controller
{	
	import app.ApplicationFacade;
	import app.model.BuildProxy;
	import app.model.LayerSettingStereoScopicProxy;
	import app.model.vo.ComponentVO;
	import app.model.vo.FloorVO;
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
	
	import spark.components.Image;
	import spark.components.TitleWindow;
	
	public class LocalConfigCommand extends SimpleCommand implements ICommand
	{
		private static const INITCOUNT:Number = 1;
		
		private static var init:Number = 0;
		
		private var buildProxy:BuildProxy;
		
		private var layerSettingStereoScopicProxy:LayerSettingStereoScopicProxy;
		
		override public function execute(note:INotification):void
		{						
			sendNotification(ApplicationFacade.NOTIFY_APP_LOADINGSHOW,"系统初始化：加载数据...");
				
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
		
		private function appInit():void
		{
			if(++init == INITCOUNT)
			{														
				sendNotification(ApplicationFacade.NOTIFY_APP_INIT);
				
				sendNotification(ApplicationFacade.NOTIFY_APP_LOADINGHIDE,"程序初始化完成！");	
			}
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
				
				//加载建筑背景图
				sendNotification(ApplicationFacade.NOTIFY_WEBSERVICE_SEND,
					["InitBuild",onInitBuild
						,[buildProxy.build.buildName]
						,false]);
			}
		}
		
		private function onInitBuild(result:ArrayCollection):void
		{					
			if(result.length == 0)
				return;
			
			buildProxy.build.buildID = result[0].TMB_ID;		
			
			buildProxy.build.buildBitmapName = result[0].TMB_PicPath;
			
			buildProxy.build.contingencyPlans = result[0].TMB_ContingencyPlans;
			
			//调试，固定为jpg格式
			//buildProxy.build.buildBitmapName = buildProxy.build.buildBitmapName.substr(0,buildProxy.build.buildBitmapName.lastIndexOf(".")) + ".jpg";
			
			//loadImage(buildProxy.build.buildBitmapName,loaderImageHandle);
			sendNotification(ApplicationFacade.NOTIFY_COMMAND_LOADIMAGE,[buildProxy.build.buildBitmapName,loaderImageHandle]);
			
			function loaderImageHandle(bitmap:Bitmap):void   
			{   								
				buildProxy.build.buildBitmap = bitmap;
								
				//加载楼层
				sendNotification(ApplicationFacade.NOTIFY_WEBSERVICE_SEND,
					["InitFloor",onInitFloor
						,[buildProxy.build.buildID]
						,false]);
			}   
		}
		
		private function onInitFloor(resultFloors:ArrayCollection):void
		{							
			if(resultFloors.length == 0)
			{
				return;
			}
						
			var indexFloor:Number = 0;
			var indexComponent:Number = 0;
			var floor:FloorVO;
			var component:ComponentVO;
			
			for each(var item:Object in resultFloors)
			{
				buildProxy.build.floors.addItem(new FloorVO(item));
			}
						
			floor = buildProxy.build.floors[indexFloor];	
			
			//loadImage(floor.floorBitmapName,loaderFloorImageHandle);
			sendNotification(ApplicationFacade.NOTIFY_COMMAND_LOADIMAGE,[floor.floorBitmapName,loaderFloorImageHandle]);
			
			function loaderFloorImageHandle(bitmap:Bitmap):void   
			{   	
				floor.floorBitmap = bitmap;
				
				//加载组件
				sendNotification(ApplicationFacade.NOTIFY_WEBSERVICE_SEND,
					["InitComponent",onInitComponent
						,[buildProxy.build.buildID,floor.floorID]
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
					
					//loadImage(component.componentBitmapName,loaderComponentImageHandle);
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
					
					//loadImage(component.componentBitmapName,loaderComponentImageHandle);	
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
					
					//loadImage(floor.floorBitmapName,loaderFloorImageHandle);	
					sendNotification(ApplicationFacade.NOTIFY_COMMAND_LOADIMAGE,[floor.floorBitmapName,loaderFloorImageHandle]);
				}
				else
				{
					appInit();
				}
			}
		}
	}
}