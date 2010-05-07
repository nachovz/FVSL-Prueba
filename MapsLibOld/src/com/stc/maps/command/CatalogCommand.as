package com.stc.maps.command
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.stc.maps.business.CatalogDelegate;
	import com.stc.maps.event.CatalogEvent;
	import com.stc.maps.managers.CatalogManager;
	import com.stc.maps.vo.FilterOptionVO;
	import com.universalmind.cairngorm.commands.Command;
	
	import mx.collections.ArrayCollection;
	
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

		private function getCatalog(event : CatalogEvent):void
		{
			var delegate : CatalogDelegate = new CatalogDelegate(this,"ParticipantService");

			switch(event.keyName)
			{
				case FilterOptionVO.COUNTRY:
					delegate.searchCountries(event);
				break;
				case FilterOptionVO.ORGANIZATION_TYPE:
					delegate.searchOrgType(event);
				break;
				case FilterOptionVO.FINANCY:
					delegate.searchFinancy(event);
				break;
				case FilterOptionVO.ENFOQUE_GEOGRAFICO:
					delegate.searchEnfoqueType(event);
				break;
				case FilterOptionVO.BENEFICIARIO:
					delegate.searchBeneficiaryType(event);
				break;
			}
		}

		override public function result(data : Object):void
		{
			var results : ArrayCollection = processCatalog(data.result as ArrayCollection);
			
			catalogManager.addCatalog(_event.keyName,results);
		}

		override public function fault(info : Object):void
		{
			//Alert.show("Login service not available. Try again later.");
		}
		
		private function processCatalog(entitiesArray : ArrayCollection) : ArrayCollection
		{
			var results : ArrayCollection = new ArrayCollection;
			if(entitiesArray && entitiesArray.length>0)
			{
				for each(var obj : Object in entitiesArray)
				{
					var entity : FilterOptionVO = new FilterOptionVO();
					entity.id = obj.id;
					entity.label = obj.value;
					
					results.addItem(entity);
				}
				
			}
			
			return results;
		}
	}
}