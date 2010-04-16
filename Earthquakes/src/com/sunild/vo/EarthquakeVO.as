package com.sunild.vo
{
	import com.google.maps.LatLng;
	
	
	public class EarthquakeVO
	{
		public var id:String;
		public var title:String;
		public var magnitude:Number;
		public var updated:String;
		public var link:String;
		public var summaryHtml:String;
		public var latLon:LatLng;
		public var elevation:Number;
		public var age:String;
		
		public function EarthquakeVO()
		{
		}

	}
}