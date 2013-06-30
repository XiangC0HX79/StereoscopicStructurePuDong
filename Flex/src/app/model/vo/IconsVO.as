package app.model.vo
{	
	import flash.display.Bitmap;
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	public class IconsVO
	{
		/**
		 * 显示样式
		 * */
		public var IconCommandHeight:Bitmap;
		
		public var IconCloseHandle:Bitmap;
		
		public var IconTraffic:Bitmap;
		
		public var IconFireHydrant:Bitmap;
				
		public var IconKeyUnit:Bitmap;
		
		public var IconScenting:Bitmap;
		
		public var IconImportExport:Bitmap;
		
		public var IconEletric:Bitmap;
		
		public var IconGas:Bitmap;
		
		public var IconCan:Bitmap;
		
		public var IconVideo:Bitmap;
				
		/**
		 * 鼠标样式
		 * */		
		
		public var CursorFireAdd:Bitmap;
		
		public var CursorFireDel:Bitmap;
		
		public var CursorVideoAdd:Bitmap;
		
		public var CursorVideoDel:Bitmap;
		
		/**
		 * 菜单样式
		 * */
		public var MenuDefault:Bitmap;
		
		public var MenuSave:Bitmap;
		
		public var MenuFireAdd:Bitmap;
		
		public var MenuFireDel:Bitmap;
		
		public var MenuClosedAdd:Bitmap;
		
		public var MenuClosedDel:Bitmap;
		
		public var MenuScentingAdd:Bitmap;
		
		public var MenuScentingDel:Bitmap;
		
		public var MenuVideoAdd:Bitmap;
		
		public var MenuVideoDel:Bitmap;
		
		public function IconsVO()
		{
		}
	}
}