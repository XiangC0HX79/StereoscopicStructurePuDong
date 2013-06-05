package app
{	
	import app.controller.LoadImageCommand;
	import app.controller.StartupCommand;
	import app.controller.WebServiceCommand;
	
	import org.puremvc.as3.interfaces.IFacade;
	import org.puremvc.as3.patterns.facade.Facade;
	
	import spark.components.Application;
	
	public class ApplicationFacade extends Facade implements IFacade
	{
		public static const STARTUP:String 					= "startup";
		
		public static const NOTIFY_APP_LOADINGSHOW:String	= "apploadingshow";
		public static const NOTIFY_APP_LOADINGHIDE:String	= "apploadinghide";
		
		public static const NOTIFY_APP_ALERTINFO:String		= "appalertinfo";
		public static const NOTIFY_APP_ALERTALARM:String	= "appalertalarm";
		public static const NOTIFY_APP_ALERTERROR:String	= "appalerterror";
				
		public static const NOTIFY_APP_INIT:String			= "appinit";
		
		public static const NOTIFY_WEBSERVICE_SEND:String	= "webservice_send";
		
		public static const NOTIFY_COMMAND_LOADIMAGE:String	= "command_loadimage";
		
		public static const NOTIFY_TITLEWINDOW_FLOOR:String	= "titlewindow_floor";
		public static const NOTIFY_TITLEWINDOW_IMAGE:String	= "titlewindow_image";
		public static const NOTIFY_TITLEWINDOW_MOVIE:String	= "titlewindow_movie";
		
		public static const NOTIFY_MOVIE_POPUP:String		= "movie_popup";
		
		public static const NOTIFY_STEREO_LAYER:String		= "StereoLayer";
		
		public static const NOTIFY_FLOOR_ROTATION:String	= "floor_rotation";
		
		public static const NOTIFY_FLOOR_FOCUS:String		= "floor_focus";
		
		/**
		 * Singleton ApplicationFacade Factory Method
		 */
		public static function getInstance() : ApplicationFacade 
		{
			if ( instance == null ) instance = new ApplicationFacade( );
			return instance as ApplicationFacade;
		}
		
		/**
		* Start the application
		*/
		public function startup(app:Object):void 
		{
			sendNotification( STARTUP, app );	
		}
		
		/**
		 * Register Commands with the Controller 
		 */
		override protected function initializeController( ) : void
		{
			super.initializeController();
			
			registerCommand( STARTUP, StartupCommand );	
			
			registerCommand( NOTIFY_WEBSERVICE_SEND, WebServiceCommand );	
			
			registerCommand( NOTIFY_COMMAND_LOADIMAGE, LoadImageCommand );
		}
	}
}