package com.stc.maps.business
{
	import com.stc.maps.event.CatalogEvent;
	import com.universalmind.cairngorm.business.Delegate;
	import com.universalmind.cairngorm.business.ServiceLocator;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.soap.WebService;
	
	public class CatalogDelegate extends Delegate
	{
		private var _service : WebService;
		public function CatalogDelegate(commandHandlers:IResponder, 
                                                          serviceName:String)
        {
            super(commandHandlers, serviceName);
        }
		
		public function getCatalog(event : CatalogEvent) : void
		{
            _service = ServiceLocator.getInstance().getWebService("catalogsWS");
			//var token:AsyncToken = this._service.getCatalog(event.keyName,-1);
			var token:AsyncToken = this._service.getCatalog("premio",-1);
			token.addResponder(this.responder);
		}
		
		public function searchFinancy(event : CatalogEvent) : void
		{
			var aux : ArrayCollection = new ArrayCollection();
			
			var auxOpt : Object = new Object();
			auxOpt.id = "1";
			auxOpt.value = "Si";
			aux.addItem(auxOpt);
			
			var auxOpt : Object = new Object();
			auxOpt.id = "0";
			auxOpt.value = "No";
			aux.addItem(auxOpt);

			var ev : ResultEvent = new ResultEvent(ResultEvent.RESULT,false,true,aux);
			this.responder.result(ev);
		}
		
	}
}