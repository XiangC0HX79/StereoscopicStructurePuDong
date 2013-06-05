package app.model
{
	import app.model.vo.LayerVO;
	
	import mx.collections.ArrayCollection;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class LayerSettingStereoScopicProxy extends Proxy implements IProxy
	{
		public static const NAME:String = "LayerSettingStereoScopicProxy";
		
		public function LayerSettingStereoScopicProxy()
		{
			super(NAME, new ArrayCollection);
			
			Layers.addItem(new LayerVO(1,"应急疏散通道"));			
			Layers.addItem(new LayerVO(2,"总控室"));			
			Layers.addItem(new LayerVO(3,"监控中心"));			
			Layers.addItem(new LayerVO(4,"电梯"));		
			Layers.addItem(new LayerVO(5,"其他重要部位"));
		}
		
		public function get Layers():ArrayCollection
		{
			return data as ArrayCollection;
		}
				
		public function get visible():Boolean
		{
			var r:Boolean = false;
			for each(var layer:LayerVO in Layers)
			{
				r ||= layer.LayerVisible;
			}
			
			return r;
		}
		
		public function getLayer(id:Number):LayerVO
		{
			for each(var layer:LayerVO in Layers)
			{
				if(layer.LayerID == id)
					return layer;
			}
			
			return null;
		}
	}
}