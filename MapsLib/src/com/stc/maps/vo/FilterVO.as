package com.stc.maps.vo
{
	import mx.collections.ArrayCollection;
	
	public class FilterVO
	{
		public static const MULTIPLE : String 		= "multiple";
		public static const TEXT : String			= "text";
		public static const BOOLEAN : String 		= "boolean";
		public static const COMBO : String 			= "combo";
		public static const YESNO : String 			= "yesno";
		
		
		public var id : Number = 0;
		public var keyName : String = "";
		public var idDepentency : int = -1;
		public var label : String = "";
		public var type : String = "";
		public var options : ArrayCollection;

	}
}