package com.stc.maps.managers
{
 	import com.adobe.cairngorm.model.IModelLocator;
 	import com.stc.maps.event.CatalogEvent;
 	
 	import mx.collections.ArrayCollection;
 	import flash.utils.Dictionary;
/*  	import flash.utils.Dictionary; */


 	[Bindable]
	public class CatalogManager implements com.adobe.cairngorm.model.IModelLocator
	{
		private static var catalogManager : com.stc.maps.managers.CatalogManager;
		private var catalogs : Dictionary = new Dictionary();
		//private var catalogHandlers : mx.rpc.Responder = new mx.rpc.Responder(catalogResult, catalogFault);
		
		public static function getInstance() : com.stc.maps.managers.CatalogManager
		{
			if ( catalogManager == null )
				catalogManager = new com.stc.maps.managers.CatalogManager();
				
			return catalogManager;
	   }
	   
	   	public function CatalogManager() 
	   	{
	   		if ( CatalogManager.catalogManager != null )
					throw new Error( "Only one CatalogManager instance should be instantiated" );	
	   	}
	   	
	   	public function getCatalog(keyName : String, idDepende : Number=-1, entityName : String='') : ArrayCollection
	   	{
	   		if(!catalogs[keyName] || idDepende>-1)
	   		{
	   			catalogs[keyName] = new ArrayCollection();
	   			
	   			var event : CatalogEvent = new CatalogEvent(CatalogEvent.GET_CATALOG);
	   			event.dataProvider = catalogs[keyName];
	   			event.keyName = keyName;
	   			event.idDepentency = idDepende.toString();
	   			event.entityName = entityName;
	   			event.dispatch();
	   		}
	   		
	   		return catalogs[keyName];
	   	}
	   	
	   	public function addCatalog(keyName : String, values : ArrayCollection) : void
	   	{
	   		if(values && values.length>0)
	   		{
		   		var catalog : ArrayCollection;
		   		if(!catalogs[keyName])
		   		{
		   			catalog = new ArrayCollection();
		   			catalogs[keyName] = catalog;
		   		}
		   		else
		   		{
		   			catalog = catalogs[keyName] as ArrayCollection;
		   			catalog.removeAll();
		   		}
		   		
		   		catalog.source = values.source;
		   		catalog.refresh();
		   	}
	   	}
		
		
	}	
}

