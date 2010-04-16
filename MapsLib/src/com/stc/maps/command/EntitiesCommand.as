package com.stc.maps.command
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.stc.maps.business.EntitiesDelegate;
	import com.stc.maps.event.EntitiesEvent;
	import com.universalmind.cairngorm.commands.Command;
	
	public class EntitiesCommand extends Command
	{
		override public function execute(event:CairngormEvent) : void
		{
			super.execute(event);

            switch(event.type)
            {
				case EntitiesEvent.GET_ENTITY_LIST:
				{	
				    getEntitiesList(EntitiesEvent(event));
					break;
				}
                default : break;
            }
		}

		private function getEntitiesList(event : EntitiesEvent):void
		{
			var delegate : EntitiesDelegate = new EntitiesDelegate(this,"ParticipantService");

			delegate.getEntityList(event);
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