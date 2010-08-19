package com.stc.maps.business
{
	import com.stc.maps.event.SearchEvent;
	import com.stc.maps.model.MapModel;
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
		
		public function searchEntity(event : SearchEvent, params : ArrayCollection, entityOrg : String) : void
		{
			if(entityOrg==MapModel.FVSL)
	            _service = ServiceLocator.getInstance().getWebService("EntitiesWS");
			if(entityOrg==MapModel.UR)
	            _service = ServiceLocator.getInstance().getWebService("EntitiesWSUR");

			var token:AsyncToken = this._service.getSearch(event.entityType,params);
			token.addResponder(this.responder);
		}
		
		public function searchNetwork(event : SearchEvent, params : ArrayCollection) : void
		{
            _service = ServiceLocator.getInstance().getWebService("networkWS");
			var token:AsyncToken = this._service.getSearch("all",params);
			token.addResponder(this.responder);
		}

		
	}
}