package app.controller
{	
	import app.model.*;
	
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
			facade.registerProxy(new CommandHeightProxy);		
			facade.registerProxy(new ClosedHandleProxy);		
			facade.registerProxy(new ClosedHandleLineProxy);		
			facade.registerProxy(new TrafficProxy);					
			facade.registerProxy(new HazardProxy);					
			facade.registerProxy(new FireHydrantProxy);				
			facade.registerProxy(new KeyUnitProxy);			
			facade.registerProxy(new ScentingProxy);	
			
			facade.registerProxy(new TaticsProxy);	
			
			facade.registerProxy(new PassageProxy);	
			
			facade.registerProxy(new FloorPicProxy);
			facade.registerProxy(new FloorPorxy);	
		}
	}
}