package app.view
{
	import app.ApplicationFacade;
	import app.model.ClosedHandleLineProxy;
	import app.model.vo.BuildVO;
	import app.model.vo.CloseHandleLineVO;
	import app.model.vo.ClosedHandlePicVO;
	import app.model.vo.LayerVO;
	import app.view.components.LayerClosedPic;
	
	import flash.display.BitmapData;
	import flash.display.Graphics;
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
	import spark.primitives.Graphic;
	import spark.primitives.Line;
	
	public class LayerClosedPicMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "LayerClosedPicMediator";
		
		private const ARROW_WIDTH:Number = 30;
		private const ARROW_HEIGHT:Number = 12;
		
		private var _closePointStart:Point;
		
		public function LayerClosedPicMediator()
		{
			super(NAME, new LayerClosedPic);
		}
		
		protected function get layerClosedPic():LayerClosedPic
		{
			return viewComponent as LayerClosedPic;
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				ApplicationFacade.NOTIFY_INIT_BUILD,
				
				ApplicationFacade.NOTIFY_CLOSE_ADD_START,
				ApplicationFacade.NOTIFY_CLOSE_ADD_MOVE,
				ApplicationFacade.NOTIFY_CLOSE_ADD_END,
				
				ApplicationFacade.NOTIFY_INIT_CLOSEDHANDLE_LINE,
				ApplicationFacade.NOTIFY_CLOSELINE_ADD,
				ApplicationFacade.NOTIFY_CLOSELINE_DEL
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
					layerClosedPic.graphics.clear();
					addCloseHandle(_closePointStart,notification.getBody() as Point,layerClosedPic.graphics);
					break;
				
				case ApplicationFacade.NOTIFY_CLOSE_ADD_END:
					var proxy:ClosedHandleLineProxy = facade.retrieveProxy(ClosedHandleLineProxy.NAME) as ClosedHandleLineProxy;
					proxy.AddFireHydrant(_closePointStart,notification.getBody() as Point);
					break;
				
				case ApplicationFacade.NOTIFY_INIT_CLOSEDHANDLE_LINE:
					for each(var cl:CloseHandleLineVO in notification.getBody())
					{
						addCloseHandle(cl.T_ClosedLineStart,cl.T_ClosedLineEnd,layerClosedPic.sprite.graphics);
					}
					break;
				
				case ApplicationFacade.NOTIFY_CLOSELINE_ADD:
					cl = notification.getBody() as CloseHandleLineVO;
					
					layerClosedPic.graphics.clear();
					
					addCloseHandle(cl.T_ClosedLineStart,cl.T_ClosedLineEnd,layerClosedPic.sprite.graphics);
					break;
				
				case ApplicationFacade.NOTIFY_CLOSELINE_DEL:
					layerClosedPic.sprite.graphics.clear();
					for each(cl in notification.getBody())
					{
						addCloseHandle(cl.T_ClosedLineStart,cl.T_ClosedLineEnd,layerClosedPic.sprite.graphics);
					}
					break;
			}
		}
		
		private function addCloseHandle(pts:Point,pte:Point,gr:Graphics):void
		{			
			var dx:Number = pte.x - pts.x;
			var dy:Number = pte.y - pts.y;
			
			var arrow:Sprite = new Sprite;
			
			var coords:Vector.<Number> = new Vector.<Number>;
			var commands:Vector.<int> = new Vector.<int>;
			
			coords.push(0,0);
			commands.push(GraphicsPathCommand.MOVE_TO);
			
			coords.push(ARROW_WIDTH,ARROW_HEIGHT / 2);
			commands.push(GraphicsPathCommand.LINE_TO);
			
			coords.push(0,ARROW_HEIGHT);
			commands.push(GraphicsPathCommand.LINE_TO);
			
			arrow.graphics.beginFill(0xFF0000);
			arrow.graphics.drawPath(commands,coords);
			arrow.graphics.endFill();
			
			var len:Number = Math.floor(Math.sqrt(dx * dx + dy * dy));
			len = (len < ARROW_WIDTH)?ARROW_WIDTH:len;
			
			var path:BitmapData = new BitmapData(len,ARROW_HEIGHT,true,0x0);
			
			if(len > ARROW_WIDTH)
				path.fillRect(new Rectangle(0,ARROW_HEIGHT / 4,len - ARROW_WIDTH,ARROW_HEIGHT / 2),0xFFFF0000);
			
			var matrix:Matrix = new Matrix(1,0,0,1,len - ARROW_WIDTH,0);
			path.draw(arrow,matrix);
			
			var back:BitmapData = new BitmapData(layerClosedPic.width,layerClosedPic.height,true,0x0);
			
			var angel:Number = Math.acos(dx / Math.sqrt(dx * dx + dy * dy));	
			if(pte.y < pts.y)
				angel = -angel;
			
			matrix = new Matrix(1,0,0,1,0,-(ARROW_HEIGHT / 2));
			matrix.rotate(angel);					
			matrix.concat(new Matrix(1,0,0,1,pts.x,pts.y));					
			back.draw(path,matrix);					
			
			gr.beginBitmapFill(back,null,false);					
			gr.drawRect(0,0,layerClosedPic.width,layerClosedPic.height); 					
			gr.endFill();				
		}
	}
}