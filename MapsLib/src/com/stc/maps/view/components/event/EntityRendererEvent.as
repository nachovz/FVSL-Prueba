package com.stc.maps.view.components.event
{
	import mx.collections.ArrayCollection;
	import flash.events.Event;
	
	public class EntityRendererEvent extends Event
	{
		public static const SHOW_ITEM : String = "showItemOnMap";
		public static const HIDE_ITEM : String = "hideItemOfMap";
		public static const SHOW_ITEMS_GROUP : String = "showItemsGroupOnMap";
		public static const SHOW_NETWORK : String = "showNetworkOnMap";
		public static const HIDE_NETWORK : String = "hideNetworkOnMap";
		public static const EXPAND_NETWORK : String = "expandNetworkOnMap";
		public static const COLLAPSE_NETWORK : String = "collapseNetworkOnMap";
		
		public var items : ArrayCollection;
		public var item : Object;
		public var network : Object;
		
		public function EntityRendererEvent(type:String)
		{
			super(type, true, true);
		}

	}
}