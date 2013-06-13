package app.model.vo
{
	import mx.utils.UIDUtil;

	[Bindable]
	public class FireHydrantVO
	{
		public static const MOVE:String = "move";
		public static const ADD:String = "add";
		public static const DEL:String = "del";
		
		public static var Tool:String = MOVE;
		
		private var _source:*;
				
		public function get T_FireHydrantID():String
		{
			return _source.T_FireHydrantID;
		}
				
		public function get T_FireHydrantX():Number
		{
			return _source.T_FireHydrantX;
		}		
		public function set T_FireHydrantX(value:Number):void
		{
			_source.T_FireHydrantX = value;
		}
		
		public function get T_FireHydrantY():Number
		{
			return _source.T_FireHydrantY;
		}		
		public function set T_FireHydrantY(value:Number):void
		{
			_source.T_FireHydrantY = value;
		}
		
		public function FireHydrantVO(value:*)
		{
			_source = value;
			
			_source.T_FireHydrantID = UIDUtil.createUID();
		}
	}
}