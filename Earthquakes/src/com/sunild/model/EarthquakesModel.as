package com.sunild.model
{
	import com.adobe.cairngorm.model.IModelLocator;
	import com.michaelvandaniker.visualization.GradientDictionary;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	public class EarthquakesModel implements IModelLocator
	{
		private static var instance:EarthquakesModel;
		
		public function EarthquakesModel(enforcer:SingletonEnforcer)
		{
			if (enforcer == null) {
				throw new Error( "This class is a singleton, please use the getInstance method to return the instance." );
			}
		}
		
		public static function getInstance():EarthquakesModel
		{
			if (instance == null)
			{
				instance = new EarthquakesModel(new SingletonEnforcer);
			} 
			return instance;
		}
		
		
		/**
		 * 
		 * Model Data
		 * 
		 */
		
		
		// data sources from USGS and local copies
		public static const DATA_SOURCES:Array = [
			{
				label: "Magnitude 2.5+, last day",
				url: "http://earthquake.usgs.gov/eqcenter/catalogs/1day-M2.5.xml"
			},
			{
				label: "Magnitude 2.5+, last 7 days",
				url: "http://earthquake.usgs.gov/eqcenter/catalogs/7day-M2.5.xml"
			},
			{
				label: "Magnitude 5+, last 7 days",
				url: "http://earthquake.usgs.gov/eqcenter/catalogs/7day-M5.xml"
			}
		];
		
		/*
		public static const DATA_SOURCES:Array = [
			{
				label: "Local: M 2.5+, last day",
				url: "1day-M2.5.xml"
			},
			{
				label: "Local: M 2.5+, last 7 days",
				url: "7day-M2.5.xml"
			},
			{
				label: "Local: M 5+, last 7 days",
				url: "7day-M5.xml"
			}
		];
		*/
		
		public static const GRADIENT_LIST:Array = [
			{ label: "Rainbow", value: GradientDictionary.RAINBOW },
			{ label: "Thermal", value: GradientDictionary.THERMAL },
			{ label: "Red-White-Blue", value: GradientDictionary.RED_WHITE_BLUE }
		];
		
		// selected data source
		public var selectedSource:int = 1;
		public var selectedUrl:String = DATA_SOURCES[selectedSource].url;
		
		// earthquake data
		public var earthquakeVOs:ArrayCollection = new ArrayCollection();
		
		// a list of map markers for each earthquakeVO
		public var mapMakers:Array = [];
				
		
	}
}

// Utility class to deny access to Constructor (this class isn't accessible
// outside of this file)
class SingletonEnforcer {}