package com.stc.maps.vo
{
	import mx.collections.ArrayCollection;
	
	[Bindable]
	public class FilterOptionVO
	{
		public static const COUNTRY : String = "country";
		public static const ORGANIZATION_TYPE : String = "organization_type";
		public static const FINANCY : String = "financy";
		public static const ENFOQUE_GEOGRAFICO : String = "enfoque_geografico";
		public static const BENEFICIARIO : String = "beneficiary";
		
		public var id : Number = 0;
		public var label : String = "";
	}
}