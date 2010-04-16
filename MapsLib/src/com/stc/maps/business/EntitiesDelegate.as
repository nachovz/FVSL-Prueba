package com.stc.maps.business
{
	import com.stc.maps.event.EntitiesEvent;
	import com.stc.maps.vo.EntityVO;
	import com.stc.maps.vo.NetworkVO;
	import com.universalmind.cairngorm.business.Delegate;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	
	public class EntitiesDelegate extends Delegate
	{
		public function EntitiesDelegate(commandHandlers:IResponder, 
                                                          serviceName:String)
        {
            super(commandHandlers, serviceName);
        }
		
		public function getEntityList(event : EntitiesEvent ):void
		{
			var arrayEntities : ArrayCollection;
			
			switch(event.entityType)
			{
				case EntityVO.COOPERANT:
					arrayEntities = cooperantTest();
				break;
				case EntityVO.COMPANY:
					arrayEntities = cooperantTest();
				break;
				case EntityVO.ODS:
					arrayEntities = odsTest();
				break;
				case EntityVO.NETWORK:
					arrayEntities = networkTest();
				break;
			}

			
			var ev : ResultEvent = new ResultEvent(ResultEvent.RESULT,false,true,arrayEntities);
			
			event.callbacks.result(ev);
		}
		
		private function cooperantTest() : ArrayCollection
		{
			var arrayEntities : ArrayCollection = new ArrayCollection();
			
			var aux : EntityVO = new EntityVO();
			aux.lat = 7.588063;
			aux.long = -66.637659;
			aux.iconURL = "com/assets/markers/home.png";
			aux.title = "Empresas Polar";
			aux.type = EntityVO.COOPERANT;
			arrayEntities.addItem(aux);

			var aux : EntityVO = new EntityVO();
			aux.lat = 8.899932;
			aux.long = -68.964249;
			aux.iconURL = "com/assets/markers/home.png";
			aux.type = EntityVO.COOPERANT;
			aux.title = "Fundana";
			arrayEntities.addItem(aux);

			var aux : EntityVO = new EntityVO();
			aux.lat = 9;
			aux.long = -68.964249;
			aux.iconURL = "com/assets/markers/home.png";
			aux.type = EntityVO.COOPERANT;
			aux.title = "Clamor en el Barrio";
			arrayEntities.addItem(aux);
			
			return arrayEntities;
		}
		
		private function odsTest() : ArrayCollection
		{
			var arrayEntities : ArrayCollection = new ArrayCollection();
			
			var aux : EntityVO = new EntityVO();
			aux.lat = 5.588063;
			aux.long = -67.637659;
			aux.iconURL = "com/assets/markers/university.png";
			aux.title = "Fe y Alegria";
			aux.type = EntityVO.ODS;
			arrayEntities.addItem(aux);

			var aux : EntityVO = new EntityVO();
			aux.lat = 6.899932;
			aux.long = -69.964249;
			aux.iconURL = "com/assets/markers/university.png";
			aux.type = EntityVO.ODS;
			aux.title = "Daniela Chepard";
			arrayEntities.addItem(aux);

			var aux : EntityVO = new EntityVO();
			aux.lat = 10;
			aux.long = -67.964249;
			aux.iconURL = "com/assets/markers/university.png";
			aux.type = EntityVO.ODS;
			aux.title = "Ana Frank";
			arrayEntities.addItem(aux);
			
			var aux : EntityVO = new EntityVO();
			aux.lat = 5;
			aux.long = -67.637659;
			aux.iconURL = "com/assets/markers/university.png";
			aux.title = "FUNDANA";
			aux.type = EntityVO.ODS;
			arrayEntities.addItem(aux);

			var aux : EntityVO = new EntityVO();
			aux.lat = 6;
			aux.long = -67.964249;
			aux.iconURL = "com/assets/markers/university.png";
			aux.type = EntityVO.ODS;
			aux.title = "ANAUCO";
			arrayEntities.addItem(aux);

			var aux : EntityVO = new EntityVO();
			aux.lat = 10;
			aux.long = -67;
			aux.iconURL = "com/assets/markers/university.png";
			aux.type = EntityVO.ODS;
			aux.title = "Fundacion Polar";
			arrayEntities.addItem(aux);
			
			return arrayEntities;
		}
		
		private function networkTest() : ArrayCollection
		{
			var arrayEntities : ArrayCollection = new ArrayCollection();
			
			var aux : NetworkVO = new NetworkVO();
			aux.lat = 5.588063;
			aux.long = -67.637659;
			aux.iconURL = "com/assets/markers/museum-science.png";
			aux.title = "Fe y Alegria";
			aux.type = EntityVO.NETWORK;
			aux.nodes = new ArrayCollection();
			
			var aux2 : EntityVO = new EntityVO();
			aux2.lat = 6.899932;
			aux2.long = -69.964249;
			aux2.iconURL = "com/assets/markers/university.png";
			aux2.type = EntityVO.ODS;
			aux2.title = "Daniela Chepard";
			aux.nodes.addItem(aux2);

			var aux2 : EntityVO = new EntityVO();
			aux2.lat = 10;
			aux2.long = -67.964249;
			aux2.iconURL = "com/assets/markers/university.png";
			aux2.type = EntityVO.ODS;
			aux2.title = "Ana Frank";
			aux.nodes.addItem(aux2);
			
			arrayEntities.addItem(aux);

			var aux : NetworkVO = new NetworkVO();
			aux.lat = 6.899932;
			aux.long = -69.964249;
			aux.iconURL = "com/assets/markers/museum-science.png";
			aux.type = EntityVO.NETWORK;
			aux.title = "Clamor en el barrio";
			arrayEntities.addItem(aux);

			
			return arrayEntities;
		}
	}
}