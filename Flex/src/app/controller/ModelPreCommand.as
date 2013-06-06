package app.controller
{	
	import app.model.BuildProxy;
	import app.model.LayerSettingStereoScopicProxy;
	import app.model.LayerSettingSurroundingProxy;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import spark.components.Application;
	
	public class ModelPreCommand extends SimpleCommand
	{
		override public function execute(note:INotification):void
		{			
			var buildProxy:BuildProxy = new BuildProxy;
			
			var application:Application = note.getBody() as Application;	
			buildProxy.build.buildName = application.parameters.build;	
			buildProxy.build.edit = (application.parameters.edit == "1");
			
			facade.registerProxy(buildProxy);	
			
			facade.registerProxy(new LayerSettingSurroundingProxy);
			facade.registerProxy(new LayerSettingStereoScopicProxy);
		}
	}
}