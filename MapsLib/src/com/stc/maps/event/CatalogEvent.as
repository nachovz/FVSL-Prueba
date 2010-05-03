package com.stc.maps.event
{
	import com.universalmind.cairngorm.events.UMEvent;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;
	
	public class CatalogEvent extends UMEvent
	{
        // Eventos del ConfigurationService
        public static const GET_CATALOG:String = "getCatalogEvent";

		public var keyName : String;
		public var dataProvider : ArrayCollection;
		public function CatalogEvent(type:String,
		                          handlers:IResponder=null,
		                          bubbles:Boolean=true,cancelable:Boolean=false,
		                          data:Object=null)
		{
			super(type,handlers,bubbles,cancelable,data);

		}
	}
}