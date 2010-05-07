package com.stc.maps.business
{
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
		
		public function searchCooperant(values : ArrayCollection) : void
		{
			var pais : int = Number(getValueByName(values,FilterOptionVO.COUNTRY).value);
			var nombreCoop : String = "%"+getValueByName(values,"name").value.toString()+"%";
			var orgType : int = Number(getValueByName(values,FilterOptionVO.ORGANIZATION_TYPE).value);
			var financiamiento : int = Number(getValueByName(values,FilterOptionVO.FINANCY).value);
			var enfoque : int = Number(getValueByName(values,FilterOptionVO.ENFOQUE_GEOGRAFICO).value);
			
            _service = ServiceLocator.getInstance().getWebService("cooperantsWS");
			var token:AsyncToken = this._service.searchCooperants(pais,nombreCoop,orgType,financiamiento,enfoque);
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