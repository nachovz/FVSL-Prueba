package com.stc.maps.command
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.stc.maps.business.SearchDelegate;
	import com.stc.maps.event.SearchEvent;
	import com.stc.maps.vo.EntityVO;
	import com.stc.maps.vo.NetworkVO;
	import com.universalmind.cairngorm.commands.Command;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.ResultEvent;
	
	public class SearchCommand extends Command
	{
		private var _event : CairngormEvent;
		private var _type : String;
		
		override public function execute(event:CairngormEvent) : void
		{
			super.execute(event);

			_event = event;
            switch(SearchEvent(event).entityType)
            {
				case EntityVO.NETWORK:
				    searchNetworks(SearchEvent(event));
				break;
				default:
				   	searchCooperants(SearchEvent(event));
				break;
            }
		}

		private function searchCooperants(event : SearchEvent):void
		{
			var delegate : SearchDelegate = new SearchDelegate(this,"ParticipantService");

			delegate.searchCooperant(event.filterVaues);
		}
		private function searchNetworks(event : SearchEvent):void
		{
			var delegate : SearchDelegate = new SearchDelegate(this,"ParticipantService");

			delegate.searchNetwork(event.filterVaues);
		}

		override public function result(data : Object):void
		{
			var results : ArrayCollection;
			var entitiesArray : ArrayCollection;
			switch(SearchEvent(_event).entityType)
			{
				case EntityVO.NETWORK:
					 entitiesArray = data.result;
					 _type = SearchEvent(_event).entityType;
					 results = processNetworks(entitiesArray);
				break;
				default:
					 entitiesArray = data.result;
					 _type = SearchEvent(_event).entityType;
					 results = processEntities(entitiesArray);
				break;
			}
		
			
			var ev : ResultEvent = new ResultEvent(ResultEvent.RESULT,false,true,results);
			SearchEvent(_event).callbacks.result(ev);
		}

		override public function fault(info : Object):void
		{
			//Alert.show("Login service not available. Try again later.");
		}
		
		private function processEntities(entitiesArray : ArrayCollection) : ArrayCollection
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
						entity.data = obj;
						entity.type = _type;
						
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
						entity.data = obj.parent;
						entity.type = EntityVO.NETWORK;
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