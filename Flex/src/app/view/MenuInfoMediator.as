package app.view
{
	import app.ApplicationFacade;
	import app.model.BuildProxy;
	import app.view.components.MenuInfo;
	
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class MenuInfoMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "MenuInfoMediator";
		
		private var buildProxy:BuildProxy;
		
		public function MenuInfoMediator()
		{
			super(NAME, new MenuInfo);
			
			menuInfo.addEventListener(MenuInfo.DESCRIPTION,onDescription);
			menuInfo.addEventListener(MenuInfo.FUNCDIVISION,onFuncDivision);
			menuInfo.addEventListener(MenuInfo.SECURITYORG,onSecurityOrg);
			menuInfo.addEventListener(MenuInfo.TACTICS,onTatics);
			
			buildProxy = facade.retrieveProxy(BuildProxy.NAME) as BuildProxy;
		}
		
		protected function get menuInfo():MenuInfo
		{
			return viewComponent as MenuInfo;
		}
		
		private function onDescription(event:Event):void
		{
			flash.net.navigateToURL(new URLRequest(buildProxy.build.TMB_descriptionPath));
			
		}
		
		private function onFuncDivision(event:Event):void
		{
			flash.net.navigateToURL(new URLRequest(buildProxy.build.TMB_FuncDivisionPath));			
		}
		
		private function onSecurityOrg(event:Event):void
		{
			flash.net.navigateToURL(new URLRequest(buildProxy.build.TMB_SecurityOrgPath));			
		}
		
		private function onTatics(event:Event):void
		{
			sendNotification(ApplicationFacade.NOTIFY_TITLEWINDOW_TATICS);
		}
	}
}