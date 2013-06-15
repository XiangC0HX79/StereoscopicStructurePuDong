package app.model
{
	import app.ApplicationFacade;
	import app.model.vo.ConfigVO;
	import app.model.vo.TaticalVO;
	
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.ResultEvent;
	
	import org.puremvc.as3.interfaces.IProxy;
	
	public class TaticsProxy extends WebServiceProxy implements IProxy
	{
		public static const NAME:String = "TaticsProxy";
		
		public function TaticsProxy()
		{
			super(NAME, new Dictionary);
		}
		
		public function get dict():Dictionary
		{
			return data as Dictionary
		}
		
		public function Init():void
		{
			send("InitTatics",onInitTatics,ConfigVO.TMB_ID);			
		}
		
		private function onInitTatics(event:ResultEvent):void
		{
			for each(var i:Object in event.result.Tables.Table.Rows)
			{
				var tatics:TaticalVO = new TaticalVO(i);				
				dict[tatics.TP_ID] = tatics;
			}
			
			sendNotification(ApplicationFacade.NOTIFY_APP_LOADINGTEXT,"系统初始化：战术信息加载完成...");
			
			sendNotification(ApplicationFacade.NOTIFY_INIT_TATICS,dict);
		}
	}
}