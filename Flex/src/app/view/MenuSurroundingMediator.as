package app.view
{
	import app.view.components.MenuSurrounding;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class MenuSurroundingMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "MenuSurroundingMediator";
		
		public function MenuSurroundingMediator()
		{
			super(NAME, new MenuSurrounding);
		}
		
		protected function get menuSurrounding():MenuSurrounding
		{
			return viewComponent as MenuSurrounding;
		}
	}
}