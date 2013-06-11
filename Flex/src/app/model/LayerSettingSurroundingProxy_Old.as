package app.model
{
	import app.model.vo.LayerVO;
	
	import mx.collections.ArrayCollection;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class LayerSettingSurroundingProxy_Old extends Proxy implements IProxy
	{
		public static const NAME:String = "LayerSettingSurroundingProxy";
		
		public function LayerSettingSurroundingProxy_Old()
		{
			super(NAME, new ArrayCollection);
		}
		
		public function get Layers():ArrayCollection
		{
			return data as ArrayCollection;
		}
		
		public function GetLayerByName(layerName:String):LayerVO
		{
			for each(var i:LayerVO in Layers)
			{
				if(i.LayerName == layerName)
					return i;
			}
			
			return null;
		}
	}
}