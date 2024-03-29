package com.stc.maps.command
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.stc.maps.business.CatalogDelegate;
	import com.stc.maps.event.CatalogEvent;
	import com.stc.maps.managers.CatalogManager;
	import com.stc.maps.vo.CatalogValueVO;
	import com.universalmind.cairngorm.commands.Command;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.events.FaultEvent;
	
	public class CatalogCommand extends Command
	{
		private var _event : CatalogEvent;
		private var catalogManager : CatalogManager = CatalogManager.getInstance();
		
		override public function execute(event:CairngormEvent) : void
		{
			super.execute(event);

			_event = event as CatalogEvent;
			
            switch(event.type)
            {
				case CatalogEvent.GET_CATALOG:
				{	
				    getCatalog(event as CatalogEvent);
					break;
				}
                default : break;
            }
		}

		private function getCatalog(event : CatalogEvent) : void
		{
			var delegate : CatalogDelegate = new CatalogDelegate(this,"ParticipantService");
			delegate.getCatalog(event);
		}

		override public function result(data : Object):void
		{
			var results : ArrayCollection = processCatalog(data.result as ArrayCollection);
			catalogManager.addCatalog(_event.keyName,results);
		}

		override public function fault(info : Object):void
		{
			Alert.show("Error obteniendo el catalogo"+info.message);
		}
		
		private function processCatalog(entitiesArray : ArrayCollection) : ArrayCollection
		{
			var results : ArrayCollection = new ArrayCollection;
			if(entitiesArray && entitiesArray.length>0)
			{
				for each(var obj : Object in entitiesArray)
				{
					var entity : CatalogValueVO = new CatalogValueVO();
					entity.id = obj.id;
					entity.label = obj.value;
					
					results.addItem(entity);
				}
				
			}
			
			return results;
		}
	}
}