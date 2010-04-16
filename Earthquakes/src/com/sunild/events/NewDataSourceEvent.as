package com.sunild.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import flash.events.Event;

	public class NewDataSourceEvent extends CairngormEvent
	{
		public static const NEW_DATA_SOURCE:String = "newDataSource";
		
		public var sourceUrl:String;
		
		public function NewDataSourceEvent()
		{
			super(NEW_DATA_SOURCE);
		}
		
		override public function clone():Event
		{
			var e:NewDataSourceEvent = new NewDataSourceEvent();
			e.sourceUrl = sourceUrl;
			return e;
		}
		
	}
}