package com.stc.maps.vo
{
	import mx.collections.ArrayCollection;
	
	public class NetworkVO extends EntityVO
	{
		public var entities : ArrayCollection;
		public var nodes : ArrayCollection;
		public var parentType : String;
		
		public function setNodesObjects(nodes : ArrayCollection) : void
		{
			var results : ArrayCollection = null;
			if(nodes && nodes.length>0)
			{
				results = new ArrayCollection();
				for each(var obj : Object in nodes)
				{
					var entity : EntityVO = new EntityVO();
					entity.data = obj;
					if(entity.id!=0) results.addItem(entity);
				}
			}
			
			this.nodes = results;
		}	

		override public function clone():Object{
			var newEntityVO:NetworkVO 		=	new NetworkVO;
			newEntityVO.type				=	this.type;
			newEntityVO.title				=	this.title; 
			newEntityVO.id					=	this.id;
			newEntityVO.lat					=	this.lat;
			newEntityVO.long				=	this.long;
			newEntityVO.direction			=	this.direction;
			newEntityVO.webURL				=	this.webURL;
			newEntityVO.objective			=	this.objective;
			newEntityVO.email				=	this.email;
			newEntityVO.phone				=	this.phone;
			newEntityVO.imageData			=	this.imageData;
			newEntityVO.geograficalFocus	=	this.geograficalFocus;
			newEntityVO.organizationType	=	this.organizationType;
			newEntityVO.financy				=	this.financy;
			
			newEntityVO.awards				=	this.awards;
			newEntityVO.beneficiaries		=	this.beneficiaries;
			newEntityVO.interventionAreas	=	this.interventionAreas;
			
			newEntityVO.nodes 				=	new ArrayCollection;
			for(var i :int=0; i<this.nodes.length; i++){
				var auxOldEnt:EntityVO = this.nodes[i] as EntityVO;
				var auxEnt:EntityVO = auxOldEnt.clone() as EntityVO;
				newEntityVO.nodes.addItem(auxEnt);
			}
			newEntityVO.parentType 			=	this.parentType;
			newEntityVO.entities 			=	this.entities;
			
			return newEntityVO;
		}
		
		
	}
}