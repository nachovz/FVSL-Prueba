package com.stc.maps.view.components.event
{
	import flash.events.Event;
	
	public class EntityRendererListEvent extends Event
	{
		public static const FOCUS_MAP_ITEM : String = "focusMapItemEvent";
		public static const ZOOM_SEARCH : String = "zoomSearchEvent";
		
		public var item : Object;
		public function EntityRendererListEvent(type:String)
		{
			super(type, true, true);
		}

	}
}