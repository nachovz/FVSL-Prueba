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

	}
}