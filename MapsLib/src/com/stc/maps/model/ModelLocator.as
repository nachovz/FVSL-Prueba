package com.stc.maps.model
{
 	import com.adobe.cairngorm.model.IModelLocator;
 	
 	import flash.utils.Dictionary;
/*  	import flash.utils.Dictionary; */


 	[Bindable]
	public class ModelLocator implements com.adobe.cairngorm.model.IModelLocator
	{
		private static var modelLocator : com.stc.maps.model.ModelLocator;
		
		public static function getInstance() : com.stc.maps.model.ModelLocator
		{
			if ( modelLocator == null )
				modelLocator = new com.stc.maps.model.ModelLocator();
				
			return modelLocator;
	   }
	   
	   	public function ModelLocator() 
	   	{
	   		if ( ModelLocator.modelLocator != null )
					throw new Error( "Only one ModelLocator instance should be instantiated" );	
	   	}
		
		public var allEntities	:Array = [];
		
		public var entities 				:Dictionary = new Dictionary();
		public var filterOptions			:Dictionary = new Dictionary();
		public var searchFilters 			:Dictionary = new Dictionary();
		
	}	
}

