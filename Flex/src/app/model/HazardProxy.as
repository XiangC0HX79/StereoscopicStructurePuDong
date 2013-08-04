package app.model
{
	import app.ApplicationFacade;
	import app.model.vo.ConfigVO;
	import app.model.vo.HazardVO;
	
	import flash.utils.Dictionary;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.events.ResultEvent;
	
	import org.puremvc.as3.interfaces.IProxy;
	
	public class HazardProxy extends WebServiceProxy implements IProxy
	{
		public static const NAME:String = "HazzardProxy";
		
		public function HazardProxy()
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
			
			for each(var ha:HazardVO in dict)
			{
				if(ha.edit)
					s += "4 " + ha.T_HazardID + " " + ha.T_HazardX + " " + ha.T_HazardY + ";"
			}
			
			return send("SaveSurrouding",onSaveSurrouding,s);
		}
		
		private function onSaveSurrouding(event:ResultEvent):void
		{			
			for each(var ha:HazardVO in dict)
			{
				ha.edit = false;
			}
		}
		
		public function Init():void
		{
			send("InitHazard",onInitHazard,ConfigVO.TMB_ID);
		}
		
		private function onInitHazard(event:ResultEvent):void
		{						
			for each(var i:Object in event.result.Tables.Table.Rows)
			{
				var hz:HazardVO = new HazardVO(i);					
				dict[hz.T_HazardID] = hz;
			}
			
			sendNotification(ApplicationFacade.NOTIFY_APP_LOADINGTEXT,"系统初始化：危险源信息加载完成...");
			
			sendNotification(ApplicationFacade.NOTIFY_INIT_HAZZARD,dict);	
		}
	}
}