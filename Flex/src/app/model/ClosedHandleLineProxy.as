package app.model
{
	import app.ApplicationFacade;
	import app.model.vo.CloseHandleLineVO;
	import app.model.vo.ClosedHandlePicVO;
	import app.model.vo.ClosedHandleVO;
	import app.model.vo.ConfigVO;
	
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.events.ResultEvent;
	
	import org.puremvc.as3.interfaces.IProxy;
	
	public class ClosedHandleLineProxy extends WebServiceProxy implements IProxy
	{
		public static const NAME:String = "ClosedHandleLineProxy";
		
		public function ClosedHandleLineProxy()
		{
			super(NAME, new Dictionary);
		}
		
		public function get dict():Dictionary
		{
			return data as Dictionary
		}
				
		public function AddFireHydrant(pts:Point,pte:Point):void
		{
			var cl:CloseHandleLineVO = new CloseHandleLineVO({});
			cl.TMB_ID = ConfigVO.TMB_ID;
			cl.T_ClosedLineStart = pts;
			cl.T_ClosedLineEnd = pte;		
			
			var s:String = cl.toString();
			
			var token:AsyncToken = send("AddClosedLine",onAddClosedLine,s);
			token.closedLine = cl;
		}
		
		private function onAddClosedLine(event:ResultEvent):void
		{
			var cl:CloseHandleLineVO = event.token.closedLine;
			
			cl.T_ClosedhandlesLineID = Number(event.result);
			
			dict[cl.T_ClosedhandlesLineID] = cl;
			
			//sendNotification(ApplicationFacade.NOTIFY_FIRE_ADD,cl);
		}
		
		public function DelFireHydrant(closedLine:CloseHandleLineVO):void
		{
			var token:AsyncToken = send("DelClosedLine",onDelClosedLine,closedLine.T_ClosedhandlesLineID);
			token.closedLine = closedLine;
		}
		
		private function onDelClosedLine(event:ResultEvent):void
		{
			var cl:CloseHandleLineVO = event.token.closedLine;
			
			delete dict[cl.T_ClosedhandlesLineID];
			
			//sendNotification(ApplicationFacade.NOTIFY_FIRE_DEL,cl);
		}
	}
}