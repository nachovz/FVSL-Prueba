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

		override public function result(data : Object):void
		{
			var results : ArrayCollection;
			var entitiesArray : ArrayCollection;
			switch(_type)
			{
				case EntityVO.COOPERANT:
					 entitiesArray = data.result;
					 results = processCooperants(entitiesArray);
				break;
				case EntityVO.ODS:
					 entitiesArray = data.result;
					 results = processODS(entitiesArray);
				break;
				case EntityVO.NETWORK:
					 results = processNetworks(data.result);
				break;
			}
		
			
			var ev : ResultEvent = new ResultEvent(ResultEvent.RESULT,false,true,results);
			_event.callbacks.result(ev);
		}

		override public function fault(info : Object):void
		{
			//Alert.show("Login service not available. Try again later.");
		}
		
		private function processCooperants(entitiesArray : ArrayCollection) : ArrayCollection
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
						var entity : EntityVO = new EntityVO();
						entity.type = _type;
						entity.title = obj.name;
						
						entity.lat = Number(lat.replace(",", "."));
						entity.long = Number(long.replace(",", "."));
						
 						entity.direction = obj.direction;
						entity.webURL = obj.website;
						entity.objective = obj.objective;
						entity.phone = obj.phone;
						entity.email = obj.email; 
						
						results.addItem(entity);
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
						entity.type = _type;
						entity.title = obj.parent.name;
						
						entity.lat = Number(lat.replace(",", "."));
						entity.long = Number(long.replace(",", "."));
						
 						entity.direction = obj.parent.direction;
						entity.webURL = obj.parent.website;
						entity.objective = obj.parent.objective;
						entity.phone = obj.parent.phone;
						entity.email = obj.parent.email; 
						entity.nodes = getNodes(obj.nodes);
						
						results.addItem(entity);
					}
				}
				
			}
			
			return results;
		}
		
		private function getNodes(nodes : ArrayCollection) : ArrayCollection
		{
			var results : ArrayCollection = null;
			if(nodes && nodes.length>0)
			{
				results = new ArrayCollection();
				for each(var obj : Object in nodes)
				{
					var lat : String = obj.latitude.toString();
					var long : String = obj.longitude.toString();
					if(lat!="" && long !="")
					{
						var entity : EntityVO = new EntityVO();
						entity.type = obj.type;
						entity.title = obj.name;
						
						entity.lat = Number(lat.replace(",", "."));
						entity.long = Number(long.replace(",", "."));
						
						results.addItem(entity);
					}
				}
			}
			
			return results;
		}
		
		private function processODS(entitiesArray : ArrayCollection) : ArrayCollection
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
						var entity : EntityVO = new EntityVO();
						entity.type = _type;
						entity.title = obj.name;
						
						entity.lat = Number(lat.replace(",", "."));
						entity.long = Number(long.replace(",", "."));

						entity.direction = obj.direction;
						entity.webURL = obj.website;
						entity.objective = obj.objective;
						entity.phone = obj.phone;
						entity.email = obj.email;

						results.addItem(entity);
					}
				}
				
			}
			
			return results;
		}
	}
}