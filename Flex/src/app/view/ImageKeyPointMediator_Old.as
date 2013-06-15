package app.view
{
	import app.view.components.ImageKeyPoint;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class ImageKeyPointMediator_Old extends Mediator implements IMediator
	{
		public function ImageKeyPointMediator_Old(mediatorName:String=null, viewComponent:Object=null)
		{
			super(mediatorName, viewComponent);
		}
		
		protected function get imageKeyPoint():ImageKeyPoint
		{
			return viewComponent as ImageKeyPoint;
		}
	}
}