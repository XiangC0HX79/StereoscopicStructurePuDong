package app.model
{
	import app.ApplicationFacade;
	import app.model.vo.ConfigVO;
	import app.model.vo.KeyUnitVO;
	
	import flash.utils.Dictionary;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.events.ResultEvent;
	
	import org.puremvc.as3.interfaces.IProxy;
	
	public class KeyUnitProxy extends WebServiceProxy implements IProxy
	{
		public static const NAME:String = "KeyUnitProxy";
		
		public function KeyUnitProxy()
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
			
			for each(var ku:KeyUnitVO in dict)
			{
				if(ku.edit)
					s += "7 " + ku.T_KeyUnitsID + " " + ku.T_KeyUnitsX + " " + ku.T_KeyUnitsY + ";"
			}
			
			return send("SaveSurrouding",onSaveSurrouding,s);
		}
		
		private function onSaveSurrouding(event:ResultEvent):void
		{			
			for each(var ku:KeyUnitVO in dict)
			{
				ku.edit = true;
			}
		}
		
		public function Init():void
		{
			send("InitKeyUnits",onInitKeyUnits,ConfigVO.TMB_ID);
		}
		
		private function onInitKeyUnits(event:ResultEvent):void
		{						
			for each(var i:Object in event.result.Tables.Table.Rows)
			{
				var ku:KeyUnitVO = new KeyUnitVO(i);					
				dict[ku.T_KeyUnitsID] = ku;
			}
						
			sendNotification(ApplicationFacade.NOTIFY_APP_LOADINGTEXT,"系统初始化：重点单位信息加载完成...");
			
			sendNotification(ApplicationFacade.NOTIFY_INIT_KEYUNIT,dict);	
		}
	}
}