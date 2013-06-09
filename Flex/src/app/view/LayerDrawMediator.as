package app.view
{
	import app.ApplicationFacade;
	import app.model.BuildProxy;
	import app.model.vo.CommandHeightVO;
	import app.view.components.LayerDraw;
	
	import flash.display.BitmapData;
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
					
					var part:BitmapData = new BitmapData(20,10,true,0x0);
					part.fillRect(new Rectangle(0,0,10,10),0xFFFF0000);
					
					var len:Number = Math.floor(Math.sqrt(dx * dx + dy * dy));
					
					var path:BitmapData = new BitmapData(len,40,true,0x0);
					
					for(var i:Number = 0;i<Math.floor(len / part.width);i++)
					{
						var matrix:Matrix = new Matrix(1,0,0,1,i * part.width,0);
						path.draw(part,matrix);
					}
										
					var text:TextField = new TextField;
					text.text = "20米";
					
					var textFmt:TextFormat = new TextFormat;
					textFmt.size = 20;
					textFmt.bold = true;
					textFmt.color = 0xFF0000;	
					text.setTextFormat(textFmt);
					
					path.draw(text,new Matrix(1,0,0,1,len / 2 - text.width / 2,15));
										
					matrix = new Matrix(1,0,0,1,0,-5);
										
					matrix.rotate(Math.asin(dy / len) + Math.PI);
					
					matrix.concat(new Matrix(1,0,0,1,command.TCH_X,command.TCH_Y));
					
					var back:BitmapData = new BitmapData(layerDraw.width,layerDraw.height,true,0x0);
					back.draw(path,matrix);
					
					layerDraw.graphics.beginBitmapFill(back,null,false);
					
					layerDraw.graphics.drawRect(0,0,layerDraw.width,layerDraw.height); 
					//var num:Number = Math. ;
					//path.
					
					break;
				
				case ApplicationFacade.NOTIFY_COMMAND_OUT:
					layerDraw.graphics.clear();
					break;
					break;
			}
		}
	}
}