package com.stc.maps.control
{
	import com.adobe.cairngorm.control.FrontController;
	import com.stc.maps.command.EntitiesCommand;
	import com.stc.maps.command.FiltersCommand;
	import com.stc.maps.event.EntitiesEvent;
	import com.stc.maps.event.FiltersEvent;
	
	public class MapsController extends FrontController
	{
		private static var controller : MapsController;
		
        public static function getInstance( ) : MapsController
        {
            if( controller == null )
            {
                controller = new MapsController( );
            }
            return controller;
        }
        
		public function MapsController()
		{
			addCommand( EntitiesEvent.GET_ENTITY_LIST, EntitiesCommand );
			addCommand( FiltersEvent.GET_FILTERS_LIST, FiltersCommand );
		}
		
	}
}