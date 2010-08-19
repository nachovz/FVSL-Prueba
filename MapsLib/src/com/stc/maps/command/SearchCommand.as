package com.stc.maps.command
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.stc.maps.business.SearchDelegate;
	import com.stc.maps.event.SearchEvent;
	import com.stc.maps.vo.CatalogValueVO;
	import com.stc.maps.vo.EntityVO;
	import com.stc.maps.vo.FilterValueVO;
	import com.stc.maps.vo.NetworkVO;
	import com.universalmind.cairngorm.commands.Command;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.Responder;
	import mx.rpc.events.ResultEvent;
	
	public class SearchCommand extends Command
	{
		private var multipleOrgSearchHandlers : mx.rpc.Responder = new mx.rpc.Responder(multipleOrgResult, fault);
		private var _event : CairngormEvent;
		private var _type : String;
		private var orgList : Array; 
		private var tempEntities : ArrayCollection = new ArrayCollection();
		private var params : ArrayCollection;
		
		override public function execute(event:CairngormEvent) : void
		{
			super.execute(event);

			_event = event;
			orgList = SearchEvent(event).entityOrgList;
            switch(SearchEvent(event).entityType)
            {
				case EntityVO.NETWORK:
				    searchNetwork(SearchEvent(event));
				break;
				case EntityVO.COOPERANT:
				    searchCooperant(SearchEvent(event));
				break;
				case EntityVO.ODS:
				    searchODS(SearchEvent(event));
				break;
				case EntityVO.COMPANY:
				    searchCompany(SearchEvent(event));
				break;
				default:
				break;
            }
		}

		private function searchCooperant(event : SearchEvent):void
		{
			var values : ArrayCollection = event.filterVaues;
			var array : Array = [];
			//pais
			array[0] = getValueByName(values,CatalogValueVO.COUNTRIES).value.toString();
			//enfoque
			//array[1] = getValueByName(values,CatalogValueVO.APPROACHES).value) as Number;
			//array[0] = 3;
			//estado
			//array[1] = Number(getValueByName(values,CatalogValueVO.STATES).value);
			array[1] = "-1";
			//anombreCoop
			array[2] = getValueByName(values,"name").value.toString();
			//array[2] = "is";
			//area
			array[3] = getValueByName(values,CatalogValueVO.AREAS).value.toString();
			//array[3] = "1";
			//premios
			array[4] = getValueByName(values,CatalogValueVO.AWARDS).value.toString();
			//array[4] = "Premio Verde";
			//orgType
			array[5] = getValueByName(values,CatalogValueVO.ORGANIZATION_TYPE).value.toString();
			//array[5] = 1;
			//financiamiento
			array[6] = getValueByName(values,CatalogValueVO.FINANCY).value.toString();
			//array[6] = 0;
			//enfoque
			//array[7] = getValueByName(values,CatalogValueVO.FINANCY).value.toString();
			array[7] = "1";
			params = new ArrayCollection(array);
			
			if(orgList.length==1)
			{
				var delegate : SearchDelegate = new SearchDelegate(this,"ParticipantService");
				delegate.searchEntity(event,params,orgList[0]);
			}
			else
			{
				var delegate : SearchDelegate = new SearchDelegate(multipleOrgSearchHandlers,"ParticipantService");
				delegate.searchEntity(event,params,orgList[1]);
			}
		}

		private function searchCompany(event : SearchEvent):void
		{
			var values : ArrayCollection = event.filterVaues;
			var array : Array = [];
			//pais
			array[0] = getValueByName(values,CatalogValueVO.COUNTRIES).value.toString();
			//enfoque
			//array[1] = getValueByName(values,CatalogValueVO.APPROACHES).value) as Number;
			//array[0] = 3;
			//estado
			//array[1] = Number(getValueByName(values,CatalogValueVO.STATES).value);
			array[1] = "-1";
			//nombre
			array[2] = getValueByName(values,"name").value.toString();
			//array[2] = "is";
			//financiamiento
			array[3] = getValueByName(values,CatalogValueVO.FINANCY).value.toString();
			//enfoque
			array[4] = getValueByName(values,CatalogValueVO.APPROACHES).value.toString();
			//array[6] = 0;
			params = new ArrayCollection(array);
			
			if(orgList.length==1)
			{
				var delegate : SearchDelegate = new SearchDelegate(this,"ParticipantService");
				delegate.searchEntity(event,params,orgList[0]);
			}
			else
			{
				var delegate : SearchDelegate = new SearchDelegate(multipleOrgSearchHandlers,"ParticipantService");
				delegate.searchEntity(event,params,orgList[1]);
			}
		}

		private function searchODS(event : SearchEvent):void
		{
			var values : ArrayCollection = event.filterVaues;
			var array : Array = [];
			//pais
			array[0] = getValueByName(values,CatalogValueVO.COUNTRIES).value.toString();
			//enfoque
			//array[1] = getValueByName(values,CatalogValueVO.APPROACHES).value) as Number;
			//array[0] = 3;
			//estado
			//array[1] = Number(getValueByName(values,CatalogValueVO.STATES).value);
			array[1] = "-1";
			//anombreCoop
			array[2] = getValueByName(values,"name").value.toString();
			//array[2] = "is";
			//area
			array[3] = getValueByName(values,CatalogValueVO.AREAS).value.toString();
			//array[3] = "1";
			//premios
			array[4] = getValueByName(values,CatalogValueVO.AWARDS).value.toString();
			//array[4] = "Premio1";
			//orgType
			//array[5] = Number(getValueByName(values,CatalogValueVO.ORGANIZATION_TYPE).value);
			//array[5] = 1;
			//financiamiento
			//array[6] = Number(getValueByName(values,CatalogValueVO.FINANCY).value);
			//array[6] = 0;
			params = new ArrayCollection(array);
			
			if(orgList.length==1)
			{
				var delegate : SearchDelegate = new SearchDelegate(this,"ParticipantService");
				delegate.searchEntity(event,params,orgList[0]);
			}
			else
			{
				var delegate : SearchDelegate = new SearchDelegate(multipleOrgSearchHandlers,"ParticipantService");
				delegate.searchEntity(event,params,orgList[1]);
			}
		}

		private function searchNetwork(event : SearchEvent):void
		{
			var values : ArrayCollection = event.filterVaues;
			var array : Array = [];
			//pais
			array[0] = getValueByName(values,CatalogValueVO.COUNTRIES).value.toString();
			//enfoque
			//array[1] = getValueByName(values,CatalogValueVO.APPROACHES).value) as Number;
			//array[0] = 3;
			//estado
			//array[1] = Number(getValueByName(values,CatalogValueVO.STATES).value);
			array[1] = "-1";
			//anombreCoop
			array[2] = getValueByName(values,"name").value.toString();
			//array[2] = "is";
			params = new ArrayCollection(array);
			
			if(orgList.length==1)
			{
				var delegate : SearchDelegate = new SearchDelegate(this,"ParticipantService");
				delegate.searchEntity(event,params,orgList[0]);
			}
			else
			{
				var delegate : SearchDelegate = new SearchDelegate(multipleOrgSearchHandlers,"ParticipantService");
				delegate.searchEntity(event,params,orgList[1]);
			}
		}

		private function searchTest(event : SearchEvent):void
		{
			var values : ArrayCollection = event.filterVaues;
			var array : Array = [];
			//pais
			array[0] = 2;
			//enfoque
			//array[0] = 3;
			//estado
			array[1] = 264;
			//anombreCoop
			array[2] = "Pru";
			//area
			array[3] = "2";
			//premios
			array[4] = "Premio1";
			//orgType
			array[5] = 1;
			//financiamiento
			array[6] = 0;
			params = new ArrayCollection(array);
			
			var delegate : SearchDelegate = new SearchDelegate(this,"ParticipantService");
			delegate.searchEntity(event,params,orgList[0]);
		}

		private function multipleOrgResult(data : Object):void
		{
			var entitiesArray : ArrayCollection;
			switch(SearchEvent(_event).entityType)
			{
				case EntityVO.NETWORK:
					 entitiesArray = data.result;
					 _type = SearchEvent(_event).entityType;
					 tempEntities = processNetworks(entitiesArray,orgList[1]);
				break;
				default:
					 entitiesArray = data.result;
					 _type = SearchEvent(_event).entityType;
					 tempEntities = processEntities(entitiesArray,orgList[1]);
				break;
			}
		
			var delegate : SearchDelegate = new SearchDelegate(this,"ParticipantService");
			delegate.searchEntity(_event as SearchEvent,params,orgList[0]);
		}

		override public function result(data : Object):void
		{
			var results : ArrayCollection = tempEntities;
			var entitiesArray : ArrayCollection;
			switch(SearchEvent(_event).entityType)
			{
				case EntityVO.NETWORK:
					 entitiesArray = data.result;
					 _type = SearchEvent(_event).entityType;
					 results = new ArrayCollection(results.source.concat(processNetworks(entitiesArray,orgList[0]).source));
				break;
				default:
					 entitiesArray = data.result;
					 _type = SearchEvent(_event).entityType;
					 results = new ArrayCollection(results.source.concat(processEntities(entitiesArray,orgList[0]).source));
				break;
			}
		
			var ev : ResultEvent = new ResultEvent(ResultEvent.RESULT,false,true,results);
			SearchEvent(_event).callbacks.result(ev);
		}

		override public function fault(info : Object):void
		{
			Alert.show("Error en la busqueda.");
		}
		
		private function processEntities(entitiesArray : ArrayCollection, orgType : String) : ArrayCollection
		{
			var results : ArrayCollection = new ArrayCollection();
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
						entity.org = orgType;
						
						results.addItem(entity);
					}
				}
				
			}
			
			return results;
		}
		
		private function processNetworks(entitiesArray : ArrayCollection, orgType : String) : ArrayCollection
		{
			var results : ArrayCollection = new ArrayCollection();
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
						entity.org = orgType;
						entity.parentType = obj.parent.type;
						entity.setNodesObjects(obj.nodes);
						
						results.addItem(entity);
					}
				}
				
			}
			
			return results;
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