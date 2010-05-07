package com.stc.maps.event
{
	import com.universalmind.cairngorm.events.UMEvent;
	
	import mx.rpc.IResponder;
	
	public class FiltersEvent extends UMEvent
	{
        // Eventos del ConfigurationService
        public static const GET_FILTERS_LIST:String = "getEntityFiltersEvent";

		public var entityType : String;
		public function FiltersEvent(type:String,
		                          handlers:IResponder=null,
		                          bubbles:Boolean=true,cancelable:Boolean=false,
		                          data:Object=null)
		{
			super(type,handlers,bubbles,cancelable,data);

		}
	}
}