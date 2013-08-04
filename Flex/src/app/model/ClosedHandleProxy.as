package app.model
{
	import app.ApplicationFacade;
	import app.model.vo.ClosedHandlePicVO;
	import app.model.vo.ClosedHandleVO;
	import app.model.vo.ConfigVO;
	
	import flash.utils.Dictionary;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.events.ResultEvent;
	
	import org.puremvc.as3.interfaces.IProxy;
	
	public class ClosedHandleProxy extends WebServiceProxy implements IProxy
	{
		public static const NAME:String = "CloseHandleProxy";
		
		public function ClosedHandleProxy()
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
			
			for each(var ch:ClosedHandleVO in dict)
			{
				if(ch.edit)
					s += "2 " + ch.T_ClosedhandlesID + " " + ch.T_ClosedX + " " + ch.T_ClosedY + ";"
			}
			
			return send("SaveSurrouding",onSaveSurrouding,s);
		}
		
		private function onSaveSurrouding(event:ResultEvent):void
		{			
			for each(var ch:ClosedHandleVO in dict)
			{
				ch.edit = false;
			}
		}
		
		public function Init():void
		{
			send("InitClosedhandles",onInitClosedhandles,ConfigVO.TMB_ID);
		}
		
		private function onInitClosedhandles(event:ResultEvent):void
		{						
			for each(var i:Object in event.result.Tables.Table.Rows)
			{
				var ch:ClosedHandleVO = new ClosedHandleVO(i);					
				dict[ch.T_ClosedhandlesID] = ch;
			}
			
			send("InitClosedhandlesPic",onInitClosedhandlesPic,ConfigVO.TMB_ID);
		}
		
		private function onInitClosedhandlesPic(event:ResultEvent):void
		{						
			for each(var i:Object in event.result.Tables.Table.Rows)
			{
				var media:ClosedHandlePicVO = new ClosedHandlePicVO(i);	
				
				var ch:ClosedHandleVO = dict[media.containerID] as ClosedHandleVO;
				
				if(ch)
					ch.pics[media.mediaID] = media;
			}
			
			sendNotification(ApplicationFacade.NOTIFY_APP_LOADINGTEXT,"系统初始化：封控范围加载完成...");
			
			sendNotification(ApplicationFacade.NOTIFY_INIT_CLOSEDHANDLE,dict);				
		}
	}
}