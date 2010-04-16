package com.sunild.commands
{
	import com.adobe.cairngorm.commands.SequenceCommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.sunild.events.FetchDataEvent;
	import com.sunild.events.NewDataSourceEvent;
	import com.sunild.model.EarthquakesModel;

	public class NewDataSourceCommand extends SequenceCommand
	{		
		public function NewDataSourceCommand()
		{
			super();
			this.nextEvent = new FetchDataEvent();			
		}
		
		override public function execute(event:CairngormEvent):void
		{			
			EarthquakesModel.getInstance().selectedUrl =
				(event as NewDataSourceEvent).sourceUrl;
				
			executeNextCommand();
		}
		
	}
}