package app.model
{
	import app.ApplicationFacade;
	import app.model.vo.BuildVO;
	import app.model.vo.ClosedhandleVO;
	import app.model.vo.CommandHeightVO;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.FaultEvent;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class BuildProxy extends Proxy implements IProxy
	{
		public static const NAME:String = "BuildProxy";
		
		public function BuildProxy()
		{
			super(NAME, new BuildVO);
			
			build.addEventListener(FaultEvent.FAULT,onFault);
		}
		
		public function get build():BuildVO
		{
			return data as BuildVO;
		}
		
		public function SaveSurrouding():void
		{
			var data:String = "";
			for each(var ch:CommandHeightVO in build.CommandingHeights)
			{
				data += "1 " + ch.TCH_ID + " " + ch.TCH_X + " " + ch.TCH_Y + ";"
			}
			
			for each(var cl:ClosedhandleVO in build.CloseHandles)
			{
				data += "2 " + cl.T_ClosedhandlesID + " " + cl.T_ClosedX + " " + cl.T_ClosedY + ";"
			}
			
			build.send("SaveSurrouding",onSaveSurrouding,data);
		}
		
		private function onSaveSurrouding(r:Number):void
		{			
			sendNotification(ApplicationFacade.NOTIFY_APP_ALERTINFO,"周边环境信息保存成功。");
		}
		
		private function onFault(event:FaultEvent):void
		{
			sendNotification(ApplicationFacade.NOTIFY_APP_ALERTERROR,event.fault.faultString + "\n" + event.fault.faultDetail);
		}
	}
}