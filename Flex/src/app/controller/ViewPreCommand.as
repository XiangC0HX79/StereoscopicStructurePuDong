package app.controller
{	
	import app.view.*;
	import app.view.components.PanelPassage;
	
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
						
			
			facade.registerMediator(new AppAlertMediator);
			
			facade.registerMediator(new TitleWindowMediaMediator);
			facade.registerMediator(new TitleWindowFloorMediator);		
			facade.registerMediator(new TitleWindowMovieMediator);			
			facade.registerMediator(new TitleWindowCommandHeightMediator);	
			facade.registerMediator(new TitleWindowRescueImgMediator);
			facade.registerMediator(new TitleWindowKeyUnitMediator);
			facade.registerMediator(new TitleWindowScentingMediator);
			facade.registerMediator(new TitleWindowHazardMediator);
			facade.registerMediator(new TitleWindowTaticsMediator);
			facade.registerMediator(new TitleWindowTaticalPointMediator);
			
			facade.registerMediator(new MenuSurroundingMediator);	
			facade.registerMediator(new MenuInfoMediator);	
			facade.registerMediator(new MenuPassageMediator);	
			facade.registerMediator(new MenuStereoScopicStructureMediator);
			facade.registerMediator(new MenuStereoScopicEditMediator);
			
			facade.registerMediator(new LayerClosedPicMediator);		
			facade.registerMediator(new LayerDrawMediator);		
			facade.registerMediator(new LayerCommandingHeightMediator);
			facade.registerMediator(new LayerCloseHandlesMediator);
			facade.registerMediator(new LayerTrafficMediator);
			facade.registerMediator(new LayerHazardMediator);
			facade.registerMediator(new LayerFireHydrantMediator);
			facade.registerMediator(new LayerKeyUnitsMediator);
			facade.registerMediator(new LayerScentingMediator);
			
			facade.registerMediator(new PanelSurroundingMediator);			
			facade.registerMediator(new PanelPassageMediator);			
			facade.registerMediator(new PanelStereoScopicStructureMediator);
			
			facade.registerMediator(new ApplicationMediator(application));	
			
		}
	}
}