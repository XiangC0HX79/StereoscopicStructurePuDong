package app
{	
	import app.controller.StartupCommand;
	
	import org.puremvc.as3.interfaces.IFacade;
	import org.puremvc.as3.patterns.facade.Facade;
	
	import spark.components.Application;
	
	public class ApplicationFacade extends Facade implements IFacade
	{
		public static const STARTUP:String 					= "startup";
		
		public static const NOTIFY_APP_LOADINGSHOW:String	= "apploadingshow";
		public static const NOTIFY_APP_LOADINGTEXT:String	= "ApploadingText";
		public static const NOTIFY_APP_LOADINGHIDE:String	= "apploadinghide";
		
		public static const NOTIFY_APP_ALERTINFO:String		= "appalertinfo";
		public static const NOTIFY_APP_ALERTALARM:String	= "appalertalarm";
		public static const NOTIFY_APP_ALERTERROR:String	= "appalerterror";
		
		public static const NOTIFY_INIT_CONFIG:String		= "InitConfig";
		public static const NOTIFY_INIT_ICONS:String		= "InitIcons";
		public static const NOTIFY_INIT_BUILD:String		= "InitBuild";
		
		public static const NOTIFY_INIT_APP:String			= "InitApp";
						
		public static const NOTIFY_TITLEWINDOW_FLOOR:String	= "titlewindow_floor";
		public static const NOTIFY_TITLEWINDOW_IMAGE:String	= "titlewindow_image";
		public static const NOTIFY_TITLEWINDOW_MOVIE:String	= "titlewindow_movie";
		public static const NOTIFY_TITLEWINDOW_COMMAND:String	= "titlewindow_command";
		public static const NOTIFY_TITLEWINDOW_COMMAND_IMGLST:String	= "titlewindow_command_imglst";
		public static const NOTIFY_TITLEWINDOW_CLOSED_IMGLST:String	= "titlewindow_closed_imglst";
		public static const NOTIFY_TITLEWINDOW_TRAFFIC:String	= "TitleWindowTraffic";
		public static const NOTIFY_TITLEWINDOW_HAZARD:String	= "TitleWindowHazard";
		public static const NOTIFY_TITLEWINDOW_RESCUE:String	= "TitlewindowRescue";
		public static const NOTIFY_TITLEWINDOW_KEYUNIT:String	= "TitleWindowKeyUnit";
		public static const NOTIFY_TITLEWINDOW_SCENTING:String	= "TitleWindowScenting";
		public static const NOTIFY_TITLEWINDOW_TATICS:String	= "TitleWindowTatics";
		public static const NOTIFY_TITLEWINDOW_TATICALPOINT:String	= "TitleWindowTaticalPoint";
		
		public static const NOTIFY_MOVIE_POPUP:String		= "movie_popup";
				
		public static const NOTIFY_FLOOR_UPDATE:String		= "FloorUpdate";		
		public static const NOTIFY_FLOOR_FOCUS:String		= "floor_focus";
		
		public static const NOTIFY_COMMAND_OVER:String		= "CommandOver";
		public static const NOTIFY_COMMAND_OUT:String		= "CommandOut";
		
		public static const NOTIFY_SURROUNDING_KEYUNIT:String		= "SurroundingKeyUnit";
		
		public static const NOTIFY_STEREO_LAYER:String		= "StereoLayer";
		
		public static const NOTIFY_FIRE_ADD:String			= "FireAdd";
		public static const NOTIFY_FIRE_DEL:String			= "FireDel";
				
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
		}
	}
}