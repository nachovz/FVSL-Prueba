package com.stc.maps.business
{
	import com.stc.maps.event.SearchEvent;
	import com.stc.maps.vo.FilterOptionVO;
	import com.stc.maps.vo.FilterValueVO;
	import com.universalmind.cairngorm.business.Delegate;
	import com.universalmind.cairngorm.business.ServiceLocator;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.soap.WebService;
	
	public class SearchDelegate extends Delegate
	{
		private var _service : WebService;
		public function SearchDelegate(commandHandlers:IResponder, 
                                                          serviceName:String)
        {
            super(commandHandlers, serviceName);
        }
		
		public function searchEntity(event : SearchEvent) : void
		{
			var values : ArrayCollection = event.filterVaues;
			var array : Array = [];
			//enfoque
			//array[0] = Number(getValueByName(values,FilterOptionVO.ENFOQUE_GEOGRAFICO).value);
			array[0] = 3;
			//estado
			//array[1] = -1;
			array[1] = 264;
			//anombreCoop
			//array[2] = getValueByName(values,"name").value.toString();
			array[2] = "is";
			//area
			//array[3] = "";
			array[3] = "1";
			//premios
			//array[4] = "";
			array[4] = "Premio Verde";
			//orgType
			//array[5] = Number(getValueByName(values,FilterOptionVO.ORGANIZATION_TYPE).value);
			array[5] = 1;
			//financiamiento
			//array[6] = Number(getValueByName(values,FilterOptionVO.FINANCY).value);
			array[6] = 0;
			//pais
			array[7] = Number(getValueByName(values,FilterOptionVO.COUNTRY).value);

			var params : ArrayCollection = new ArrayCollection(array);
			
            _service = ServiceLocator.getInstance().getWebService("EntitiesWS");
			var token:AsyncToken = this._service.getSearch(event.entityType,params);
			token.addResponder(this.responder);
		}
		
		public function searchNetwork(values : ArrayCollection) : void
		{
			var pais : int = Number(getValueByName(values,FilterOptionVO.COUNTRY).value);
			var nombreNetwork : String = "%"+getValueByName(values,"name").value.toString()+"%";
			
            _service = ServiceLocator.getInstance().getWebService("networkWS");
			var token:AsyncToken = this._service.searchNetworks(nombreNetwork,pais);
			token.addResponder(this.responder);
		}
		
		private function getValueByName(values : ArrayCollection,name : String) : FilterValueVO
		{
			for(var i : int = 0;i<values.length;i++)
			{
				var filter : FilterValueVO = values.getItemAt(i) as FilterValueVO;
				if(filter.name==name) return filter;
			}
			
			return null;
		}
		
	}
}