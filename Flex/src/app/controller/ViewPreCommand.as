package app.controller
{	
	import app.view.ApplicationMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import spark.components.Application;
	
	public class ViewPreCommand extends SimpleCommand
	{
		override public function execute(note:INotification):void
		{
			var application:Application = note.getBody() as Application;
						
			application.styleManager.getStyleDeclaration("mx.controls.ToolTip").setStyle("fontWeight","bold");
			application.styleManager.getStyleDeclaration("mx.controls.ToolTip").setStyle("fontSize","20");
			application.styleManager.getStyleDeclaration("mx.controls.ToolTip").setStyle("fontFamily","微软雅黑");
			application.styleManager.getStyleDeclaration("mx.controls.ToolTip").setStyle("color","black");
			application.styleManager.getStyleDeclaration("mx.controls.ToolTip").setStyle("backgroundColor","#A8A8A8");
			
			facade.registerMediator(new ApplicationMediator(application));	
		}
	}
}