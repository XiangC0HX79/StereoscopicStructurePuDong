package app.view
{
	import app.ApplicationFacade;
	import app.model.BuildProxy;
	import app.model.ScentingLineProxy;
	import app.model.vo.BuildVO;
	import app.model.vo.CommandHeightVO;
	import app.model.vo.LayerVO;
	import app.model.vo.ScentingLineVO;
	import app.view.components.LayerScentingPic;
	
	import flash.display.Graphics;
	import flash.display.GraphicsPathCommand;
	import flash.geom.Point;
	
	import mx.binding.utils.BindingUtils;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import spark.components.Image;
	
	public class LayerScentingPicMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "LayerScentingPicMediator";
		
		private var _line:Array;
		
		public function LayerScentingPicMediator()
		{
			super(NAME, new LayerScentingPic);
			
			_line = new Array;
		}
		
		protected function get layerScentingPic():LayerScentingPic
		{
			return viewComponent as LayerScentingPic;
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				ApplicationFacade.NOTIFY_INIT_SCENTING_LINE,
				
				ApplicationFacade.NOTIFY_INIT_BUILD,
				
				ApplicationFacade.NOTIFY_SCENTING_ADD_START,
				ApplicationFacade.NOTIFY_SCENTING_ADD_MOVE,
				ApplicationFacade.NOTIFY_SCENTING_ADD_END,
				
				ApplicationFacade.NOTIFY_SCENTING_LINE_ADD,
				ApplicationFacade.NOTIFY_SCENTING_LINE_DEL
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case ApplicationFacade.NOTIFY_INIT_SCENTING_LINE:
					for each(var sl:ScentingLineVO in notification.getBody())
						drawPath(sl.path,layerScentingPic.sprite.graphics);
					break;
				
				case ApplicationFacade.NOTIFY_INIT_BUILD:						
					var build:BuildVO = notification.getBody() as BuildVO;
					
					//layerScentingPic.source = build.T_ScentingPicPath;
										
					BindingUtils.bindProperty(layerScentingPic,"visible",LayerVO.SCENTING,"LayerVisible");
					break;
				
				case ApplicationFacade.NOTIFY_SCENTING_ADD_START:
					_line.push(notification.getBody());
					break;
				
				case ApplicationFacade.NOTIFY_SCENTING_ADD_MOVE:
					layerScentingPic.graphics.clear();
					
					var t:Array = new Array;
					for each(var pt:Point in _line)
						t.push(pt);
					t.push(notification.getBody());
					
					drawPath(t,layerScentingPic.graphics);
					break;
				
				case ApplicationFacade.NOTIFY_SCENTING_ADD_END:					
					_line.push(notification.getBody());
					
					var scentingLineProxy:ScentingLineProxy = facade.retrieveProxy(ScentingLineProxy.NAME) as ScentingLineProxy;
					scentingLineProxy.AddScentingLine(_line);	
					
					_line = new Array;
					layerScentingPic.graphics.clear();	
					break;
				
				case ApplicationFacade.NOTIFY_SCENTING_LINE_ADD:
					sl = notification.getBody() as ScentingLineVO;
					drawPath(sl.path,layerScentingPic.sprite.graphics);
					break;
				
				case ApplicationFacade.NOTIFY_SCENTING_LINE_DEL:					
					layerScentingPic.sprite.graphics.clear();
					for each(sl in notification.getBody())
					{
						drawPath(sl.path,layerScentingPic.sprite.graphics);
					}
					break;
			}
		}
		
		private function drawPath(path:Array,gr:Graphics):void
		{
			if(path.length < 2)
				return;
			
			var coords:Vector.<Number> = new Vector.<Number>;
			var commands:Vector.<int> = new Vector.<int>;
			
			coords.push(path[0].x,path[0].y);
			commands.push(GraphicsPathCommand.MOVE_TO);
			
			for(var i:Number = 1;i<path.length;i++)
			{
				coords.push(path[i].x,path[i].y);
				commands.push(GraphicsPathCommand.LINE_TO);
			}
						
			gr.lineStyle(4,0xFFFFFF);
			gr.drawPath(commands,coords);
			
			gr.lineStyle(2,0xFF);
			gr.drawPath(commands,coords);
		}
	}
}