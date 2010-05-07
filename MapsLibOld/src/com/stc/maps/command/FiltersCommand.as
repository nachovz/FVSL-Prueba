package com.stc.maps.command
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.stc.maps.business.FiltersDelegate;
	import com.stc.maps.event.FiltersEvent;
	import com.universalmind.cairngorm.commands.Command;
	
	public class FiltersCommand extends Command
	{
		override public function execute(event:CairngormEvent) : void
		{
			super.execute(event);

            switch(event.type)
            {
				case FiltersEvent.GET_FILTERS_LIST:
				{	
				    getFiltersList(FiltersEvent(event));
					break;
				}
                default : break;
            }
		}

		private function getFiltersList(event : FiltersEvent):void
		{
			var delegate : FiltersDelegate = new FiltersDelegate(this,"ParticipantService");

			delegate.getFiltersList(event);
		}

		override public function result(data : Object):void
		{
			//notifyCaller(data);
			//Alert.show("Llego la respuesta del servicio getlogin...");
		}

		override public function fault(info : Object):void
		{
			//Alert.show("Login service not available. Try again later.");
		}
	}
}