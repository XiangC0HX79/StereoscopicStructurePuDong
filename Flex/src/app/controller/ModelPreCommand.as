package app.controller
{	
	import app.model.BuildProxy;
	import app.model.ConfigProxy;
	import app.model.IconsProxy;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import spark.components.Application;
	
	public class ModelPreCommand extends SimpleCommand
	{
		override public function execute(note:INotification):void
		{						
			facade.registerProxy(new ConfigProxy);	
			
			facade.registerProxy(new IconsProxy);	
			
			facade.registerProxy(new BuildProxy);	
		}
	}
}