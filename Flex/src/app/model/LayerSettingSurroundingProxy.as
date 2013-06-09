package app.model
{
	import app.model.vo.LayerVO;
	
	import mx.collections.ArrayCollection;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class LayerSettingSurroundingProxy extends Proxy implements IProxy
	{
		public static const NAME:String = "LayerSettingSurroundingProxy";
		
		public function LayerSettingSurroundingProxy()
		{
			super(NAME, new ArrayCollection);
			
			Layers.addItem(new LayerVO(1,"制高点"));			
			Layers.addItem(new LayerVO(2,"分控范围"));			
			Layers.addItem(LayerVO.TRAFFIC);			
			Layers.addItem(LayerVO.HAZARD);		
			Layers.addItem(new LayerVO(5,"救援信息"));
			Layers.addItem(new LayerVO(6,"消防栓"));
			Layers.addItem(LayerVO.KEYUNITS);
			Layers.addItem(LayerVO.SCENTING);
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