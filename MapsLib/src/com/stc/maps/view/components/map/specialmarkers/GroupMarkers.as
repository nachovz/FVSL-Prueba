package com.stc.maps.view.components.map.specialmarkers
{
	import com.google.maps.LatLng;
	import com.google.maps.overlays.Marker;
	import com.google.maps.overlays.MarkerOptions;
	
	public class GroupMarkers extends Marker
	{
		private var _allMakersGrouped:Array;
		
		public function GroupMarkers(arg0:LatLng, arg1:MarkerOptions=null)
		{
			super(arg0, arg1);
		}
		
		public function get allMakers():Array{
			return _allMakersGrouped;
		}
		public function set allMarkers(value:Array):void{
			_allMakersGrouped = value;
		}
	}
}