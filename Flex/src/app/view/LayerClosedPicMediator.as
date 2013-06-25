package app.view
{
	import app.ApplicationFacade;
	import app.model.ClosedHandleLineProxy;
	import app.model.vo.BuildVO;
	import app.model.vo.LayerVO;
	import app.view.components.LayerClosedPic;
	
	import flash.display.BitmapData;
	import flash.display.GraphicsPathCommand;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import mx.binding.utils.BindingUtils;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import spark.components.Group;
	
	public class LayerClosedPicMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "LayerClosedPicMediator";
		
		private const ARROW_WIDTH:Number = 30;
		
		private var _closePointStart:Point;
		
		public function LayerClosedPicMediator()
		{
			super(NAME, new Group);
			
			layerClosedPic.top = 0;
			layerClosedPic.bottom = 0;
			layerClosedPic.left = 0;
			layerClosedPic.right = 0;
			
			layerClosedPic.visible = false;
		}
		
		protected function get layerClosedPic():Group
		{
			return viewComponent as Group;
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				ApplicationFacade.NOTIFY_INIT_BUILD,
				
				ApplicationFacade.NOTIFY_CLOSE_ADD_START,
				ApplicationFacade.NOTIFY_CLOSE_ADD_MOVE,
				ApplicationFacade.NOTIFY_CLOSE_ADD_END
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case ApplicationFacade.NOTIFY_INIT_BUILD:				
					var build:BuildVO = notification.getBody() as BuildVO;
					//layerClosedPic.source = build.T_ClosedPicPath;
										
					BindingUtils.bindProperty(layerClosedPic,"visible",LayerVO.CLOSEHANDLE,"LayerVisible");
					break;
				
				case ApplicationFacade.NOTIFY_CLOSE_ADD_START:
					_closePointStart = notification.getBody() as Point;
					break;
				
				case ApplicationFacade.NOTIFY_CLOSE_ADD_MOVE:
					drawCloseHandleAdd(notification.getBody() as Point);
					break;
				
				case ApplicationFacade.NOTIFY_CLOSE_ADD_END:
					var proxy:ClosedHandleLineProxy = facade.retrieveProxy(ClosedHandleLineProxy.NAME) as ClosedHandleLineProxy;
					proxy.AddFireHydrant(_closePointStart,notification.getBody() as Point);
					break;
			}
		}
		
		private function drawCloseHandleAdd(pt:Point):void
		{			
			layerClosedPic.graphics.clear();
			
			var dx:Number = pt.x - _closePointStart.x;
			var dy:Number = pt.y - _closePointStart.y;
			
			var arrow:Sprite = new Sprite;
			
			var coords:Vector.<Number> = new Vector.<Number>;
			var commands:Vector.<int> = new Vector.<int>;
			
			coords.push(0,0);
			commands.push(GraphicsPathCommand.MOVE_TO);
			
			coords.push(ARROW_WIDTH,10);
			commands.push(GraphicsPathCommand.LINE_TO);
			
			coords.push(0,20);
			commands.push(GraphicsPathCommand.LINE_TO);
			
			arrow.graphics.beginFill(0xFF0000);
			arrow.graphics.drawPath(commands,coords);
			arrow.graphics.endFill();
			
			var len:Number = Math.floor(Math.sqrt(dx * dx + dy * dy));
			len = (len < ARROW_WIDTH)?ARROW_WIDTH:len;
			
			var path:BitmapData = new BitmapData(len,20,true,0x0);
			
			if(len > ARROW_WIDTH)
				path.fillRect(new Rectangle(0,5,len - ARROW_WIDTH,10),0xFFFF0000);
			
			var matrix:Matrix = new Matrix(1,0,0,1,len - ARROW_WIDTH,0);
			path.draw(arrow,matrix);
			
			var back:BitmapData = new BitmapData(layerClosedPic.width,layerClosedPic.height,true,0x0);
			
			var angel:Number = Math.acos(dx / Math.sqrt(dx * dx + dy * dy));	
			if(pt.y < _closePointStart.y)
				angel = -angel;
			
			matrix = new Matrix(1,0,0,1,0,-10);
			matrix.rotate(angel);					
			matrix.concat(new Matrix(1,0,0,1,_closePointStart.x,_closePointStart.y));					
			back.draw(path,matrix);					
			
			layerClosedPic.graphics.beginBitmapFill(back,null,false);					
			layerClosedPic.graphics.drawRect(0,0,layerClosedPic.width,layerClosedPic.height); 					
			layerClosedPic.graphics.endFill();				
		}
		
	}
}