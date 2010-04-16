package com.sunild.events
{
	import flash.events.Event;

	public class MapControlsEvent extends Event
	{
		public static const TOGGLE_ITEM:String = "toggleItem";
		public static const DATA_SOURCE_CHANGE:String = "dataSourceChange";
		public static const GRADIENT_CHANGE:String = "gradientChange";
		public static const GEOCODE_ADDRESS:String = "geocodeAddress";
		
		public var toggleName:String;
		public var sourceUrl:String;
		public var gradient:Array;
		public var address:String;
		
		public function MapControlsEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type);
		}
		
		override public function clone():Event
		{
			var e:MapControlsEvent = new MapControlsEvent(type);
			e.toggleName = toggleName;
			e.sourceUrl = sourceUrl;
			e.gradient = gradient;
			e.address = address;
			return e;
		}
		
	}
}