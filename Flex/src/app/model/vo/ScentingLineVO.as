package app.model.vo
{
	import com.adobe.serialization.json.JSON;
	
	import flash.geom.Point;

	[Bindable]
	public class ScentingLineVO
	{
		private var _source:*;
		
		public function get T_ScentingLineID():Number
		{
			return _source.T_ScentingLineID;
		}
		public function set T_ScentingLineID(value:Number):void
		{
			_source.T_ScentingLineID = value;
		}
		
		public function get TMB_ID():Number
		{
			return _source.TMB_ID;
		}	
		public function set TMB_ID(value:Number):void
		{
			_source.TMB_ID = value;
		}
		
		public function get path():Array
		{
			var r:Array = new Array;
			
			var a:Array = String(_source.T_ScentingLinePath).split(",");
			for each(var s:String in a)
			{
				var xy:Array = s.split(" ");
				if(
					(xy.length == 2)
					&& Number(xy[0])
					&& Number(xy[1])
				   )
				{
					var pt:Point = new Point(Number(xy[0]),Number(xy[1]));
					r.push(pt);
				}
			}
			
			return r;
		}	
		public function set path(value:Array):void
		{
			var s:String = "";
			for each(var pt:Point in value)
			{
				s += pt.x + " " + pt.y + ",";
			}
			if(s)
				s = s.substr(0,s.length - 1);
			
			_source.T_ScentingLinePath = s;
		}
		
		public function toString():String
		{
			return JSON.encode(_source);
		}
		
		public function ScentingLineVO(value:*)
		{
			_source = value;
		}
	}
}