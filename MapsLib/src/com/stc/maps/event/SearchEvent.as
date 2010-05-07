package com.stc.maps.event
{
	import com.universalmind.cairngorm.events.UMEvent;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;
	
	public class SearchEvent extends UMEvent
	{
        // Eventos del ConfigurationService
        public static const SEARCH_ENTITY:String = "searchEntityEvent";
        public static const SEARCH_NETWORK:String = "searchNetworkEvent";

		public var filterVaues : ArrayCollection;
		public var entityType : String;
		public function SearchEvent(type:String,
		                          handlers:IResponder=null,
		                          bubbles:Boolean=true,cancelable:Boolean=false,
		                          data:Object=null)
		{
			super(type,handlers,bubbles,cancelable,data);

		}
	}
}