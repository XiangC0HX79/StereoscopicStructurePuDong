package app.view
{
	import app.ApplicationFacade;
	import app.model.BuildProxy;
	import app.model.vo.CommandHeightVO;
	import app.view.components.LayerDraw;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.GraphicsPathCommand;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import spark.primitives.Rect;
	
	public class LayerDrawMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "LayerDrawMediator";
		
		private const ARROW_WIDTH:Number = 30;
		
		private var buildProxy:BuildProxy;
		
		public function LayerDrawMediator()
		{
			super(NAME, new LayerDraw);
			
			buildProxy = facade.retrieveProxy(BuildProxy.NAME) as BuildProxy;
		}
		
		protected function get layerDraw():LayerDraw
		{
			return viewComponent as LayerDraw;
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				ApplicationFacade.NOTIFY_COMMAND_OVER,
				ApplicationFacade.NOTIFY_COMMAND_OUT
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case ApplicationFacade.NOTIFY_COMMAND_OVER:		
					var command:CommandHeightVO = notification.getBody() as CommandHeightVO;
					
					var dx:Number = command.TCH_X - buildProxy.build.TMB_X;
					var dy:Number = command.TCH_Y - buildProxy.build.TMB_Y;
					
					var arrow:Sprite = new Sprite;
					//arrow.width = 40;
					//arrow.height = 20;
					
					var coords:Vector.<Number> = new Vector.<Number>;
					var commands:Vector.<int> = new Vector.<int>;
					
					coords.push(0,10);
					commands.push(GraphicsPathCommand.MOVE_TO);
					
					coords.push(ARROW_WIDTH,0);
					commands.push(GraphicsPathCommand.LINE_TO);
					
					coords.push(ARROW_WIDTH,20);
					commands.push(GraphicsPathCommand.LINE_TO);
					
					arrow.graphics.beginFill(0xFF0000);
					arrow.graphics.drawPath(commands,coords);
					arrow.graphics.endFill();
					
					var part:BitmapData = new BitmapData(20,10,true,0x0);
					part.fillRect(new Rectangle(0,0,10,10),0xFFFF0000);
					
					var len:Number = Math.floor(Math.sqrt(dx * dx + dy * dy));
					len = (len < ARROW_WIDTH)?ARROW_WIDTH:len;
					
					var path:BitmapData = new BitmapData(len,50,true,0x0);
					//画箭头
					if(command.TCH_X < buildProxy.build.TMB_X)
					{
						var matrix:Matrix = new Matrix(-1,0,0,1,len,0);
						path.draw(arrow,matrix);
											
						for(var i:Number = 0;i<Math.ceil((len - ARROW_WIDTH) / part.width);i++)
						{
							matrix =new Matrix(1,0,0,1,i * part.width,5);	
							path.draw(part,matrix);
						}
					}
					else
					{
						matrix = new Matrix(1,0,0,1,0,0);
						path.draw(arrow,matrix);
						
						for(i = 0;i<Math.ceil((len - ARROW_WIDTH) / part.width);i++)
						{
							matrix =new Matrix(1,0,0,1,ARROW_WIDTH + i * part.width,5);	
							path.draw(part,matrix);
						}
					}
																			
					var textFmt:TextFormat = new TextFormat;					
					textFmt.size = 20;
					textFmt.bold = true;
					textFmt.color = 0xFF0000;	
					
					var text:TextField = new TextField;
					text.text = command.TCH_LineLength + "米";
					text.setTextFormat(textFmt);
					text.width = text.getLineMetrics(0).width;
					
					path.draw(text,new Matrix(1,0,0,1,len / 2 - text.width / 2,25));
					
					var back:BitmapData = new BitmapData(layerDraw.width,layerDraw.height,true,0x0);
					var angel:Number = Math.atan(dy / dx);					
					if(command.TCH_X < buildProxy.build.TMB_X)
					{
						matrix = new Matrix(1,0,0,1,0,-5);
					}
					else
					{
						matrix = new Matrix(1,0,0,1,-len,-5);	
					}					
					matrix.rotate(angel);					
					matrix.concat(new Matrix(1,0,0,1,command.TCH_X,command.TCH_Y));					
					back.draw(path,matrix);					
					
					layerDraw.graphics.beginBitmapFill(back,null,false);					
					layerDraw.graphics.drawRect(0,0,layerDraw.width,layerDraw.height); 					
					layerDraw.graphics.endFill();					
					break;
				
				case ApplicationFacade.NOTIFY_COMMAND_OUT:
					layerDraw.graphics.clear();
					break;
			}
		}
	}
}