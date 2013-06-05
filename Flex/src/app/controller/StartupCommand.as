package app.controller
{	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.patterns.command.MacroCommand;
	
	import spark.components.Application;
	
	public class StartupCommand extends MacroCommand implements ICommand
	{
		override protected function initializeMacroCommand():void
		{			
			addSubCommand(ModelPreCommand);
			addSubCommand(ViewPreCommand);
			
			addSubCommand(LocalConfigCommand);
		}
	}
}