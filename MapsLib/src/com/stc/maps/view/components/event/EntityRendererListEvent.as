package com.stc.maps.view.components.event
{
	import flash.events.Event;
	
	public class EntityRendererListEvent extends Event
	{
		public static const FOCUS_MAP_ITEM : String = "focusMapItemEvent";
		
		public var item : Object;
		public function EntityRendererListEvent(type:String)
		{
			super(type, true, true);
		}

	}
}