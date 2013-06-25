package app.model.vo
{
	import flash.utils.Dictionary;

	[Bindable]
	public class TrafficVO
	{
		private var source:Object;
		
		public function get T_TrafficID():Number
		{
			return source.T_TrafficID;
		}
		
		public function get T_TrafficName():String
		{
			return source.T_TrafficName;
		}
		
		public function get T_TrafficX():Number
		{
			return source.T_TrafficX;
		}
		public function set T_TrafficX(value:Number):void
		{
			edit = true;
			source.T_TrafficX = value;
		}
		
		public function get T_TrafficY():Number
		{
			return source.T_TrafficY;
		}
		public function set T_TrafficY(value:Number):void
		{
			edit = true;
			source.T_TrafficY = value;
		}
		
		public var pics:Dictionary;
		
		public var edit:Boolean = false;
		
		public function TrafficVO(value:Object)
		{
			pics = new Dictionary;
			source = value;
		}
	}
}