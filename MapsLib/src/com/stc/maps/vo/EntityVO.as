package com.stc.maps.vo
{
	import mx.collections.ArrayCollection;
 	import flash.utils.ByteArray; 
/* 	import flash.utils.ByteArray; */
	
	[Bindable]
	public class EntityVO
	{
		public static const COOPERANT : String 	= "cooperant";
		public static const COMPANY : String	= "company";
		public static const ODS : String 		= "ods";
		public static const NETWORK : String 	= "network";
		
		
		public var id : Number = 0;
		public var lat : Number = 0;
		public var long : Number = 0;
		public var iconURL : String = "";
		public var title : String = "";
		public var networksIds : ArrayCollection;
		public var type : String;
		public var imageData : ByteArray;

		public var facebookLink : String = "";
		public var twitterLink : String = "";
		public var logoURL : String = "";
		public var objective : String = "";
		public var direction : String = "";
		public var webURL : String = "";
		public var phone : String = "";
		public var email : String = "";

		public var awards : ArrayCollection;
		public var beneficiaries : ArrayCollection;
		public var interventionAreas : ArrayCollection;
		public var geograficalFocus : String = "";
		public var organizationType : String = "";
		public var financy : String = "";
		
		[Transient]
		public var visibilityByCheckBox:Boolean = true;
		[Transient]
		public var org:String;

		[Transient]
		public var marker : Object;
		[Transient]
		public var isSelected : Boolean = true;
		
		public function set data(obj : Object) : void
		{
			this.type = obj.type;
			this.title = obj.name;
			this.id = obj.id;
			this.lat = Number(obj.latitude.replace(",", "."));
			this.long = Number(obj.longitude.replace(",", "."));
			this.direction = obj.direction;
			this.webURL = obj.website;
			this.objective = obj.objective;
			this.email = obj.email;
			this.phone = obj.phone;
			this.imageData = obj.imgdata;
			this.geograficalFocus = obj.enfoque;
			this.organizationType = obj.tipoOrganizacion;
			this.financy = (Number(obj.financia)==0) ? "No" : "Si";

			this.awards = obj.awards;
			this.beneficiaries = obj.beneficiarios;
			this.interventionAreas = obj.areas;
		}
		
		public function totalNetworks() : int
		{
			if(networksIds)
			{
				return networksIds.length;
			}
			else 
				return 0;
		}
		
		public function clone():Object{
			var newEntityVO:EntityVO 		=	new EntityVO;
			newEntityVO.type				=	this.type;
			newEntityVO.title				=	this.title; 
			newEntityVO.id					=	this.id;
			newEntityVO.lat					=	this.lat;
			newEntityVO.long				=	this.long;
			newEntityVO.direction			=	this.direction;
			newEntityVO.webURL				=	this.webURL;
			newEntityVO.objective			=	this.objective;
			newEntityVO.email				=	this.email;
			newEntityVO.visibilityByCheckBox				=	this.visibilityByCheckBox;
			newEntityVO.org				=	this.org;
			newEntityVO.phone				=	this.phone;
			newEntityVO.imageData			=	this.imageData;
			newEntityVO.geograficalFocus	=	this.geograficalFocus;
			newEntityVO.organizationType	=	this.organizationType;
			newEntityVO.financy				=	this.financy;
			
			newEntityVO.awards				=	this.awards;
			newEntityVO.beneficiaries		=	this.beneficiaries;
			newEntityVO.interventionAreas	=	this.interventionAreas;
			
			return newEntityVO;
		}
	}
}