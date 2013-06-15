package app.model
{
	import app.ApplicationFacade;
	import app.model.vo.ConfigVO;
	import app.model.vo.FireHydrantVO;
	
	import flash.utils.Dictionary;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.events.ResultEvent;
	
	import org.puremvc.as3.interfaces.IProxy;
	
	public class FireHydrantProxy extends WebServiceProxy implements IProxy
	{
		public static const NAME:String = "FireHydrantProxy";
		
		public function FireHydrantProxy()
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
			
			for each(var fh:FireHydrantVO in dict)
			{
				if(fh.edit)
					s += "6 " + fh.TMB_ID + " " + fh.T_FireHydrantX + " " + fh.T_FireHydrantY + ";"
			}
			
			return send("SaveSurrouding",onSaveSurrouding,s);
		}
		
		private function onSaveSurrouding(event:ResultEvent):void
		{			
			for each(var fh:FireHydrantVO in dict)
			{
				fh.edit = true;
			}
		}
		
		public function Init():void
		{
			send("InitFireHydrant",onInitFireHydrant,ConfigVO.TMB_ID);
		}
		
		private function onInitFireHydrant(event:ResultEvent):void
		{						
			for each(var i:Object in event.result.Tables.Table.Rows)
			{
				var fh:FireHydrantVO = new FireHydrantVO(i);					
				dict[fh.T_FireHydrantID] = fh;
			}
			
			sendNotification(ApplicationFacade.NOTIFY_APP_LOADINGTEXT,"系统初始化：消防栓信息加载完成...");
			
			sendNotification(ApplicationFacade.NOTIFY_INIT_FIREHYDRANT,dict);	
		}
		
		public function AddFireHydrant(x:Number,y:Number):void
		{
			var fh:FireHydrantVO = new FireHydrantVO({});
			fh.TMB_ID = ConfigVO.TMB_ID;
			fh.T_FireHydrantX = x;
			fh.T_FireHydrantY = y;				
			dict[fh.T_FireHydrantID] = fh;
			
			sendNotification(ApplicationFacade.NOTIFY_FIRE_ADD,fh);
		}
		
		public function DelFireHydrant(fireHydrant:FireHydrantVO):void
		{
			delete dict[fireHydrant.T_FireHydrantID];
			
			sendNotification(ApplicationFacade.NOTIFY_FIRE_DEL,fireHydrant);
		}
	}
}