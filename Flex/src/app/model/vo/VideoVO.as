package app.model.vo
{
	import mx.utils.UIDUtil;

	[Bindable]
	public class VideoVO
	{
		public static const MOVE:String = "move";
		public static const ADD:String = "add";
		public static const DEL:String = "del";
		
		public static var Tool:String = MOVE;
		
		private var _source:*;
		
		public function get T_VideoID():String
		{
			return _source.T_VideoID;
		}
		
		public function get TMB_ID():Number
		{
			return _source.TMB_ID;
		}	
		public function set TMB_ID(value:Number):void
		{
			_source.TMB_ID = value;
		}
				
		public function get T_PassageID():Number
		{
			return _source.T_PassageID;
		}	
		public function set T_PassageID(value:Number):void
		{
			_source.T_PassageID = value;
		}
		
		public function get T_VideoX():Number
		{
			return _source.T_VideoX;
		}		
		public function set T_VideoX(value:Number):void
		{
			edit = true;
			_source.T_VideoX = value;
		}
		
		public function get T_VideoY():Number
		{
			return _source.T_VideoY;
		}		
		public function set T_VideoY(value:Number):void
		{
			edit = true;
			_source.T_VideoY = value;
		}
		
		public var edit:Boolean = false;
		
		public function VideoVO(value:*)
		{
			_source = value;
			
			_source.T_VideoID = UIDUtil.createUID();
		}
	}
}