package app.view
{
	import app.ApplicationFacade;
	
	import mx.controls.Alert;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class AppAlertMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "AppAlertMediator";
				
		[Embed(source="assets/image/icon_error.png")]
		private const ICON_ERROR:Class;
		
		[Embed(source="assets/image/icon_alarm.png")]
		private const ICON_ALARM:Class;
		
		[Embed(source="assets/image/icon_info.png")]
		private const ICON_INFO:Class;
		
		public function AppAlertMediator()
		{
			super(NAME, null);			
			
			Alert.okLabel = "确定";
			Alert.yesLabel = "是";
			Alert.noLabel = "否";
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				ApplicationFacade.NOTIFY_APP_ALERTINFO,
				ApplicationFacade.NOTIFY_APP_ALERTALARM,
				ApplicationFacade.NOTIFY_APP_ALERTERROR
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{			
			var info:String = "";
			var closeHandle:Function = null;
			var flags:uint = 4;
			var arr:Array;
			
			switch(notification.getName())
			{
				case ApplicationFacade.NOTIFY_APP_ALERTINFO:
					if(notification.getBody() is String)
					{
						info = notification.getBody() as String;
					}
					else if(notification.getBody() is Array)
					{
						arr = notification.getBody() as Array;
						info = arr[0] as String;
						closeHandle = arr[1] as Function;
						if(arr.length > 2)flags = arr[2];
					}
					
					Alert.show(info,"上海司法鉴定信息管理系统",flags,null,closeHandle,ICON_INFO);
					break;
				
				case ApplicationFacade.NOTIFY_APP_ALERTALARM:
					if(notification.getBody() is String)
					{
						info = notification.getBody() as String;
					}
					else if(notification.getBody() is Array)
					{
						arr = notification.getBody() as Array;
						info = arr[0] as String;
						closeHandle = arr[1] as Function;
						if(arr.length > 2)flags = arr[2];
					}
					
					Alert.show(info,"上海司法鉴定信息管理系统",flags,null,closeHandle,ICON_ALARM);
					break;				
				
				case ApplicationFacade.NOTIFY_APP_ALERTERROR:
					if(notification.getBody() is String)
					{
						info = notification.getBody() as String;
					}
					else if(notification.getBody() is Array)
					{
						arr = notification.getBody() as Array;
						info = arr[0] as String;
						closeHandle = arr[1] as Function;
						if(arr.length > 2)flags = arr[2];
					}
					
					Alert.show(info,"上海司法鉴定信息管理系统",flags,null,closeHandle,ICON_ERROR);
					break;
			}
		}
	}
}