package com.stc.maps.view.components.map.specialmarkers
{
	import com.google.maps.LatLng;
	import com.google.maps.overlays.Marker;
	import com.google.maps.overlays.MarkerOptions;
	
	public class MarkerWithData extends Marker
	{
		private var _data:Object;
		
		public function MarkerWithData(arg0:LatLng, arg1:MarkerOptions=null)
		{
			super(arg0, arg1);
		}
		
		public function get data():Object{
			return _data;
		}
		public function set data(value:Object):void{
			_data = value;
		}
	}
}