package app.model.vo
{
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	public class ClosedhandleVO
	{
		private var source:Object;
		
		public function get T_ClosedhandlesID():Number
		{
			return source.T_ClosedhandlesID;
		}
		
		public function get T_ClosedhandlesName():String
		{
			return source.T_ClosedhandlesName;
		}
		
		public function get T_ClosedX():Number
		{
			return source.T_ClosedX;
		}
		public function set T_ClosedX(value:Number):void
		{
			source.T_ClosedX = value;
		}
		
		public function get T_ClosedY():Number
		{
			return source.T_ClosedY;
		}
		public function set T_ClosedY(value:Number):void
		{
			source.T_ClosedY = value;
		}
		
		public var pics:ArrayCollection;
		
		public function ClosedhandleVO(value:Object)
		{
			source = value;
		}
	}
}