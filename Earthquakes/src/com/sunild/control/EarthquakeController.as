package com.sunild.control
{
	import com.adobe.cairngorm.control.FrontController;
	import com.sunild.commands.*;
	import com.sunild.events.*;

	public class EarthquakeController extends FrontController
	{
		public function EarthquakeController()
		{
			super();
			initializeCommands();
		}
		
		
		public function initializeCommands():void
		{
			this.addCommand(FetchDataEvent.FETCH_DATA, FetchDataCommand);
			this.addCommand(NewDataSourceEvent.NEW_DATA_SOURCE, NewDataSourceCommand);
		}
	}
}