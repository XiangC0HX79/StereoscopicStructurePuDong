package app.model
{	
	import app.ApplicationFacade;
	import app.model.vo.ConfigVO;
	import app.model.vo.ScentingVO;
	
	import flash.utils.Dictionary;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.events.ResultEvent;
	
	import org.puremvc.as3.interfaces.IProxy;
	
	public class ScentingProxy extends WebServiceProxy implements IProxy
	{
		public static const NAME:String = "ScentingProxy";
		
		public function ScentingProxy()
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
			
			for each(var sc:ScentingVO in dict)
			{
				if(sc.edit)
					s += "8 " + sc.T_ScentingID + " " + sc.T_ScentingX + " " + sc.T_ScentingY + ";"
			}
			
			return send("SaveSurrouding",onSaveSurrouding,s);
		}
		
		private function onSaveSurrouding(event:ResultEvent):void
		{			
			for each(var sc:ScentingVO in dict)
			{
				sc.edit = true;
			}
		}
		
		public function Init():void
		{
			send("InitScenting",onInitScenting,ConfigVO.TMB_ID);
		}
		
		private function onInitScenting(event:ResultEvent):void
		{						
			for each(var i:Object in event.result.Tables.Table.Rows)
			{
				var sc:ScentingVO = new ScentingVO(i);					
				dict[sc.T_ScentingID] = sc;
			}
			
			sendNotification(ApplicationFacade.NOTIFY_APP_LOADINGTEXT,"系统初始化：窨井信息加载完成...");
			
			sendNotification(ApplicationFacade.NOTIFY_INIT_SCENTING,dict);	
		}
	}
}