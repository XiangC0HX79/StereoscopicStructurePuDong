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
				
		public function Init():void
		{
			send("InitClosedLine",onInitClosedLine,ConfigVO.TMB_ID);
		}
		
		private function onInitClosedLine(event:ResultEvent):void
		{						
			for each(var i:Object in event.result.Tables.Table.Rows)
			{
				var cl:CloseHandleLineVO = new CloseHandleLineVO(i);					
				dict[cl.T_ClosedhandlesLineID] = cl;
			}
			
			sendNotification(ApplicationFacade.NOTIFY_APP_LOADINGTEXT,"系统初始化：分控线加载完成...");
			
			sendNotification(ApplicationFacade.NOTIFY_INIT_CLOSEDHANDLE_LINE,dict);	
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
			
			sendNotification(ApplicationFacade.NOTIFY_CLOSELINE_ADD,cl);
		}
		
		public function DelFireHydrant(pt:Point):void
		{
			var mindis:Number = 10;
			var mincl:CloseHandleLineVO;
			
			for each(var cl:CloseHandleLineVO in dict)
			{
				var dis:Number = msDistancePointToSegment(pt,cl.T_ClosedLineStart,cl.T_ClosedLineEnd);
				if(dis < mindis)
				{
					mincl = cl;
					mindis = dis;
				}
			}
			
			if(mincl)
			{
				var token:AsyncToken = send("DelClosedLine",onDelClosedLine,mincl.T_ClosedhandlesLineID);
				token.closedLine = mincl;
			}
		}
		
		private function onDelClosedLine(event:ResultEvent):void
		{
			var cl:CloseHandleLineVO = event.token.closedLine;
			
			delete dict[cl.T_ClosedhandlesLineID];
			
			sendNotification(ApplicationFacade.NOTIFY_CLOSELINE_DEL,dict);
		}
		
		private function msDistancePointToSegment(p:Point,a:Point,b:Point):Number
		{
			//计算点到线段(a,b)的距离  
			var l:Number = msDistancePointToPoint(a,b);   
			if(l == 0.0) /* a = b */   
				return msDistancePointToPoint(a,p); 
			
			var r:Number = ((a.y - p.y)*(a.y - b.y) - (a.x - p.x)*(b.x - a.x))/(l*l);   
			if(r > 1) /* perpendicular projection of P is on the forward extention of AB */    
				return Math.min(msDistancePointToPoint(p, b),msDistancePointToPoint(p, a));  
			if(r < 0) /* perpendicular projection of P is on the backward extention of AB */   
				return Math.min(msDistancePointToPoint(p, b),msDistancePointToPoint(p, a));  
			
			var s:Number = ((a.y - p.y)*(b.x - a.x) - (a.x - p.x)*(b.y - a.y))/(l*l);   
			
			return Math.abs(s*l);
		}
		
		private function msDistancePointToPoint(a:Point,b:Point):Number
		{
			var dx:Number = a.x - b.x;
			var dy:Number = a.y - b.y;
			return Math.sqrt(dx*dx + dy*dy);
		}
	}
}