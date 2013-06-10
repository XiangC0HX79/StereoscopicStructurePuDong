package app.model.vo
{
	import app.controller.WebServiceCommand;
	
	import flash.display.Bitmap;
	import flash.geom.Point;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	public class CommandHeightVO
	{
		public static var Icon:Bitmap;
		
		private var source:Object;
		
		public function get TCH_ID():Number
		{
			return source.TCH_ID;
		}
		
		public function get TCH_X():Number
		{
			return source.TCH_X;
		}
		
		public function get TCH_Y():Number
		{
			return source.TCH_Y;
		}
		
		public function get TCH_Name():String
		{
			return source.TCH_Name?source.TCH_Name:"";
		}
		
		public function get T_ComPicPath():String
		{
			return  source.T_ComPicPath.replace("../",WebServiceCommand.WSDL);	
		}
		
		public function get TCH_LineLength():Number
		{
			return source.TCH_LineLength;
		}
		
		public function get TCH_Address():String
		{
			return source.TCH_Address;
		}
		
		public function get TCH_Layers():String
		{
			return source.TCH_Layers;
		}
		
		public function get TCH_ComHeightFunc():String
		{
			return source.TCH_ComHeightFunc;
		}
		
		public function get TCH_bestobservation():String
		{
			return source.TCH_bestobservation;
		}
		
		public function get TCH_Entranceway():String
		{
			return source.TCH_Entranceway;
		}
		
		public function get TCH_Property():String
		{
			return source.TCH_Property;
		}
				
		public var pics:ArrayCollection = new ArrayCollection;
		
		public function CommandHeightVO(value:Object)
		{
			source = value;
		}
	}
}