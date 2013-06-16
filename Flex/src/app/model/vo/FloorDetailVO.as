package app.model.vo
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	import mx.utils.UIDUtil;

	[Bindable]
	public class FloorDetailVO
	{		
		private var _source:*;
		
		public function get layer():LayerVO
		{
			switch(T_FloorDetailType)
			{
				case 1:
					return LayerVO.EMERGENCYROUTE;
					break;
				
				case 2:
					return LayerVO.CONTROLROOM;
					break;
				
				case 3:
					return LayerVO.MONITOR;
					break;
				
				case 4:
					return LayerVO.ELEVATOR;
					break;
				
				case 5:
					return LayerVO.OTHERKEY;
					break;
			}
			
			return LayerVO.NONE;
		}
		
		public function get T_FloorDetailID():Number
		{
			return  _source.T_FloorDetailID;	
		}
		
		public function get T_FloorID():Number
		{
			return  _source.T_FloorID;	
		}
		
		public function get T_FloorPicID():Number
		{
			return  _source.T_FloorPicID;	
		}
		
		public function get T_FloorDetailName():String
		{
			return  _source.T_FloorDetailName;	
		}
		
		public function get T_FloorDetailType():Number
		{
			return  _source.T_FloorDetailType;	
		}
		
		public function get T_FloorDetailX():Number
		{
			return  isNaN(_source.T_FloorDetailX)?0:_source.T_FloorDetailX;	
		}
		
		public function get T_FloorDetailY():Number
		{
			return  isNaN(_source.T_FloorDetailY)?0:_source.T_FloorDetailY;	
		}
		
		public function get T_FloorDetailchildfloor():String
		{
			return  _source.T_FloorDetailchildfloor;	
		}
								
		public var medias:Dictionary; 
		
		public function FloorDetailVO(item:Object)
		{
			medias = new Dictionary;
			
			_source = item;
		}
	}
}