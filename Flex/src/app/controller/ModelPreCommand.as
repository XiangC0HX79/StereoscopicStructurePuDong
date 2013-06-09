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
			facade.registerProxy(new BuildProxy);	
			
			facade.registerProxy(new LayerSettingSurroundingProxy);
			facade.registerProxy(new LayerSettingStereoScopicProxy);
		}
	}
}