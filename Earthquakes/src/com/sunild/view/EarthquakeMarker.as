package com.sunild.view
{
	import com.google.maps.InfoWindowOptions;
	import com.google.maps.LatLng;
	import com.google.maps.MapEvent;
	import com.google.maps.PaneId;
	import com.google.maps.interfaces.IInfoWindow;
	import com.google.maps.interfaces.IMap;
	import com.google.maps.interfaces.IMarker;
	import com.google.maps.interfaces.IPane;
	import com.google.maps.overlays.MarkerOptions;
	import com.google.maps.overlays.OverlayBase;
	import com.sunild.vo.EarthquakeVO;
	
	import flash.events.MouseEvent;
	import flash.geom.Point;

	public class EarthquakeMarker extends OverlayBase implements IMarker
	{
		private var _latLon:LatLng;
		private var _infoWindowHTML:String;
		private var _magnitude:Number;
		private var _target:EarthquakeTarget;
		
		
		public function EarthquakeMarker(vo:EarthquakeVO)
		{
			super();
			_latLon = vo.latLon;
			_magnitude = vo.magnitude;
			_target = new EarthquakeTarget();
			_infoWindowHTML = "<b>" + vo.title + "</b><br />" +
				"<b>Magnitude:</b> " + vo.magnitude.toString() + 
				"<br/><b>Depth:</b> " + vo.elevation.toString() +
				"<br/><br/><i>" + vo.updated + "</i>";
			
			addEventListener(MapEvent.OVERLAY_ADDED, handleMapEvents,false,0,true);
			addEventListener(MapEvent.OVERLAY_REMOVED, handleMapEvents,false,0,true);
			addEventListener(MouseEvent.MOUSE_OVER, handleMouseEvents,false,0,true);
			addEventListener(MouseEvent.MOUSE_OUT, handleMouseEvents,false,0,true);
		}
		
		
		/**
		 * 
		 * IMarker interface methods
		 * 
		 */
		
		
		public function getLatLng():LatLng
		{
			return _latLon;
		}
		
		public function setLatLng(latLon:LatLng):void
		{
			_latLon = latLon;
		}
		
		// not going to bother with MarkerOptions (for now at least)
		public function getOptions():MarkerOptions
		{
			return null;
		}
		
		public function setOptions(arg0:MarkerOptions):void
		{
		}
		
		public function openInfoWindow(opts:InfoWindowOptions=null):IInfoWindow
		{
			return pane.map.openInfoWindow(_latLon,opts);
		}
		
		public function closeInfoWindow():void
		{
			pane.map.closeInfoWindow();
		}
		
		public function isHidden():Boolean
		{
			return false;
		}
		
		public function hide():void
		{
		}
		
		public function show():void
		{
		}
		
		
		
		
		/**
		 * 
		 * Overrides
		 * 
		 */
		
		override public function getDefaultPane(map:IMap):IPane
		{
			return map.getPaneManager().getPaneById(PaneId.PANE_MARKER);
		}
		
		override public function positionOverlay(zoom:Boolean):void
		{
			var p:Point = pane.fromLatLngToPaneCoords(_latLon,true);
			_target.x = p.x - _target.width/2;
			_target.y = p.y - _target.height/2;
		}
		
		
		/**
		 * 
		 * Event handlers
		 * 
		 */
		
		private function handleMapEvents(event:MapEvent):void
		{
			switch (event.type)
			{
				case MapEvent.OVERLAY_ADDED:
					addChild(_target);
					break;
				
				case MapEvent.OVERLAY_REMOVED:
					removeChild(_target);
			}
		}
		
		private function handleMouseEvents(event:MouseEvent):void
		{			
			switch (event.type)
			{
				case MouseEvent.MOUSE_OVER:
						_target.magnitude = 2;
						openInfoWindow(new InfoWindowOptions(
							{
								contentHTML: _infoWindowHTML,
								cornerRadius: 10,
								tailWidth: 25,
								hasCloseButton: false			
							}
						 ) );

					break;
					
				case MouseEvent.MOUSE_OUT:
					closeInfoWindow();
					_target.magnitude = 1;
					break;
			}
		}
	}
}