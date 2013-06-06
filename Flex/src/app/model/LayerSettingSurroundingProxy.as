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
			Layers.addItem(new LayerVO(3,"重要交通信息"));			
			Layers.addItem(new LayerVO(4,"危险源"));		
			Layers.addItem(new LayerVO(5,"救援信息"));
			Layers.addItem(new LayerVO(5,"消防栓"));
			Layers.addItem(new LayerVO(5,"重点单位"));
			Layers.addItem(new LayerVO(5,"窨井通道"));
		}
		
		public function get Layers():ArrayCollection
		{
			return data as ArrayCollection;
		}
	}
}