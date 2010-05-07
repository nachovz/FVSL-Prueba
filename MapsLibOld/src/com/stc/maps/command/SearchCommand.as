package com.stc.maps.command
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.stc.maps.business.SearchDelegate;
	import com.stc.maps.event.SearchEvent;
	import com.stc.maps.vo.EntityVO;
	import com.universalmind.cairngorm.commands.Command;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.ResultEvent;
	
	public class SearchCommand extends Command
	{
		private var _event : CairngormEvent;
		override public function execute(event:CairngormEvent) : void
		{
			super.execute(event);

			_event = event;
            switch(event.type)
            {
				case SearchEvent.SEARCH_COOPERANT:
				{	
				    searchCooperants(SearchEvent(event));
					break;
				}
                default : break;
            }
		}

		private function searchCooperants(event : SearchEvent):void
		{
			var delegate : SearchDelegate = new SearchDelegate(this,"ParticipantService");

			delegate.searchCooperant(event.filterVaues);
		}

		override public function result(data : Object):void
		{
			var results : ArrayCollection;
			var entitiesArray : ArrayCollection;
			switch(_event.type)
			{
				case SearchEvent.SEARCH_COOPERANT:
					 entitiesArray = data.result;
					 results = processCooperants(entitiesArray);
				break;
			}
		
			
			var ev : ResultEvent = new ResultEvent(ResultEvent.RESULT,false,true,results);
			SearchEvent(_event).callbacks.result(ev);
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
						entity.type = EntityVO.COOPERANT;
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