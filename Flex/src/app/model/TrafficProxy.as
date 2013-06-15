package app.model
{
	import app.ApplicationFacade;
	import app.model.vo.ConfigVO;
	import app.model.vo.TrafficPicVO;
	import app.model.vo.TrafficVO;
	
	import flash.utils.Dictionary;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.events.ResultEvent;
	
	import org.puremvc.as3.interfaces.IProxy;
	
	public class TrafficProxy extends WebServiceProxy implements IProxy
	{
		public static const NAME:String = "TrafficProxy";
		
		public function TrafficProxy()
		{
			super(NAME, new Dictionary);
		}
		
		public function get dict():Dictionary
		{
			return data as Dictionary
		}
		
		public function save():AsyncToken
		{
			var s:String = "";
			
			for each(var tr:TrafficVO in dict)
			{
				if(tr.edit)
					s += "3 " + tr.T_TrafficID + " " + tr.T_TrafficX + " " + tr.T_TrafficY + ";"
			}
			
			return send("SaveSurrouding",onSaveSurrouding,s);
		}
		
		private function onSaveSurrouding(event:ResultEvent):void
		{			
			for each(var tr:TrafficVO in dict)
			{
				tr.edit = true;
			}
		}
		
		public function Init():void
		{
			send("InitTraffic",onInitTraffic,ConfigVO.TMB_ID);
		}
		
		private function onInitTraffic(event:ResultEvent):void
		{						
			for each(var i:Object in event.result.Tables.Table.Rows)
			{
				var tr:TrafficVO = new TrafficVO(i);					
				dict[tr.T_TrafficID] = tr;
			}
			
			send("InitTrafficPic",onInitTrafficPic,ConfigVO.TMB_ID);
		}
		
		private function onInitTrafficPic(event:ResultEvent):void
		{						
			for each(var i:Object in event.result.Tables.Table.Rows)
			{
				var media:TrafficPicVO = new TrafficPicVO(i);	
				
				var ch:TrafficVO = dict[media.containerID] as TrafficVO;
				
				if(ch)
					ch.pics[media.mediaID] = media;
			}
			
			sendNotification(ApplicationFacade.NOTIFY_APP_LOADINGTEXT,"系统初始化：重要交通信息加载完成...");
			
			sendNotification(ApplicationFacade.NOTIFY_INIT_TRAFFIC,dict);				
		}
	}
}