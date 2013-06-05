package app.model
{
	import app.model.vo.BuildVO;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class BuildProxy extends Proxy implements IProxy
	{
		public static const NAME:String = "BuildProxy";
		
		public function BuildProxy()
		{
			super(NAME, new BuildVO);
		}
		
		public function get build():BuildVO
		{
			return data as BuildVO;
		}
	}
}