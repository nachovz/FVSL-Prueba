package com.stc.maps.business
{
	import com.stc.maps.event.SearchEvent;
	import com.stc.maps.vo.CatalogValueVO;
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
		
		public function searchEntity(event : SearchEvent, params : ArrayCollection) : void
		{
            _service = ServiceLocator.getInstance().getWebService("EntitiesWS");
			var token:AsyncToken = this._service.getSearch(event.entityType,params);
			token.addResponder(this.responder);
		}
		
		public function searchNetwork(values : ArrayCollection) : void
		{
			//var pais : int = Number(getValueByName(values,CatalogValueVO.COUNTRIES).value);
			//var nombreNetwork : String = "%"+getValueByName(values,"name").value.toString()+"%";
			
            //_service = ServiceLocator.getInstance().getWebService("networkWS");
			//var token:AsyncToken = this._service.searchNetworks(nombreNetwork,pais);
			//token.addResponder(this.responder);
		}

		
	}
}