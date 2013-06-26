package app.model
{
	import app.ApplicationFacade;
	import app.model.vo.ConfigVO;
	import app.model.vo.ScentingLineVO;
	
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.events.ResultEvent;
	
	import org.puremvc.as3.interfaces.IProxy;
	
	public class ScentingLineProxy extends WebServiceProxy implements IProxy
	{
		public static const NAME:String = "ScentingLineProxy";
		
		public function ScentingLineProxy()
		{
			super(NAME, new Dictionary);
		}
		
		public function get dict():Dictionary
		{
			return data as Dictionary
		}
				
		public function Init():void
		{
			send("InitScentingLine",onInitScentingLine,ConfigVO.TMB_ID);
		}
		
		private function onInitScentingLine(event:ResultEvent):void
		{						
			for each(var i:Object in event.result.Tables.Table.Rows)
			{
				var sl:ScentingLineVO = new ScentingLineVO(i);					
				dict[sl.T_ScentingLineID] = sl;
			}
			
			sendNotification(ApplicationFacade.NOTIFY_APP_LOADINGTEXT,"系统初始化：窨井线加载完成...");
			
			sendNotification(ApplicationFacade.NOTIFY_INIT_SCENTING_LINE,dict);
		}
		
		public function AddScentingLine(path:Array):void
		{
			var sl:ScentingLineVO = new ScentingLineVO({});
			sl.TMB_ID = ConfigVO.TMB_ID;
			sl.path = path;	
			
			var s:String = sl.toString();
			
			var token:AsyncToken = send("AddScentingLine",onAddScentingLine,s);
			token.scentingLine = sl;
		}
		
		private function onAddScentingLine(event:ResultEvent):void
		{
			var sl:ScentingLineVO = event.token.scentingLine;
			
			sl.T_ScentingLineID = Number(event.result);
			
			dict[sl.T_ScentingLineID] = sl;
			
			sendNotification(ApplicationFacade.NOTIFY_SCENTING_LINE_ADD,sl);
		}
		
		public function DelScentingLine(pt:Point):void
		{
			var mindis:Number = 10;
			var minsl:ScentingLineVO;
			
			for each(var sl:ScentingLineVO in dict)
			{
				var dis:Number = msDistancePointToPath(pt,sl.path);
				if(dis < mindis)
				{
					minsl = sl;
					mindis = dis;
				}
			}
			
			if(minsl)
			{
				var token:AsyncToken = send("DelSentingLine",onDelScentingLine,minsl.T_ScentingLineID);
				token.scentingLine = minsl;
			}
		}
		
		private function onDelScentingLine(event:ResultEvent):void
		{
			var sl:ScentingLineVO = event.token.scentingLine;
			
			delete dict[sl.T_ScentingLineID];
			
			sendNotification(ApplicationFacade.NOTIFY_SCENTING_LINE_DEL,dict);
		}
		
		private function msDistancePointToPath(p:Point,path:Array):Number
		{
			var minl:Number = Number.MAX_VALUE;
			
			if(path.length < 2)
				return minl;
			
			for(var i:Number = 0;i<path.length - 1;i++)
			{
				var l:Number = msDistancePointToSegment(p,path[i],path[i + 1]);
				if(l < minl)
					minl = l;
			}
			
			return minl;
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