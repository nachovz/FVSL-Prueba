package com.stc.maps.vo
{
	import mx.collections.ArrayCollection;
	
	[Bindable]
	public class CatalogValueVO
	{
		public static const COUNTRIES : String = "countries";
		public static const ORGANIZATION_TYPE : String = "types";
		public static const FINANCY : String = "financy";
		public static const APPROACHES : String = "approaches";
		public static const AWARDS : String = "awards";
		public static const TYPES : String = "types";
		public static const STATES : String = "states";
		public static const BENEFICIARIES : String = "beneficiaries";
		public static const AREAS : String = "areas";
		
		public var id : Number = 0;
		public var label : String = "";
		public var isSelected : Boolean;
	}
}