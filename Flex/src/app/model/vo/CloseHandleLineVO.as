package app.model.vo
{
	import com.adobe.serialization.json.JSON;
	
	import flash.geom.Point;

	[Bindable]
	public class CloseHandleLineVO
	{		
		private var _source:*;
		
		public function get T_ClosedhandlesLineID():Number
		{
			return _source.T_ClosedhandlesLineID;
		}
		public function set T_ClosedhandlesLineID(value:Number):void
		{
			_source.T_ClosedhandlesLineID = value;
		}
		
		public function get TMB_ID():Number
		{
			return _source.TMB_ID;
		}	
		public function set TMB_ID(value:Number):void
		{
			_source.TMB_ID = value;
		}
		
		public function get T_ClosedLineStart():Point
		{
			return new Point(Number(_source.T_ClosedLineStartX),Number(_source.T_ClosedLineStartY));
		}		
		public function set T_ClosedLineStart(value:Point):void
		{
			_source.T_ClosedLineStartX = value.x;
			_source.T_ClosedLineStartY = value.y;
		}
				
		public function get T_ClosedLineEnd():Point
		{
			return new Point(Number(_source.T_ClosedLineEndX),Number(_source.T_ClosedLineEndY));
		}		
		public function set T_ClosedLineEnd(value:Point):void
		{
			_source.T_ClosedLineEndX = value.x;
			_source.T_ClosedLineEndY = value.y;
		}
				
		public function toString():String
		{
			return JSON.encode(this);
		}
		
		public function CloseHandleLineVO(value:*)
		{
			_source = value;
		}
	}
}