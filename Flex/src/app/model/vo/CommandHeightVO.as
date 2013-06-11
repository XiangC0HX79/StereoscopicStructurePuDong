package app.model.vo
{
	import app.controller.WebServiceCommand;
	
	import flash.display.Bitmap;
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	public class CommandHeightVO extends WebServiceVO
	{		
		protected var _source:Object;
				
		public function get TCH_ID():Number
		{
			return _source.TCH_ID;
		}
		
		public function get TCH_X():Number
		{
			return _source.TCH_X;
		}
		public function set TCH_X(value:Number):void
		{
			_source.TCH_X = value;
		}
		
		public function get TCH_Y():Number
		{
			return _source.TCH_Y;
		}
		public function set TCH_Y(value:Number):void
		{
			_source.TCH_Y = value;
		}
		
		public function get TCH_Name():String
		{
			return _source.TCH_Name?_source.TCH_Name:"";
		}
		
		public function get T_ComPicPath():String
		{
			return  _source.T_ComPicPath.replace("../",WebServiceVO.BASE_WSDL);	
		}
		
		public function get TCH_LineLength():Number
		{
			return _source.TCH_LineLength;
		}
		
		public function get TCH_Address():String
		{
			return _source.TCH_Address;
		}
		
		public function get TCH_Layers():String
		{
			return _source.TCH_Layers;
		}
		
		public function get TCH_ComHeightFunc():String
		{
			return _source.TCH_ComHeightFunc;
		}
		
		public function get TCH_bestobservation():String
		{
			return _source.TCH_bestobservation;
		}
		
		public function get TCH_Entranceway():String
		{
			return _source.TCH_Entranceway;
		}
		
		public function get TCH_Property():String
		{
			return _source.TCH_Property;
		}
				
		public var pics:ArrayCollection;
		
		public function CommandHeightVO(value:Object)
		{
			_source = value;
		}
		   
		public function InitPics():void
		{
			send("InitCommandingHeightsPic",onInitPics,this.TCH_ID);
		}		
		
		private function onInitPics(result:ArrayCollection):void
		{				
			pics = new ArrayCollection;
			
			for each(var i:Object in result)
			{
				pics.addItem(new CommandHeightPicVO(i));
			}
			
			dispatchEvent(new Event(Event.COMPLETE));			
		}
	}
}