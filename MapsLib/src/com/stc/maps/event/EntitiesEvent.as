package com.stc.maps.event
{
	import com.universalmind.cairngorm.events.UMEvent;
	
	import mx.rpc.IResponder;
	
	public class EntitiesEvent extends UMEvent
	{
        // Eventos del ConfigurationService
        public static const GET_ENTITY_LIST:String = "getEntityListEvent";
        public static const GET_ENTITY_DETAILS:String = "getEntityDetailsEvent";
        public static const GET_NETWORK_DETAILS:String = "getNetworkDetailsEvent";

		public var entityType 	: String;
		public var entityId  	: String;
		public var entityOrg 	: String;
		public function EntitiesEvent(type:String,
		                          handlers:IResponder=null,
		                          bubbles:Boolean=true,cancelable:Boolean=false,
		                          data:Object=null)
		{
			super(type,handlers,bubbles,cancelable,data);

		}
	}
}