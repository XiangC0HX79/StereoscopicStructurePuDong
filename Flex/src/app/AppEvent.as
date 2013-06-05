package app
{
	import flash.events.Event;
	
	public class AppEvent extends Event
	{		
		public static const FLOORCHANGE:String = "floorchange";
		
		public var data:*;
		
		public function AppEvent(type:String,data:* = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			this.data = data;
		}
	}
}