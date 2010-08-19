package com.stc.maps.business
{
	import com.stc.maps.event.EntitiesEvent;
	import com.stc.maps.model.MapModel;
	import com.stc.maps.vo.EntityVO;
	import com.universalmind.cairngorm.business.Delegate;
	import com.universalmind.cairngorm.business.ServiceLocator;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.soap.WebService;
	
	public class EntitiesDelegate extends Delegate
	{
		private var _service : WebService;
		public function EntitiesDelegate(commandHandlers:IResponder, 
                                                          serviceName:String)
        {
            super(commandHandlers, serviceName);
        }
		
		public function getEntityList(event : EntitiesEvent ):void
		{
			var arrayEntities : ArrayCollection;
			
			switch(event.entityType)
			{
				case EntityVO.NETWORK:
					getAllNetworks(event.entityOrg);
				break;
				default:
					getAllEntities(event.entityType, event.entityOrg);
				break;
			}

			
			//var ev : ResultEvent = new ResultEvent(ResultEvent.RESULT,false,true,arrayEntities);
			//event.callbacks.result(ev);
		}
		
		public function getEntity(event : EntitiesEvent ):void
		{
			var arrayEntities : ArrayCollection;
			getDetails(event.entityType, parseInt(event.entityId) , event.entityOrg);
			
			//var ev : ResultEvent = new ResultEvent(ResultEvent.RESULT,false,true,arrayEntities);
			//event.callbacks.result(ev);
		}
		
		public function getNetworkEntity(event : EntitiesEvent):void
		{
			var arrayEntities : ArrayCollection;
			getNetworkDetails(event.entityType, parseInt(event.entityId), event.entityOrg);
			
			//var ev : ResultEvent = new ResultEvent(ResultEvent.RESULT,false,true,arrayEntities);
			//event.callbacks.result(ev);
		}
		
		
		private function getAllEntities(type : String, entityOrg : String) : void
		{
			if(entityOrg==MapModel.FVSL)
	            _service = ServiceLocator.getInstance().getWebService("EntitiesWS");
			if(entityOrg==MapModel.UR)
	            _service = ServiceLocator.getInstance().getWebService("EntitiesWSUR");

			var token:AsyncToken = this._service.getAll(type);
			token.addResponder(this.responder);
		}
		
		private function getDetails(type : String, id : int, entityOrg : String) : void
		{
			if(entityOrg==MapModel.FVSL)
	            _service = ServiceLocator.getInstance().getWebService("EntitiesWS");
			if(entityOrg==MapModel.UR)
	            _service = ServiceLocator.getInstance().getWebService("EntitiesWSUR");

			var token:AsyncToken = this._service.getDetails(type,id);
			token.addResponder(this.responder);
		}
		
		private function getNetworkDetails(type : String, id : int, entityOrg : String) : void
		{
			if(entityOrg==MapModel.FVSL)
	            _service = ServiceLocator.getInstance().getWebService("networkWS");
			if(entityOrg==MapModel.UR)
	            _service = ServiceLocator.getInstance().getWebService("networkWSUR");

			var token:AsyncToken = this._service.getDetails(type,id);
			token.addResponder(this.responder);
		}

		private function getAllNetworks(entityOrg : String) : void
		{
			if(entityOrg==MapModel.FVSL)
	            _service = ServiceLocator.getInstance().getWebService("networkWS");
			if(entityOrg==MapModel.UR)
	            _service = ServiceLocator.getInstance().getWebService("networkWSUR");
	            
			var token:AsyncToken = this._service.getN("all");
			token.addResponder(this.responder);
		}

	}
}