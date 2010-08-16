package com.stc.maps.view.components.event
{
	import mx.collections.ArrayCollection;
	import flash.events.Event;
	
	public class MultiselectSelectionEvent extends Event
	{
		public static const SELECT_ITEM : String = "selectItemEvent";
		public static const DESELECT_ITEM : String = "deselectItemEvent";
		
		public var items : ArrayCollection;
		public var item : Object;
		
		public function MultiselectSelectionEvent(type:String)
		{
			super(type, true, true);
		}

	}
}