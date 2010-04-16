package com.stc.maps.business
{
	import com.stc.maps.event.FiltersEvent;
	import com.stc.maps.vo.EntityVO;
	import com.stc.maps.vo.FilterOptionVO;
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
					arrayEntities = null;
				break;
				case EntityVO.ODS:
					arrayEntities = null;
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
			aux.keyName = "country";
			aux.label = "Pais";
			aux.options = new ArrayCollection();
			
			var auxOpt : FilterOptionVO = new FilterOptionVO();
			auxOpt.id = 1;
			auxOpt.label = "Venezuela";
			aux.options.addItem(auxOpt);
			var auxOpt : FilterOptionVO = new FilterOptionVO();
			auxOpt.id = 2;
			auxOpt.label = "Brazil";
			aux.options.addItem(auxOpt);
			
			arrayFilters.addItem(aux);
			
			var aux : FilterVO = new FilterVO();
			aux.id = 1;
			aux.type = FilterVO.TEXT;
			aux.keyName = "name";
			aux.label = "Nombre";
			arrayFilters.addItem(aux);
			
			var aux : FilterVO = new FilterVO();
			aux.id = 1;
			aux.type = FilterVO.MULTIPLE;
			aux.keyName = "theme";
			aux.label = "Tematica";
			aux.options = new ArrayCollection();
			
			var auxOpt : FilterOptionVO = new FilterOptionVO();
			auxOpt.id = 1;
			auxOpt.label = "Drogas";
			aux.options.addItem(auxOpt);
			var auxOpt : FilterOptionVO = new FilterOptionVO();
			auxOpt.id = 2;
			auxOpt.label = "Huerfanos";
			aux.options.addItem(auxOpt);
			var auxOpt : FilterOptionVO = new FilterOptionVO();
			auxOpt.id = 2;
			auxOpt.label = "Diversidad de generos";
			aux.options.addItem(auxOpt);
			
			arrayFilters.addItem(aux);
			
			var aux : FilterVO = new FilterVO();
			aux.id = 1;
			aux.type = FilterVO.COMBO;
			aux.keyName = "organization_type";
			aux.label = "Tipo de organizacion";
			aux.options = new ArrayCollection();
			
			var auxOpt : FilterOptionVO = new FilterOptionVO();
			auxOpt.id = 1;
			auxOpt.label = "ONG";
			aux.options.addItem(auxOpt);
			var auxOpt : FilterOptionVO = new FilterOptionVO();
			auxOpt.id = 2;
			auxOpt.label = "Fundacion";
			aux.options.addItem(auxOpt);

			arrayFilters.addItem(aux);
			
			var aux : FilterVO = new FilterVO();
			aux.id = 1;
			aux.type = FilterVO.BOOLEAN;
			aux.keyName = "financiamiento";
			aux.label = "Financiamiento a terceros";
			arrayFilters.addItem(aux);
			
			var aux : FilterVO = new FilterVO();
			aux.id = 1;
			aux.type = FilterVO.COMBO;
			aux.keyName = "geografy";
			aux.label = "Enfoque geografico";
			aux.options = new ArrayCollection();
			
			var auxOpt : FilterOptionVO = new FilterOptionVO();
			auxOpt.id = 1;
			auxOpt.label = "Latinoamerica";
			aux.options.addItem(auxOpt);
			var auxOpt : FilterOptionVO = new FilterOptionVO();
			auxOpt.id = 2;
			auxOpt.label = "Norteamerica";
			aux.options.addItem(auxOpt);
			
			arrayFilters.addItem(aux);
			
			var aux : FilterVO = new FilterVO();
			aux.id = 1;
			aux.type = FilterVO.MULTIPLE;
			aux.keyName = "poblation_interest";
			aux.label = "Poblacion de Interes";
			aux.options = new ArrayCollection();
			
			var auxOpt : FilterOptionVO = new FilterOptionVO();
			auxOpt.id = 1;
			auxOpt.label = "Niños";
			aux.options.addItem(auxOpt);
			var auxOpt : FilterOptionVO = new FilterOptionVO();
			auxOpt.id = 2;
			auxOpt.label = "Adolescentes";
			aux.options.addItem(auxOpt);
			var auxOpt : FilterOptionVO = new FilterOptionVO();
			auxOpt.id = 3;
			auxOpt.label = "Mujeres";
			aux.options.addItem(auxOpt);
			var auxOpt : FilterOptionVO = new FilterOptionVO();
			auxOpt.id = 4;
			auxOpt.label = "Ancianos";
			aux.options.addItem(auxOpt);
			
			arrayFilters.addItem(aux);

			
			return arrayFilters;
		}
		
		private function networkFilters() : ArrayCollection
		{
			var arrayFilters : ArrayCollection = new ArrayCollection();
			
			var aux : FilterVO = new FilterVO();
			aux.id = 1;
			aux.type = FilterVO.COMBO;
			aux.keyName = "country";
			aux.label = "Pais";
			aux.options = new ArrayCollection();
			
			var auxOpt : FilterOptionVO = new FilterOptionVO();
			auxOpt.id = 1;
			auxOpt.label = "Venezuela";
			aux.options.addItem(auxOpt);
			var auxOpt : FilterOptionVO = new FilterOptionVO();
			auxOpt.id = 2;
			auxOpt.label = "Brazil";
			aux.options.addItem(auxOpt);
			
			arrayFilters.addItem(aux);
			
			var aux : FilterVO = new FilterVO();
			aux.id = 1;
			aux.type = FilterVO.TEXT;
			aux.keyName = "name";
			aux.label = "Nombre";
			arrayFilters.addItem(aux);
			
			var aux : FilterVO = new FilterVO();
			aux.id = 1;
			aux.type = FilterVO.MULTIPLE;
			aux.keyName = "givenawards";
			aux.label = "Premios Otorgados";
			aux.options = new ArrayCollection();
			
			var auxOpt : FilterOptionVO = new FilterOptionVO();
			auxOpt.id = 1;
			auxOpt.label = "premio 1";
			aux.options.addItem(auxOpt);
			var auxOpt : FilterOptionVO = new FilterOptionVO();
			auxOpt.id = 2;
			auxOpt.label = "premio 2";
			aux.options.addItem(auxOpt);
			var auxOpt : FilterOptionVO = new FilterOptionVO();
			auxOpt.id = 2;
			auxOpt.label = "premio 3";
			aux.options.addItem(auxOpt);
			
			arrayFilters.addItem(aux);
			
			var aux : FilterVO = new FilterVO();
			aux.id = 1;
			aux.type = FilterVO.MULTIPLE;
			aux.keyName = "grantedawards";
			aux.label = "Premios Recividos";
			aux.options = new ArrayCollection();
			
			var auxOpt : FilterOptionVO = new FilterOptionVO();
			auxOpt.id = 1;
			auxOpt.label = "premio 1";
			aux.options.addItem(auxOpt);
			var auxOpt : FilterOptionVO = new FilterOptionVO();
			auxOpt.id = 2;
			auxOpt.label = "premio 2";
			aux.options.addItem(auxOpt);
			var auxOpt : FilterOptionVO = new FilterOptionVO();
			auxOpt.id = 2;
			auxOpt.label = "premio 3";
			aux.options.addItem(auxOpt);
			
			arrayFilters.addItem(aux);
			
			var aux : FilterVO = new FilterVO();
			aux.id = 1;
			aux.type = FilterVO.MULTIPLE;
			aux.keyName = "beneficiary";
			aux.label = "Beneficiarios";
			aux.options = new ArrayCollection();
			
			var auxOpt : FilterOptionVO = new FilterOptionVO();
			auxOpt.id = 1;
			auxOpt.label = "Niños";
			aux.options.addItem(auxOpt);
			var auxOpt : FilterOptionVO = new FilterOptionVO();
			auxOpt.id = 2;
			auxOpt.label = "Adolescentes";
			aux.options.addItem(auxOpt);

			arrayFilters.addItem(aux);
			
			var aux : FilterVO = new FilterVO();
			aux.id = 1;
			aux.type = FilterVO.BOOLEAN;
			aux.keyName = "vilnerability";
			aux.label = "Situacion de vulnerabilidad";
			arrayFilters.addItem(aux);
			
			var aux : FilterVO = new FilterVO();
			aux.id = 1;
			aux.type = FilterVO.COMBO;
			aux.keyName = "interventionArea";
			aux.label = "Area de Intervencion";
			aux.options = new ArrayCollection();
			
			var auxOpt : FilterOptionVO = new FilterOptionVO();
			auxOpt.id = 1;
			auxOpt.label = "Latinoamerica";
			aux.options.addItem(auxOpt);
			var auxOpt : FilterOptionVO = new FilterOptionVO();
			auxOpt.id = 2;
			auxOpt.label = "Norteamerica";
			aux.options.addItem(auxOpt);
			
			arrayFilters.addItem(aux);
			
			return arrayFilters;
		}
	}
}