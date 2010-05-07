package com.stc.maps.command
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.stc.maps.business.EntitiesDelegate;
	import com.stc.maps.event.EntitiesEvent;
	import com.stc.maps.vo.EntityVO;
	import com.stc.maps.vo.NetworkVO;
	import com.universalmind.cairngorm.commands.Command;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	
	public class EntitiesCommand extends Command
	{
		private var _responder : IResponder;
		private var _type : String;
		private var _event : EntitiesEvent;
		private var getDetailsHandlers : mx.rpc.Responder = new mx.rpc.Responder(getDetailsResult, getDetailsFault);
		
		override public function execute(event:CairngormEvent) : void
		{
			super.execute(event);

            switch(event.type)
            {
				case EntitiesEvent.GET_ENTITY_LIST:
				{	
				    getEntitiesList(EntitiesEvent(event));
					break;
				}
				case EntitiesEvent.GET_ENTITY_DETAILS:
				{	
				    getEntityDetails(EntitiesEvent(event));
					break;
				}
                default : break;
            }
		}

		private function getEntitiesList(event : EntitiesEvent):void
		{
			var delegate : EntitiesDelegate = new EntitiesDelegate(this,"ParticipantService");
			_responder = event.callbacks
			_type = event.entityType;
			_event = event;
			delegate.getEntityList(event);
		}

		private function getEntityDetails(event : EntitiesEvent):void
		{
			var delegate : EntitiesDelegate = new EntitiesDelegate(getDetailsHandlers,"ParticipantService");
			_responder = event.callbacks
			_type = event.entityType;
			_event = event;
			delegate.getEntityDetails(event);
		}

		private function getDetailsResult(data : Object):void
		{
			var result : EntityVO = new EntityVO();
			result.data = data.result;
			
			var ev : ResultEvent = new ResultEvent(ResultEvent.RESULT,false,true,result);
			_event.callbacks.result(ev);
		}

		override public function result(data : Object):void
		{
			var results : ArrayCollection;
			var entitiesArray : ArrayCollection;
			switch(_type)
			{
				case EntityVO.NETWORK:
					 results = processNetworks(data.result);
				break;
				default:
					 entitiesArray = data.result;
					 results = processEntitys(entitiesArray);
				break;
			}
		
			
			var ev : ResultEvent = new ResultEvent(ResultEvent.RESULT,false,true,results);
			_event.callbacks.result(ev);
		}

		override public function fault(info : Object):void
		{
			//Alert.show("Login service not available. Try again later.");
		}

		private function getDetailsFault(info : Object):void
		{
			//Alert.show("Login service not available. Try again later.");
		}
		
		private function processEntitys(entitiesArray : ArrayCollection) : ArrayCollection
		{
			var results : ArrayCollection = null;
			if(entitiesArray && entitiesArray.length>0)
			{
				results = new ArrayCollection();
				for each(var obj : Object in entitiesArray)
				{
					var lat : String = obj.latitude.toString();
					var long : String = obj.longitude.toString();
					if(lat!="" && long !="")
					{
						var entity : EntityVO = new EntityVO()
						entity.data = obj;
						entity.type = _type;
						if(entity.id!=0) results.addItem(entity);
					}
				}
				
			}
			
			return results;
		}
		
		private function processNetworks(entitiesArray : ArrayCollection) : ArrayCollection
		{
			var results : ArrayCollection = null;
			if(entitiesArray && entitiesArray.length>0)
			{
				results = new ArrayCollection();
				for each(var obj : Object in entitiesArray)
				{
					var lat : String = obj.parent.latitude.toString();
					var long : String = obj.parent.longitude.toString();
					if(lat!="" && long !="")
					{
						var entity : NetworkVO = new NetworkVO();
						entity.data = obj.parent;
						entity.type = _type;
						entity.parentType = obj.parent.type;
						entity.setNodesObjects(obj.nodes);
						
						results.addItem(entity);
					}
				}
				
			}
			
			return results;
		}

	}
}