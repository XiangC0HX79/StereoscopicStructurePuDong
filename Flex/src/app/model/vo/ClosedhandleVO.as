package app.model.vo
{
	import mx.collections.ArrayCollection;

	[Bindable]
	public class ClosedhandleVO
	{
		private var source:Object;
		
		public function get T_ClosedhandlesID():Number
		{
			return source.T_ClosedhandlesID;
		}
		
		public function get T_ClosedX():Number
		{
			return source.T_ClosedX;
		}
		
		public function get T_ClosedY():Number
		{
			return source.T_ClosedY;
		}
		
		public var pics:ArrayCollection;
		
		public function ClosedhandleVO(value:Object)
		{
			source = value;
		}
	}
}