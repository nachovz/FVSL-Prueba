package com.stc.maps.control
{
	import com.adobe.cairngorm.control.FrontController;
	import com.stc.maps.command.CatalogCommand;
	import com.stc.maps.command.EntitiesCommand;
	import com.stc.maps.command.FiltersCommand;
	import com.stc.maps.command.SearchCommand;
	import com.stc.maps.event.CatalogEvent;
	import com.stc.maps.event.EntitiesEvent;
	import com.stc.maps.event.FiltersEvent;
	import com.stc.maps.event.SearchEvent;
	
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
			addCommand( EntitiesEvent.GET_ENTITY_DETAILS, EntitiesCommand );
			addCommand( EntitiesEvent.GET_NETWORK_DETAILS, EntitiesCommand );
			addCommand( FiltersEvent.GET_FILTERS_LIST, FiltersCommand );
			addCommand( SearchEvent.SEARCH_ENTITY, SearchCommand );
			addCommand( CatalogEvent.GET_CATALOG, CatalogCommand );
		}
		
	}
}