package app.model.vo
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.rpc.Fault;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.soap.Operation;
	import mx.rpc.soap.WebService;
	import mx.utils.ObjectProxy;
	
	public class WebServiceVO implements IEventDispatcher
	{
		public static var BASE_WSDL:String = "";
		
		protected var _listener:EventDispatcher;  
				
		public function WebServiceVO()
		{
			_listener = new EventDispatcher(this);  
		}
		
		public function send(name:String,listener:Function,...args):void
		{
			var webService:WebService = new WebService;
			webService.loadWSDL(BASE_WSDL + "Service.asmx?wsdl");
						
			var operation:Operation = webService.getOperation(name) as Operation;
			operation.addEventListener(ResultEvent.RESULT,onResult);
			operation.addEventListener(FaultEvent.FAULT,onFault);
			//operation.arguments = args;
			operation.resultFormat = "object";
			operation.send(args);	
						
			function onResult(event:ResultEvent):void
			{									
				if(event.result == null)
					return;
				
				if(event.result is ObjectProxy)
				{
					if(event.result.hasOwnProperty("Tables"))
					{
						var tables:Object = event.result.Tables;
						if(tables.hasOwnProperty("Table"))
						{
							listener(tables.Table.Rows);
						}
						if(tables.hasOwnProperty("Count"))
						{
							listener(tables.Count.Rows[0].Count);
						}
						else if(tables.hasOwnProperty("Error"))
						{							
							dispatchFault("404","后台服务错误",tables.Error.Rows[0]["ErrorInfo"]);
						}
					}
					else
					{
						listener(event.result);
					}
				}
				else //if(event.result is String)
				{
					listener(event.result);
				}
			}
			
			function onFault(event:FaultEvent):void
			{				
				dispatchFault(event.fault.faultCode,event.fault.faultString,event.fault.faultDetail);
			}
		}
				
		protected function dispatchFault(faultCode:String,faultString:String,faultDetail:String = null):void
		{
			var fault:Fault = new Fault(faultCode,faultString,faultDetail);
			dispatchEvent(FaultEvent.createEvent(fault));
		}
		
		public function hasEventListener(type:String):Boolean 
		{            
			return _listener.hasEventListener(type);        
		}               
		
		public function willTrigger(type:String):Boolean 
		{            
			return _listener.willTrigger(type);        
		}               
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean=false,priority:int=0.0, useWeakReference:Boolean=false):void        
		{            
			_listener.addEventListener(type, listener, useCapture,priority, useWeakReference);        
		}               
		
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void        
		{           
			_listener.removeEventListener(type, listener, useCapture);        
		}               
		
		public function dispatchEvent(event:Event):Boolean 
		{            
			return _listener.dispatchEvent(event);        
		} 
	}
}