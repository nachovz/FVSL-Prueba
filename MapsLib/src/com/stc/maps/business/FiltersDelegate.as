package com.stc.maps.business
{
	import com.stc.maps.event.FiltersEvent;
	import com.stc.maps.vo.CatalogValueVO;
	import com.stc.maps.vo.EntityVO;
	import com.stc.maps.vo.FilterVO;
	import com.universalmind.cairngorm.business.Delegate;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	
	public class FiltersDelegate extends Delegate
	{
		public function FiltersDelegate(commandHandlers:IResponder, 
                                                          serviceName:String)
        {
            super(commandHandlers, serviceName);
        }
		
		public function getFiltersList(event : FiltersEvent ):void
		{
			var arrayEntities : ArrayCollection;
			
			switch(event.entityType)
			{
				case EntityVO.COOPERANT:
					arrayEntities = cooperantFilters();
				break;
				case EntityVO.COMPANY:
					arrayEntities = companyFilters();
				break;
				case EntityVO.ODS:
					arrayEntities = odsFilters();
				break;
				case EntityVO.NETWORK:
					arrayEntities = networkFilters();
				break;
			}

			
			var ev : ResultEvent = new ResultEvent(ResultEvent.RESULT,false,true,arrayEntities);
			event.callbacks.result(ev);
		}
		
		private function cooperantFilters() : ArrayCollection
		{
			var arrayFilters : ArrayCollection = new ArrayCollection();
			
			var aux : FilterVO = new FilterVO();
			aux.id = 1;
			aux.type = FilterVO.COMBO;
			aux.keyName = CatalogValueVO.COUNTRIES;
			aux.label = "Pais";
			arrayFilters.addItem(aux);
			
			aux = new FilterVO();
			aux.id = 1;
			aux.type = FilterVO.COMBO;
			aux.keyName = CatalogValueVO.STATES;
			aux.label = "Estado";
			arrayFilters.addItem(aux);
			
			aux = new FilterVO();
			aux.id = 1;
			aux.type = FilterVO.TEXT;
			aux.keyName = "name";
			aux.label = "Nombre";
			arrayFilters.addItem(aux);
			
			aux = new FilterVO();
			aux.id = 1;
			aux.type = FilterVO.MULTIPLE;
			aux.keyName = CatalogValueVO.AREAS;
			aux.label = "Areas de intervencion";
			arrayFilters.addItem(aux);
			
			aux = new FilterVO();
			aux.id = 1;
			aux.type = FilterVO.MULTIPLE;
			aux.keyName = CatalogValueVO.AWARDS;
			aux.idDepentency = 3;
			aux.label = "Premios";
			arrayFilters.addItem(aux);
			
			aux = new FilterVO();
			aux.id = 1;
			aux.type = FilterVO.COMBO;
			aux.keyName = CatalogValueVO.ORGANIZATION_TYPE;
			aux.label = "Tipo de organizacion";
			arrayFilters.addItem(aux);

			aux = new FilterVO();
			aux.id = 1;
			aux.type = FilterVO.YESNO;
			aux.keyName = CatalogValueVO.FINANCY;
			aux.label = "Financiamiento a terceros";
			arrayFilters.addItem(aux);

			aux = new FilterVO();
			aux.id = 1;
			aux.type = FilterVO.COMBO;
			aux.keyName = CatalogValueVO.APPROACHES;
			aux.label = "Enfoque geografico";
			arrayFilters.addItem(aux);
			
			return arrayFilters;
		}
		
		private function odsFilters() : ArrayCollection
		{
			var arrayFilters : ArrayCollection = new ArrayCollection();
			
			var aux : FilterVO = new FilterVO();
			aux.id = 1;
			aux.type = FilterVO.COMBO;
			aux.keyName = CatalogValueVO.COUNTRIES;
			aux.label = "Pais";
			arrayFilters.addItem(aux);
			
			aux = new FilterVO();
			aux.id = 1;
			aux.type = FilterVO.COMBO;
			aux.keyName = CatalogValueVO.STATES;
			aux.label = "Estado";
			arrayFilters.addItem(aux);
			
			aux = new FilterVO();
			aux.id = 1;
			aux.type = FilterVO.TEXT;
			aux.keyName = "name";
			aux.label = "Nombre";
			arrayFilters.addItem(aux);
			
			aux = new FilterVO();
			aux.id = 1;
			aux.type = FilterVO.MULTIPLE;
			aux.keyName = CatalogValueVO.AREAS;
			aux.label = "Areas de intervencion";
			arrayFilters.addItem(aux);
			
			aux = new FilterVO();
			aux.id = 1;
			aux.type = FilterVO.MULTIPLE;
			aux.keyName = CatalogValueVO.AWARDS;
			aux.idDepentency = 2;
			aux.label = "Premios";
			arrayFilters.addItem(aux);
			
			return arrayFilters;
		}
		
		private function companyFilters() : ArrayCollection
		{
			var arrayFilters : ArrayCollection = new ArrayCollection();
			
			var aux : FilterVO = new FilterVO();
			aux.id = 1;
			aux.type = FilterVO.COMBO;
			aux.keyName = CatalogValueVO.COUNTRIES;
			aux.label = "Pais";
			arrayFilters.addItem(aux);
			
			aux = new FilterVO();
			aux.id = 1;
			aux.type = FilterVO.COMBO;
			aux.keyName = CatalogValueVO.STATES;
			aux.label = "Estado";
			arrayFilters.addItem(aux);
			
			aux = new FilterVO();
			aux.id = 1;
			aux.type = FilterVO.TEXT;
			aux.keyName = "name";
			aux.label = "Nombre";
			arrayFilters.addItem(aux);		

			aux = new FilterVO();
			aux.id = 1;
			aux.type = FilterVO.YESNO;
			aux.keyName = CatalogValueVO.FINANCY;
			aux.label = "Financiamiento a terceros";
			arrayFilters.addItem(aux);	

			aux = new FilterVO();
			aux.id = 1;
			aux.type = FilterVO.COMBO;
			aux.keyName = CatalogValueVO.APPROACHES;
			aux.label = "Enfoque geografico";
			arrayFilters.addItem(aux);
			
			return arrayFilters;
		}
		
		private function networkFilters() : ArrayCollection
		{
			var arrayFilters : ArrayCollection = new ArrayCollection();
			
			var aux : FilterVO = new FilterVO();
			aux.id = 1;
			aux.type = FilterVO.COMBO;
			aux.keyName = CatalogValueVO.COUNTRIES;
			aux.label = "Pais";
			arrayFilters.addItem(aux);
			
			aux = new FilterVO();
			aux.id = 1;
			aux.type = FilterVO.COMBO;
			aux.keyName = CatalogValueVO.STATES;
			aux.label = "Estado";
			arrayFilters.addItem(aux);
			
			aux = new FilterVO();
			aux.id = 1;
			aux.type = FilterVO.TEXT;
			aux.keyName = "name";
			aux.label = "Nombre";
			arrayFilters.addItem(aux);
			
			return arrayFilters;
		}
	}
}