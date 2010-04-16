package com.sunild.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import flash.events.Event;

	public class FetchDataEvent extends CairngormEvent
	{
		public static const FETCH_DATA:String = "fetchData";
		
		public function FetchDataEvent()
		{
			super(FETCH_DATA);
		}
		
		override public function clone():Event
		{
			return new FetchDataEvent();
		}
		
	}
}