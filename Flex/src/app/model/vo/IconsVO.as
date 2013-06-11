package app.model.vo
{	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	public class IconsVO extends WebServiceVO
	{
		public var IconCommandHeight:IconVO;
		
		public var IconCloseHandle:IconVO;
		
		public function IconsVO()
		{
		}
		
		public function Init():void
		{
			send("InitIcon",onInit);
		}
		
		private function onInit(result:ArrayCollection):void
		{
			for each(var i:Object in result)
			{
				switch(i.IconID)
				{
					case "1":
						IconCommandHeight = new IconVO();
						IconCommandHeight.addEventListener(Event.COMPLETE,onComplete);
						IconCommandHeight.load(i.IconPath);
						break;
					
					case "2":
						IconCloseHandle = new IconVO();
						IconCloseHandle.addEventListener(Event.COMPLETE,onComplete);
						IconCloseHandle.load(i.IconPath);
						break;
				}
			}
		}
		
		private function onComplete(event:Event):void
		{
			if(
				IconCommandHeight.icon
				&& IconCloseHandle.icon
			)
			{
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}
	}
}