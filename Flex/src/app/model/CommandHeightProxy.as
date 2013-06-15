package app.model
{
	import app.ApplicationFacade;
	import app.model.vo.CommandHeightPicVO;
	import app.model.vo.CommandHeightVO;
	import app.model.vo.ConfigVO;
	
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.ResultEvent;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class CommandHeightProxy extends WebServiceProxy implements IProxy
	{
		public static const NAME:String = "CommandHeightProxy";
		
		public function CommandHeightProxy()
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
			
			for each(var ch:CommandHeightVO in dict)
			{
				if(ch.edit)
					s += "1 " + ch.TCH_ID + " " + ch.TCH_X + " " + ch.TCH_Y + ";"
			}
			
			return send("SaveSurrouding",onSaveSurrouding,s);
		}
		
		private function onSaveSurrouding(event:ResultEvent):void
		{			
			for each(var ch:CommandHeightVO in dict)
			{
				ch.edit = true;
			}
		}
		
		public function Init():void
		{
			send("InitCommandingHeights",onInitCommadHeight,ConfigVO.TMB_ID);
		}
		
		private function onInitCommadHeight(event:ResultEvent):void
		{						
			for each(var i:Object in event.result.Tables.Table.Rows)
			{
				var ch:CommandHeightVO = new CommandHeightVO(i);					
				dict[ch.TCH_ID] = ch;
			}
			
			send("InitCommandingHeightsPic",onInitCommandingHeightsPic,ConfigVO.TMB_ID);
		}
		
		private function onInitCommandingHeightsPic(event:ResultEvent):void
		{						
			for each(var i:Object in event.result.Tables.Table.Rows)
			{
				var media:CommandHeightPicVO = new CommandHeightPicVO(i);	
				
				var ch:CommandHeightVO = dict[media.containerID] as CommandHeightVO;
				
				if(ch)
					ch.pics[media.mediaID] = media;
			}
			
			sendNotification(ApplicationFacade.NOTIFY_APP_LOADINGTEXT,"系统初始化：制高点加载完成...");
			
			sendNotification(ApplicationFacade.NOTIFY_INIT_COMMANDHEIGHT,dict);				
		}
	}
}