package com.stc.smaps.view.components
{
	import flash.events.Event;

	public class RenderLayersEvent extends Event
	{
		public static const ADD_LAYER : String = "addLayerEvent";
		public static const REMOVE_LAYER : String = "removeLayerEvent";
		public var red : String = "none";
		
		public function RenderLayersEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}