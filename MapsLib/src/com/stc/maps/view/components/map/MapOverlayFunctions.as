package com.stc.maps.view.components.map
{
	import com.google.maps.LatLng;
	import com.google.maps.Map;
	import com.google.maps.MapEvent;
	import com.google.maps.MapMouseEvent;
	import com.google.maps.controls.NavigationControl;
	import com.google.maps.overlays.Marker;
	import com.google.maps.overlays.MarkerOptions;
	import com.stc.maps.model.MarkerLocator;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.controls.Label;
	import mx.core.Container;

	public class MapOverlayFunctions
	{
		private var _map:Map;
		
		private var markerLocator:MarkerLocator = MarkerLocator.getInstance();
		
		public function MapOverlayFunctions()
		{
		}
		/*get set functions*/
		public function get map():Map{
			if(_map){
				_map.removeEventListener(MapEvent.MAP_READY, mapready_handler );
			}
			return _map;
		}
		public function set map(value:Map):void{
			_map = value;
			_map.addEventListener(MapEvent.MAP_READY, mapready_handler,false,0,true );
		}
		/*events*/
		
		/**
		 * Called when the Google Map has been loaded successfully
		 */
		public function mapready_handler(event : MapEvent) : void
		{
			_map.removeEventListener(MapEvent.MAP_READY, mapready_handler );
			//_map.addEventListener(MapMouseEvent.CLICK,map_mouseUpHandler,false,0,true);	
			
			_map.enableScrollWheelZoom();
			//mainMap.addControl(new MapTypeControl());
			_map.addControl(new NavigationControl());
			_map.setCenter(new LatLng(7.5803277913301415,-66.26953125));
			_map.setZoom(4);
			
		}
		
		private function map_mouseUpHandler(event:MapMouseEvent):void{
			var auxContainer:Container = markerLocator.getMarkerComponent("groupFlag",0x0000FF,true,(Math.random()*99).toString()); 
			var latlang : LatLng = event.latLng as LatLng;
			
			var markerOption : MarkerOptions = new MarkerOptions(
			{  
				label:"MIO",  
				tooltip:"MIO",  
				name: "MIO",
				icon: auxContainer,  
				hasShadow:true 
			});
			var pMarker:Marker = new Marker(latlang,markerOption);
			_map.addOverlay( pMarker as Marker);
		}
		
		
		/*override fucntions*/
		
	}
}