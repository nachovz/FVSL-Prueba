package com.stc.maps.business
{
	import com.stc.maps.event.CatalogEvent;
	import com.stc.maps.vo.CatalogValueVO;
	import com.stc.maps.vo.EntityVO;
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
			var token:AsyncToken = this._service.getCatalog(event.keyName,event.idDepentency);
			token.addResponder(this.responder);
		}
		
	}
}