package app.model
{
	import app.model.vo.IconsVO;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class IconsProxy extends Proxy implements IProxy
	{
		public static const NAME:String = "IconsProxy";
		
		public function IconsProxy()
		{
			super(NAME, new IconsVO);
		}
		
		public function get icons():IconsVO
		{
			return data as IconsVO;
		}
	}
}