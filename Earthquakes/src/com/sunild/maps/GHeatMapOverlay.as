package com.sunild.maps
{
	import com.google.maps.Map;
	import com.google.maps.MapEvent;
	import com.google.maps.PaneId;
	import com.google.maps.interfaces.IMap;
	import com.google.maps.interfaces.IPane;
	import com.google.maps.overlays.OverlayBase;
	import com.michaelvandaniker.visualization.HeatMap;
	
	import flash.events.Event;
	
	
	public class GHeatMapOverlay extends OverlayBase
	{
		public var heatMap:HeatMap;
		
		public function GHeatMapOverlay(heatMap:HeatMap)
		{
			super();
			this.heatMap = heatMap;
			addEventListener(MapEvent.OVERLAY_ADDED, handleOverlayAdded,false,0,true);
			addEventListener(MapEvent.OVERLAY_REMOVED, handleOverlayRemoved,false,0,true);
		}
		
		
		/**
		 * 
		 * Overrides
		 * 
		 */
		
		override public function getDefaultPane(map:IMap):IPane
		{
			return map.getPaneManager().getPaneById(PaneId.PANE_OVERLAYS);
		}
		
		override public function positionOverlay(zoom:Boolean):void
		{
			if (zoom)
			{
				heatMap.itemRadius = Math.max(20, Math.pow( pane.map.getZoom(),1.5));
			}
			
			// positioned at (0,0) by default
			heatMap.width = (pane.map as Map).width;
			heatMap.height = (pane.map as Map).height;
			
			heatMap.invalidateProperties();
		}
		
		
		/**
		 * 
		 * Event handlers
		 * 
		 */
		
		private function handleOverlayAdded(event:Event):void
		{
			addChild(heatMap);
		}
		
		private function handleOverlayRemoved(event:Event):void
		{
			removeChild(heatMap);
		}
	}
}