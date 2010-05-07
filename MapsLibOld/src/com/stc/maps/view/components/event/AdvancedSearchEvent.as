package com.stc.maps.view.components.event
{
	import mx.collections.ArrayCollection;
	import flash.events.Event;
	
	public class AdvancedSearchEvent extends Event
	{
		public static const SEARCH : String = "searchFilterValuesEvent";
		
		public var searchFilterValues : ArrayCollection;
		public function AdvancedSearchEvent(type:String)
		{
			super(type, true, true);
		}

	}
}