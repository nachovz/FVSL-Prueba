package com.stc.maps.vo
{
	import mx.collections.ArrayCollection;
	
	public class EntityVO
	{
		public static const COOPERANT : String 	= "cooperant";
		public static const COMPANY : String	= "company";
		public static const ODS : String 		= "ods";
		public static const NETWORK : String 		= "network";
		
		
		public var lat : Number = 0;
		public var long : Number = 0;
		public var iconURL : String = "";
		public var title : String = "";
		public var networksIds : ArrayCollection;
		public var type : String;

		public var facebookLink : String = "";
		public var twitterLink : String = "";
		public var logoURL : String = "";
		public var objective : String = "";
		public var direction : String = "";
		public var webURL : String = "";
		public var phone : String = "";
		public var email : String = "";

		[Transient]
		public var marker : Object;
		[Transient]
		public var isSelected : Boolean = true;
		
		public function totalNetworks() : int
		{
			if(networksIds)
			{
				return networksIds.length;
			}
			else 
				return 0;
		}
	}
}