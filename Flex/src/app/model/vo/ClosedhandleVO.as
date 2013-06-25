package app.model.vo
{
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	public class ClosedHandleVO
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
			edit = true;
			source.T_ClosedX = value;
		}
		
		public function get T_ClosedY():Number
		{
			return source.T_ClosedY;
		}
		public function set T_ClosedY(value:Number):void
		{
			edit = true;
			source.T_ClosedY = value;
		}
		
		public var pics:Dictionary;
		
		public var edit:Boolean = false;
		
		public function ClosedHandleVO(value:Object)
		{
			pics = new Dictionary;
			
			source = value;
		}
	}
}