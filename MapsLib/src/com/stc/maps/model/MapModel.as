package com.stc.maps.model
{
	import com.adobe.cairngorm.model.IModelLocator;
	import com.google.maps.InfoWindowOptions;
	import com.google.maps.LatLng;
	import com.google.maps.Map;
	import com.google.maps.MapEvent;
	import com.google.maps.MapMouseEvent;
	import com.google.maps.MapZoomEvent;
	import com.google.maps.controls.ControlPosition;
	import com.google.maps.controls.ZoomControl;
	import com.google.maps.controls.ZoomControlOptions;
	import com.google.maps.overlays.Marker;
	import com.google.maps.overlays.MarkerOptions;
	import com.google.maps.overlays.Polyline;
	import com.google.maps.overlays.PolylineOptions;
	import com.google.maps.styles.StrokeStyle;
	import com.stc.maps.control.MapsController;
	import com.stc.maps.event.EntitiesEvent;
	import com.stc.maps.event.FiltersEvent;
	import com.stc.maps.event.SearchEvent;
	import com.stc.maps.view.CollapsableMenu;
	import com.stc.maps.view.components.AdvancedSearch;
	import com.stc.maps.view.components.InputBox;
	import com.stc.maps.view.components.event.AdvancedSearchEvent;
	import com.stc.maps.view.components.event.EntityRendererEvent;
	import com.stc.maps.view.components.event.EntityRendererListEvent;
	import com.stc.maps.view.components.map.Clusterer;
	import com.stc.maps.view.components.map.MapOverlayFunctions;
	import com.stc.maps.view.components.map.mapplugins.ButtonComboBox;
	import com.stc.maps.view.components.map.specialmarkers.GroupMarkers;
	import com.stc.maps.vo.EntityVO;
	import com.stc.maps.vo.NetworkVO;
	
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getQualifiedSuperclassName;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.Container;
	import mx.events.ItemClickEvent;
	import mx.events.ListEvent;
	import mx.events.ResizeEvent;
	import mx.managers.CursorManager;
	import mx.managers.PopUpManager;
	import mx.modules.Module;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	
/* 	import flash.utils.Dictionary;  */

	[Bindable]
	public class MapModel implements com.adobe.cairngorm.model.IModelLocator
	{
		private static var mapModel 	:com.stc.maps.model.MapModel;
		
		/*UIComponentes*/
		public var advancedSearch:AdvancedSearch;
		public var mainMap:Map;
		public var menu:CollapsableMenu;
		public var containerThis:Module;
		
		
		
		public static function getInstance() : com.stc.maps.model.MapModel
		{
			if ( mapModel == null ){
				mapModel = new com.stc.maps.model.MapModel();
			}
			return mapModel;
		}
		
		public function MapModel()
		{
			if ( MapModel.mapModel != null )
				throw new Error( "Only one MarkerLocator instance should be instantiated" );	
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		private var clusterer:Clusterer;
		
		private var markerLocator:MarkerLocator = MarkerLocator.getInstance();
		
		private var overlayFunctions:MapOverlayFunctions = new MapOverlayFunctions;
		
		
		
		/**
		 * This is the central model of the application, the point of this is
		 * that we only have to go to the server the first time a data request is made.
		 * From then on the data iretrived from this main applicacion model.
		 * 
		 * */
		//[Bindable]
		private var model : ModelLocator = ModelLocator.getInstance();
		
		/**
		 * This controller handles all the requests of data that are made by the application
		 * */
		private var controller : MapsController = new MapsController();	
		
		/**
		 * Request data habdlers
		 */
		private var getEntitiesHandlers : mx.rpc.Responder = new mx.rpc.Responder(getEntitiesResult, getEntitiesFault);
		private var getFiltersHandlers : mx.rpc.Responder = new mx.rpc.Responder(getFiltersResult, getFiltersFault);
		private var searchHandlers : mx.rpc.Responder = new mx.rpc.Responder(advancedSearchResult, advancedSearchFault);
		
		/**
		 * All the layers are being displayed on runtime in the application.
		 */
		private var selectedentityList : Array = [EntityVO.COOPERANT,EntityVO.ODS,EntityVO.COMPANY,EntityVO.NETWORK];
		
		public static const FVSL : String 	= "fvsl";
		public static const UR : String 	= "ur";
		private var selectedentityOrgList : Array = [MapModel.FVSL,MapModel.UR];
		
		
		/**
		 * Mapping structure to get the EntityVO of the given Icon Marker Instance.
		 */
		private var markerEntity : Dictionary = new Dictionary(true);
		
		
		/**
		 * If the advanced search panel is visible or not.
		 */
		//[Bindable]	
		public var searchVisibility : Boolean = false;
		
		/**
		 * If the toggle button bar for layers is visible or not.
		 */
		//[Bindable]	
		public var toggleVisibility : Boolean = false;
		
		
		
		private var clusteringMode:Boolean = true;
		
		/**
		 * Called when the Google Map has been loaded successfully
		 */
		private var zoomControlObject:Object = null;
		public function mapready_handler(event : Event) : void
		{
			var bottomRight:ControlPosition = new ControlPosition(ControlPosition.ANCHOR_BOTTOM_RIGHT, 16, 10);
			
			var myZoomControl:ZoomControl = new ZoomControl(new ZoomControlOptions({position: bottomRight}));
			var num:int = mainMap.numChildren;
			var obj:Object;
			for(var i :int = 0 ; i<num ; i ++){
				obj = mainMap.getChildAt(i);
				if(obj.toString().toLowerCase().indexOf(("controlsmc").toString().toLowerCase() ) >= 0 ){
					zoomControlObject=obj;
					break;
				}
			}
			//event.target.addControl(myZoomControl);
			getEntityies();
			addEventListeners();
			toggleVisibility = true;
			mapResizeHandler();
		}
		
		/**
		 * We start listening for user interaction
		 */
		private function addEventListeners() : void
		{
			containerThis.addEventListener(EntityRendererListEvent.ZOOM_SEARCH,focusMap);
			containerThis.addEventListener(EntityRendererEvent.HIDE_ITEM,hideMarker);
			containerThis.addEventListener(EntityRendererEvent.SHOW_ITEM,showMarker);
			containerThis.addEventListener("finishHideOrShow",finishhandler);
			containerThis.addEventListener("finishHideAllMarquers",finishHideAllMarkers);
			containerThis.addEventListener(EntityRendererEvent.HIDE_NETWORK,hideNetwork);
			containerThis.addEventListener(EntityRendererEvent.SHOW_NETWORK,showNetwork);
			mainMap.addEventListener(MapZoomEvent.ZOOM_CHANGED,onMapZoomChanged,false,0,true);
			mainMap.addEventListener(Event.RESIZE,mapResizeHandler);
			advancedSearch.addEventListener(AdvancedSearchEvent.SEARCH,advancedSearch_AdvancedSearchEvent,false,0,true);
		}
		
		protected function mapResizeHandler(event:Event = null):void{
			trace("Map Resize");
			zoomControlObject.x = mainMap.width-90;
			zoomControlObject.y = mainMap.height -370;
		}
		
		private function finishhandler(event:Event):void{
			setAllMarkersOnTheMap()
			
		}
		private function finishHideAllMarkers(event:Event):void{
			setAllMarkersOnTheMap()
			
		}
		private function onMapZoomChanged(event:MapZoomEvent):void
		{
			if(clusterer){
				clusterer.zoom = mainMap.getZoom();
				if(clusteringMode){
					setAllMarkersOnTheMap();
				}
			}
		}
	
		
		/**
		 * We center the map to the given EntityVO
		 */
		private function focusMap(ev : EntityRendererListEvent):void
		{
			var entity : EntityVO = ev.item as EntityVO;
			mainMap.setCenter(new LatLng(entity.lat,entity.long));
			mainMap.openInfoWindow(mainMap.getCenter(), new InfoWindowOptions({
				title: entity.title
			}));
		}
		/**
		 * Initial request of all the data layers
		 */
		private function getEntityies() : void
		{
			var getCooperantes : EntitiesEvent = new EntitiesEvent(EntitiesEvent.GET_ENTITY_LIST,getEntitiesHandlers);
			getCooperantes.entityType = EntityVO.COOPERANT;
			getCooperantes.entityOrg = MapModel.FVSL;
			getCooperantes.dispatch();
			getCooperantes  = new EntitiesEvent(EntitiesEvent.GET_ENTITY_LIST,getEntitiesHandlers);
			getCooperantes.entityType = EntityVO.ODS;
			getCooperantes.entityOrg = MapModel.FVSL;
			getCooperantes.dispatch(); 
			getCooperantes = new EntitiesEvent(EntitiesEvent.GET_ENTITY_LIST,getEntitiesHandlers);
			getCooperantes.entityType = EntityVO.NETWORK;
			getCooperantes.entityOrg = MapModel.FVSL;
			getCooperantes.dispatch();
			getCooperantes = new EntitiesEvent(EntitiesEvent.GET_ENTITY_LIST,getEntitiesHandlers);
			getCooperantes.entityType = EntityVO.COMPANY;
			getCooperantes.entityOrg = MapModel.FVSL;
			getCooperantes.dispatch();
			
			
				
			var getCooperantes : EntitiesEvent = new EntitiesEvent(EntitiesEvent.GET_ENTITY_LIST,getEntitiesHandlers);
			getCooperantes.entityType = EntityVO.COOPERANT;
			getCooperantes.entityOrg = MapModel.UR;
			getCooperantes.dispatch();
			getCooperantes  = new EntitiesEvent(EntitiesEvent.GET_ENTITY_LIST,getEntitiesHandlers);
			getCooperantes.entityType = EntityVO.ODS;
			getCooperantes.entityOrg = MapModel.UR;
			getCooperantes.dispatch(); 
			getCooperantes = new EntitiesEvent(EntitiesEvent.GET_ENTITY_LIST,getEntitiesHandlers);
			getCooperantes.entityType = EntityVO.NETWORK;
			getCooperantes.entityOrg = MapModel.UR;
			getCooperantes.dispatch();
			getCooperantes = new EntitiesEvent(EntitiesEvent.GET_ENTITY_LIST,getEntitiesHandlers);
			getCooperantes.entityType = EntityVO.COMPANY;
			getCooperantes.entityOrg = MapModel.UR;
			getCooperantes.dispatch();	
		}
		
		/**
		 * When a layer (Cooperants, Networks, Companies, etc.) is ready to be displayed
		 */
		private function getEntitiesResult(event : ResultEvent) : void
		{
			var entities : ArrayCollection = event.result as ArrayCollection;
			if(entities && entities.length>0)
			{
				if(EntityVO(entities.getItemAt(0)).type)
				{
					model.entities[Object(entities.getItemAt(0)).type+Object(entities.getItemAt(0)).org] = entities;
					addEntityToMenu(Object(entities.getItemAt(0)).type+Object(entities.getItemAt(0)).org);
					addMapLayer(entities);
					model.allEntities = concatArrays(model.allEntities,entities.source);
					if(clusteringMode){
						setAllMarkersOnTheMap();
					}
				}
			}
		}
		
		/**
		 * When a layer (Cooperants, Networks, Companies, etc.) is ready to be displayed
		 */
		private function advancedSearchResult(event : ResultEvent) : void
		{
			var entities : ArrayCollection = event.result as ArrayCollection;
			if(entities && entities.length>0)
			{
				if(EntityVO(entities.getItemAt(0)).type)
				{
					clearMap();
					menu.entities = entities;
					addMapLayer(entities);
				}
			}
			else
			{
				Alert.show("No hay Resultados");
			}
		}
		
		/**
		 * This handles the result of the request for the filters of a specific layer.
		 */
		private function getFiltersResult(event : ResultEvent) : void
		{
			var searchFilters : ArrayCollection = event.result as ArrayCollection;
			if(searchFilters && searchFilters.length>0)
			{
				model.filterOptions[selectedentityList[0]] = searchFilters;
				searchVisibility = true;
				advancedSearch.searchFilters = searchFilters;
			}
			else
				searchVisibility = false;
		}
		
		/**
		 * Merge the current list of entitys being displayed on le tools bar with the new list
		 * that is going to be displayed on the map
		 */
		private function addEntityToMenu(entity : String) : void
		{
			var auxArray : ArrayCollection = (menu.entities) ? menu.entities : new ArrayCollection();
			
			if(model.entities[entity] && model.entities[entity].length>0)
				auxArray.source = auxArray.source.concat(model.entities[entity].source);
			
			menu.entities = auxArray;
		}
		private function hideNetwork(ev : EntityRendererEvent) : void
		{
			ev.item.marker.visible = false;
			try{
				markerEntity[ev.item.marker].visibilityByCheckBox = false; //fix
			}catch(e:Error){
				trace(e);
			}
			//if(selectedentityList[0]==EntityVO.NETWORK)
			if(selectedentityList[0]==EntityVO.NETWORK)
				for each(var node : EntityVO in ev.item.nodes)
			{
				if(node.marker) node.marker.visible = false;
				try{
					markerEntity[node.marker].visibilityByCheckBox = false; //fix
				}catch(e:Error){
					trace(e);
				}
			}
		}
		private function hideMarker(ev : EntityRendererEvent) : void
		{
			var entity : EntityVO = ev.item as EntityVO;
			if(entity.marker) {
				Marker(entity.marker).visible = false;
				try{
				markerEntity[entity.marker].visibilityByCheckBox = false; //fix
				}catch(e:Error){
					trace(e);
				}
			}
			if(entity.type==EntityVO.NETWORK)
			{
				var network : NetworkVO = entity as NetworkVO;
				for each(var entt : EntityVO in network.nodes){
					if(entt.marker) {
						Marker(entt.marker).visible = false;
						try{
					markerEntity[entity.marker].visibilityByCheckBox = false; //fix
					}catch(e:Error){
					trace(e);
					
				}
					}
				}
			}
		}
		private function showNetwork(ev : EntityRendererEvent) : void
		{
			ev.item.marker.visible = true;
			try{
				markerEntity[ev.item.marker].visibilityByCheckBox = true; //fix
			}catch(e:Error){
				trace(e);
			}
			if(selectedentityList[0]==EntityVO.NETWORK)
				for each(var node : EntityVO in ev.item.nodes)
				{
					if(node.marker){ 
						node.marker.visible = true;
						try{
							markerEntity[node.marker].visibilityByCheckBox = true; //fix
						}catch(e:Error){
							trace(e);
						}
					}
				}
		}
		private function showMarker(ev : EntityRendererEvent) : void
		{
			
			var entity : EntityVO = ev.item as EntityVO; 
			if(entity.marker) {
				Marker(entity.marker).visible = true;
				try{
					markerEntity[entity.marker].visibilityByCheckBox = true; //fix
				}catch(e:Error){
					trace(e);
				} 
			}
			if(entity.type==EntityVO.NETWORK)
			{
				var network : NetworkVO = entity as NetworkVO;
				for each(var entt : EntityVO in network.nodes)
				if(entt.marker) {
					Marker(entt.marker).visible = true;
					try{
					markerEntity[entt.marker].visibilityByCheckBox = true; // fix
					}catch(e:Error){
						trace(e);
				}
				}
			}
			
		}
		
		private function addMapLayer(entitiesList : ArrayCollection) : void
		{
			var totalLayers : int = selectedentityList.length;
			for each(var entity : EntityVO in entitiesList)
			{
				if(entity.lat && entity.long)
				{
					createMarker( entity, getEntityIcon(entity.type) );
				}
			}
		}
		
		/**
		 * This method dispatch a cairgorm event to call the searchCoperant webservice
		 * */
		private function advancedSearch_AdvancedSearchEvent(event : AdvancedSearchEvent) : void
		{
			var ev : SearchEvent = new SearchEvent(SearchEvent.SEARCH_ENTITY,searchHandlers);
			ev.entityType = selectedentityList[0];
			ev.filterVaues = event.searchFilterValues;
			ev.entityOrgList = selectedentityOrgList;
			ev.dispatch();
		}
		
		private function renderNetwork(network:NetworkVO):void
		{
			for each(var entity : EntityVO in network.nodes)
			{
				createMarker( entity, getEntityIcon(entity.type) );
			}   		
		}
		
		private function getEntityIcon( type : String ) : Object
		{
			switch(type)
			{
				case EntityVO.COOPERANT:
					return markerLocator.getMarkerComponent("singleFlag",0xFFD200);
					break; 
				case EntityVO.COMPANY:
					return markerLocator.getMarkerComponent("singleFlag",0x0F1E79); 
					break; 
				case EntityVO.ODS:
					return markerLocator.getMarkerComponent("singleFlag",0xFF8F00);
					break; 
				case EntityVO.NETWORK:
					return markerLocator.getMarkerComponent("singleFlag",0x29BE07);
					break; 
				default:
					return markerLocator.getMarkerComponent("singleFlag",0xFFD200);
					break;
			} 
		}
		
		private function createMarkerForNetworkVO( entity:EntityVO , auxIcon : Object) : void 
		{
			var latlang : LatLng = new LatLng( entity.lat, entity.long );
			var markerOption : MarkerOptions = new MarkerOptions(
				{  
					label:entity.title,  
					tooltip:entity.title,  
					name: entity.title,
					icon: auxIcon,  
					hasShadow:true,
					width:25,
					height:32
				});
			
			var pMarker:Marker = new Marker(latlang,markerOption);
			if(entity.marker){
				entity.marker.removeEventListener(MapMouseEvent.CLICK,marker_click_for_networkVO);
			}
			entity.marker = pMarker;
			entity.marker.addEventListener(MapMouseEvent.CLICK,marker_click_for_networkVO,false,0,true);
			mainMap.addOverlay( entity.marker as Marker);  
		}
		
		private function createMarker( entity:EntityVO , auxIcon : Object) : void 
		{
			var latlang : LatLng = new LatLng( entity.lat, entity.long );
			var markerOption : MarkerOptions = new MarkerOptions(
				{  
					label:entity.title,  
					tooltip:entity.title,  
					name: entity.title,
					icon: auxIcon,  
					hasShadow:true,
					width:25,
					height:32
				});
			
			var pMarker:Marker = new Marker(latlang,markerOption);
			if(entity.marker){
				entity.marker.removeEventListener(MapMouseEvent.CLICK,marker_click);
			}
			entity.marker = pMarker;
			entity.marker.addEventListener(MapMouseEvent.CLICK,marker_click,false,0,true);
			
			markerEntity[entity.marker] = entity;
			
			mainMap.addOverlay( entity.marker as Marker);  
		}
		private function marker_click_for_networkVO(event : MapMouseEvent) : void
		{
			CursorManager.setBusyCursor();
			var entity : EntityVO = networkVODictionaryView[event.target] as EntityVO;
			var input : InputBox = new InputBox();
			input.data = entity;
			input.addEventListener(EntityRendererEvent.EXPAND_NETWORK,expandNetwork,false,0,true);
			
			if(entity.type!="network") 
			{
				var ev : EntitiesEvent = new EntitiesEvent(EntitiesEvent.GET_ENTITY_DETAILS,input.getEntityDetailsHandlers);
				ev.entityType = entity.type;
				ev.entityId = entity.id.toString();
				ev.entityOrg = entity.org;
				ev.dispatch();
			}
			else
			{
				ev = new EntitiesEvent(EntitiesEvent.GET_NETWORK_DETAILS,input.getNetworkDetailsHandlers);
				ev.entityType = entity.type;
				ev.entityId = entity.id.toString();
				ev.entityOrg = entity.org;
				ev.dispatch();
			}
			
			PopUpManager.addPopUp(input,containerThis);
			PopUpManager.centerPopUp(input);
			input.y = input.y-100;
		}
		private function marker_click(event : MapMouseEvent) : void
		{
			CursorManager.setBusyCursor();
			var entity : EntityVO = markerEntity[event.target] as EntityVO;
			var input : InputBox = new InputBox();
			input.data = entity;
			input.addEventListener(EntityRendererEvent.EXPAND_NETWORK,expandNetwork,false,0,true);
			
			if(entity.type!="network") 
			{
				var ev : EntitiesEvent = new EntitiesEvent(EntitiesEvent.GET_ENTITY_DETAILS,input.getEntityDetailsHandlers);
				ev.entityType = entity.type;
				ev.entityOrg = entity.org;
				ev.entityId = entity.id.toString();
				ev.dispatch();
			}
			else
			{
				ev = new EntitiesEvent(EntitiesEvent.GET_NETWORK_DETAILS,input.getNetworkDetailsHandlers);
				ev.entityType = NetworkVO(entity).parentType;
				ev.entityId = entity.id.toString();
				ev.entityOrg = entity.org;
				ev.dispatch();
			}
			
			PopUpManager.addPopUp(input,containerThis);
			PopUpManager.centerPopUp(input);
			input.y = input.y-100;
		}
		
		
		private function clearMap() : void
		{
			mainMap.clearOverlays();
			markerEntity = new Dictionary(true);
			model.allEntities = [];
			attachedMarkers = [];
			//model.entities
		}
		
		
		private var seletedNetworkVO:NetworkVO;
		private var seletedNetworkVOCloned:NetworkVO;
		private var networkView:Boolean = false;
		private var networkVODictionaryView:Dictionary = new Dictionary(true)
		private function expandNetwork(ev : EntityRendererEvent) : void
		{
			var auxNetworkVO:NetworkVO = ev.network as NetworkVO;
			
			if(networkView){
				closeNetworkVOView();
			}else{
				networkView = true;
				networkVODictionaryView = new Dictionary(true);
				seletedNetworkVO = ev.network as NetworkVO;
				seletedNetworkVOCloned = seletedNetworkVO.clone() as NetworkVO; 
				clustetingModeChanger(false);
				menu.entities = ev.network.nodes;
				hideOrShowAllMarkersForNetworkVO(false);
				drawLinesForNetworkVO();
			}
			
		}
		
		private function closeNetworkVOView():void{
			networkView = false;
			networkVODictionaryView = null;
			if(arrayOfNetworkVO.length>0){
				for(var i:int = 0 ; i<arrayOfNetworkVO.length; i ++){
					if(arrayOfNetworkVO[i] is Marker){
						var auxM:Marker = arrayOfNetworkVO[i] as Marker;
						if(auxM.hasEventListener(MapMouseEvent.CLICK)){
							auxM.removeEventListener(MapMouseEvent.CLICK,marker_click_for_networkVO);
						}
						mainMap.removeOverlay(auxM);
					}
					if(arrayOfNetworkVO[i] is Polyline){
						var auxP:Polyline = arrayOfNetworkVO[i] as Polyline;
						mainMap.removeOverlay(auxP);
						
					}
				}
			}
			arrayOfNetworkVO = [];
			seletedNetworkVOCloned = null;
			seletedNetworkVO = null;
			hideOrShowAllMarkersForNetworkVO(true);
			clustetingModeChanger(true);
			menu.entities = new ArrayCollection(model.allEntities);
			
		}
		
		private var arrayOfNetworkVO:Array = [];
		private function drawLinesForNetworkVO():void{
			createMarkerForNetworkVO(seletedNetworkVOCloned,getEntityIcon(seletedNetworkVOCloned.type));
			var mainMarker:Marker = seletedNetworkVOCloned.marker as Marker;
			arrayOfNetworkVO.push(mainMarker);
			networkVODictionaryView[mainMarker] = seletedNetworkVOCloned ;
			for(var i : int = 0 ; i<seletedNetworkVOCloned.nodes.length ; i++){
				var auxEntity:EntityVO = seletedNetworkVOCloned.nodes[i] as EntityVO;
				createMarkerForNetworkVO(auxEntity,getEntityIcon(auxEntity.type));
				
				var auxMarker:Marker = auxEntity.marker as Marker;
				auxMarker.visible = true;
				arrayOfNetworkVO.push(auxMarker);
				
				networkVODictionaryView[auxMarker] = auxEntity ;
				var polyShape:Polyline = new Polyline(
					[mainMarker.getLatLng(), auxMarker.getLatLng()]
					, 
					new PolylineOptions(
						{ strokeStyle: new StrokeStyle({
					color: 0x000000,
					thickness:0.6,
					alpha: 0.7})
				}));
				arrayOfNetworkVO.push(polyShape);
				mainMap.addOverlay(polyShape);
				
			}
		}
		
		private function hideOrShowAllMarkersForNetworkVO(value:Boolean):void{
			for(var i:int = 0; i<model.allEntities.length; i++){
				var auxMarker:Marker = model.allEntities[i].marker as Marker;
				try{
					auxMarker.visible = value;
				}catch(e:Error){
				}
			}
		}
		
		
		
		
		
		
		private function changeLayer(entityesList : Array, orgList:Array) : void
		{
			clearMap();
			var pastString:String
			for each(var org : String in orgList){
				for each(var entity : String in entityesList){
					addMapLayer(model.entities[entity+org]);
					if(model.entities[entity+org] && pastString != (entity+org).toString() ){
						pastString = (entity+org).toString();
						model.allEntities = concatArrays(model.allEntities,model.entities[entity+org].source);
						if(clusteringMode){
							setAllMarkersOnTheMap();
						}
					}
				}
			}
			
			
			
		}
		
		private function changeMenuDatasourceTypes(entityesList : Array,orgList:Array) : void
		{
			var menuData : ArrayCollection = new ArrayCollection();
			
			for each(var org : String in orgList)
				for each(var entity : String in entityesList)
					if(model.entities[entity+org])
						menuData.source = menuData.source.concat(model.entities[entity+org].source);
			
			menu.entities = menuData;
			
		}
		
		private function showAdvancedSearch(keyName : String) : void
		{
			if(!model.filterOptions[keyName])
			{
				var ev : FiltersEvent = new FiltersEvent(FiltersEvent.GET_FILTERS_LIST,getFiltersHandlers);
				ev.entityType = keyName;
				ev.dispatch();
			}
			else
			{
				var event : mx.rpc.events.ResultEvent = new mx.rpc.events.ResultEvent(ResultEvent.RESULT,false,true,model.filterOptions[keyName]);
				getFiltersResult(event);
			}
		}
		
		public function toggleOptons_clickHandler(event:ItemClickEvent):void 
		{
			if(networkView){
				closeNetworkVOView();
			}
			
			
			var entityList : Array = [];
			if(event.item.keyName!="all" && event.item.keyName!="network")
			{
				entityList.push(event.item.keyName);
				selectedentityList = entityList;
				showAdvancedSearch(event.item.keyName);
			}
			else if(event.item.keyName=="all")
			{
				entityList.push(EntityVO.COMPANY);
				entityList.push(EntityVO.ODS);
				entityList.push(EntityVO.COOPERANT);
				entityList.push(EntityVO.NETWORK);
				
				selectedentityList = entityList;
				searchVisibility = false;
			}
			else if(event.item.keyName=="network")
			{
				entityList.push(EntityVO.NETWORK);
				selectedentityList = entityList;
				showAdvancedSearch(event.item.keyName);
			}
			
			changeLayer(entityList,selectedentityOrgList);
			changeMenuDatasourceTypes(entityList,selectedentityOrgList);
		}
		
		public function map_resize(event : ResizeEvent) : void
		{
			menu.height = containerThis.height;
		}
		
		
		private function getEntitiesFault(event : FaultEvent) : void
		{
			Alert.show("A ocurrido un error buscando las entidades.");
		}
		private function getFiltersFault(event : FaultEvent) : void
		{
			Alert.show("A ocurrido un error buscando los filtros de busqueda.");
		}
		private function advancedSearchFault(event : FaultEvent) : void
		{
			Alert.show("A ocurrido un error en la busqueda avanzada.");
		}
		
		public function mainMap_mapevent_mappreinitializeHandler(event:MapEvent):void
		{
			overlayFunctions.map = event.target as Map;
		}
		
		
		private function concatArrays(theArray:Array,theThingToAdd:Array):Array{
			var auxArray : Array = [];
			auxArray = auxArray.concat(theArray,theThingToAdd);
			return auxArray;
		}
		
		
		private var attachedMarkers:Array = [];
		private function setAllMarkersOnTheMap():void{
				var myMarker:Marker;
				if(!clusterer){
					clusterer = new Clusterer(model.allEntities, mainMap.getZoom(), 30);
				}else{
					clusterer.markers = model.allEntities;
				}
				
				for each (var marker:GroupMarkers in attachedMarkers) {
					mainMap.removeOverlay(marker);
					var auxArray:Array = marker.allMakers;
					for(var i:int =0; i<auxArray.length ; i++ ){
						myMarker =  auxArray[i] as Marker;
						if(markerEntity[myMarker].visibilityByCheckBox)
							myMarker.visible = true;
					}
				}
				attachedMarkers = [];
				var clusteredMarkers:Array = clusterer.clusters;
				
				for each (var cluster:Array in clusteredMarkers) {
					marker = null;
					var theGroupMarkers:GroupMarkers = null
					if (cluster.length == 1) {
						// there is only a single marker in this cluster
						//marker = cluster[0];
					} else {
						var auxIcon:Container = markerLocator.getMarkerComponent("groupFlag",0x8c0791,true,cluster.length.toString());
						var markerOption : MarkerOptions = new MarkerOptions(
							{  
								icon: auxIcon,  
								hasShadow:true 
							});
						;
						myMarker =  cluster[0]  as Marker;
						var latlang : LatLng =myMarker.getLatLng();
						theGroupMarkers = new GroupMarkers(latlang,markerOption);
						theGroupMarkers.allMarkers = cluster;
						for(i = 0; i<cluster.length ; i++ ){
							myMarker =  cluster[i] as Marker;
							myMarker.visible = false;
						}
						
					}
					if(theGroupMarkers){
						mainMap.addOverlay(theGroupMarkers);
						attachedMarkers.push(theGroupMarkers);
					}
				}
			
		}
		
		
		public function comboBoxChangeHandler(event:ListEvent):void
		{
			var auxButtonComboBox:ButtonComboBox = (event.target as ButtonComboBox)
			var auxObj:Object = auxButtonComboBox.itemSelected as Object;
			auxButtonComboBox.buttonLabel = auxObj.name;
			selectedentityOrgList = auxObj.org;
			
			changeLayer(selectedentityList,selectedentityOrgList);
			changeMenuDatasourceTypes(selectedentityList,selectedentityOrgList);
		}
		
		private function clustetingModeChanger(value:Boolean):void{
			clusteringMode = value;
			var myMarker:Marker
			if(clusteringMode){
				setAllMarkersOnTheMap();
			}else{
				for each (var marker:GroupMarkers in attachedMarkers) {
					mainMap.removeOverlay(marker);
					var auxArray:Array = marker.allMakers;
					for(var i:int =0; i<auxArray.length ; i++ ){
						myMarker =  auxArray[i] as Marker;
						myMarker.visible = true;
					}
				}
				attachedMarkers = [];
			}
		}
		
		
	}
}