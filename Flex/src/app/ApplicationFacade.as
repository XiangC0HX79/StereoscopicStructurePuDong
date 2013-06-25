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
		public static const NOTIFY_INIT_COMMANDHEIGHT:String		= "InitCommandHeight";
		public static const NOTIFY_INIT_CLOSEDHANDLE:String		= "InitClosedHandle";
		public static const NOTIFY_INIT_TRAFFIC:String		= "InitTraffic";
		public static const NOTIFY_INIT_HAZZARD:String		= "InitHazzard";
		public static const NOTIFY_INIT_FIREHYDRANT:String		= "InitFireHydrant";
		public static const NOTIFY_INIT_KEYUNIT:String		= "IniKeyUnit";
		public static const NOTIFY_INIT_SCENTING:String		= "InitScenting";
		public static const NOTIFY_INIT_TATICS:String		= "InitTatics";
		public static const NOTIFY_INIT_PASSAGE:String		= "InitPassage";
		public static const NOTIFY_INIT_FLOORPIC:String		= "InitFloorPic";
		public static const NOTIFY_INIT_FLOOR:String		= "InitFloor";
		
		public static const NOTIFY_INIT_APP:String			= "InitApp";
		
		public static const NOTIFY_SHOW_INFO:String			= "ShowInfo";
				
		public static const NOTIFY_TITLEWINDOW_MEDIA:String	= "TitleWindowMedia";
		public static const NOTIFY_TITLEWINDOW_FLOOR:String	= "titlewindow_floor";
		public static const NOTIFY_TITLEWINDOW_MOVIE:String	= "titlewindow_movie";
		public static const NOTIFY_TITLEWINDOW_COMMAND:String	= "titlewindow_command";
		public static const NOTIFY_TITLEWINDOW_HAZARD:String	= "TitleWindowHazard";
		public static const NOTIFY_TITLEWINDOW_RESCUE:String	= "TitlewindowRescue";
		public static const NOTIFY_TITLEWINDOW_KEYUNIT:String	= "TitleWindowKeyUnit";
		public static const NOTIFY_TITLEWINDOW_SCENTING:String	= "TitleWindowScenting";
		public static const NOTIFY_TITLEWINDOW_TATICS:String	= "TitleWindowTatics";
		public static const NOTIFY_TITLEWINDOW_TATICALPOINT:String	= "TitleWindowTaticalPoint";
		
		public static const NOTIFY_MOVIE_POPUP:String		= "movie_popup";
		
		public static const NOTIFY_MENU_PASSAGE_PLAN:String			= "MenuPassagePlan";
		public static const NOTIFY_MENU_PASSAGE_UNDERGROUND:String	= "MenuPassageUnderGround";
		public static const NOTIFY_MENU_PASSAGE_GROUND:String			= "MenuPassageGround";
		public static const NOTIFY_MENU_PASSAGE_TOPFLOOR:String		= "MenuPassageTopFloor";
		public static const NOTIFY_MENU_PASSAGE_FRESHAIR:String		= "MenuPassageFreshAir";
		public static const NOTIFY_MENU_PASSAGE_SPECIAL:String		= "MenuPassageSpecial";
		
		public static const NOTIFY_FLOOR_UPDATE:String		= "FloorUpdate";		
		public static const NOTIFY_FLOOR_FOCUS:String		= "floor_focus";
		
		public static const NOTIFY_COMMAND_OVER:String		= "CommandOver";
		public static const NOTIFY_COMMAND_OUT:String		= "CommandOut";
		
		public static const NOTIFY_CLOSE_ADD_START:String		= "CloseAddStart";
		public static const NOTIFY_CLOSE_ADD_MOVE:String		= "CloseAddMove";
		
		public static const NOTIFY_SURROUNDING_KEYUNIT:String		= "SurroundingKeyUnit";
		
		public static const NOTIFY_STEREO_LAYER:String		= "StereoLayer";
		
		public static const NOTIFY_FIRE_ADD:String			= "FireAdd";
		public static const NOTIFY_FIRE_DEL:String			= "FireDel";
		
		public static const NOTIFY_VIDEO_ADD:String			= "VideoAdd";
		public static const NOTIFY_VIDEO_DEL:String			= "VideoDel";
				
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