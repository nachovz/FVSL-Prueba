package com.stc.maps.business
{
	import com.stc.maps.event.EntitiesEvent;
	import com.stc.maps.vo.EntityVO;
	import com.stc.maps.vo.NetworkVO;
	import com.universalmind.cairngorm.business.Delegate;
	import com.universalmind.cairngorm.business.ServiceLocator;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.soap.WebService;
	
	public class EntitiesDelegate extends Delegate
	{
		private var _service : WebService;
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
					getAllCooperants();
				break;
				case EntityVO.COMPANY:
					//getAllODS();
				break;
				case EntityVO.ODS:
					getAllODS();
				break;
				case EntityVO.NETWORK:
					getAllNetworks();
				break;
			}

			
			//var ev : ResultEvent = new ResultEvent(ResultEvent.RESULT,false,true,arrayEntities);
			
			//event.callbacks.result(ev);
		}
		
		public function getEntityDetails(event : EntitiesEvent ):void
		{
			var arrayEntities : ArrayCollection;
			
			switch(event.entityType)
			{
				case EntityVO.COOPERANT:
					getCooperantDetails(event);
				break;
				case EntityVO.COMPANY:
					getCompanyDetails(event);
				break;
				case EntityVO.ODS:
					getODSDetails(event);
				break;
			}

			
			//var ev : ResultEvent = new ResultEvent(ResultEvent.RESULT,false,true,arrayEntities);
			
			//event.callbacks.result(ev);
		}
		
		private function getAllCooperants() : void
		{
            _service = ServiceLocator.getInstance().getWebService("cooperantsWS");
			var token:AsyncToken = this._service.GetAllCooperants();
			token.addResponder(this.responder);
		}
		
		private function getCooperantDetails(event : EntitiesEvent) : void
		{
            _service = ServiceLocator.getInstance().getWebService("cooperantsWS");
			var token:AsyncToken = this._service.getCooperantDetails(event.entityId);
			token.addResponder(this.responder);
		}
		
		private function getCompanyDetails(event : EntitiesEvent) : void
		{
            _service = ServiceLocator.getInstance().getWebService("companyWS");
			var token:AsyncToken = this._service.GetCompanyDetails(event.entityId);
			token.addResponder(this.responder);
		}
		
		private function getODSDetails(event : EntitiesEvent) : void
		{
            _service = ServiceLocator.getInstance().getWebService("odsWS");
			var token:AsyncToken = this._service.getODSDetails(event.entityId);
			token.addResponder(this.responder);
		}

		private function getAllODS() : void
		{
            _service = ServiceLocator.getInstance().getWebService("odsWS");
			var token:AsyncToken = this._service.GetAllODS();
			token.addResponder(this.responder);
		}

		private function getAllNetworks() : void
		{
            _service = ServiceLocator.getInstance().getWebService("networkWS");
			var token:AsyncToken = this._service.GetAllNetworks();
			token.addResponder(this.responder);
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
			aux.email = "info@feyalegria.com";
			aux.direction = "Macaracuay, Calle Santa Marta.";
			aux.logoURL = "assets/logos/polar.jpg";
			aux.objective = "El objetivo de Empresas Polar es lograr la eliminacion de la pobreza en todos los estractos de la sociedad. Para lo grar eso se ha puesto como meta la elaboracion de un plan de nutricion nacional.";
			aux.phone = "23232323";
			aux.webURL = "www.estaeslapaginaweb.com";
			aux.type = EntityVO.ODS;
			arrayEntities.addItem(aux);

			var aux : EntityVO = new EntityVO();
			aux.lat = 6.899932;
			aux.long = -69.964249;
			aux.iconURL = "com/assets/markers/university.png";
			aux.type = EntityVO.ODS;
			aux.title = "Daniela Chepard";
			aux.email = "info@feyalegria.com";
			aux.direction = "Macaracuay, Calle Santa Marta.";
			aux.logoURL = "assets/logos/polar.jpg";
			aux.objective = "El objetivo de Empresas Polar es lograr la eliminacion de la pobreza en todos los estractos de la sociedad. Para lo grar eso se ha puesto como meta la elaboracion de un plan de nutricion nacional.";
			aux.phone = "23232323";
			aux.webURL = "www.estaeslapaginaweb.com";
			arrayEntities.addItem(aux);

			var aux : EntityVO = new EntityVO();
			aux.lat = 10;
			aux.long = -67.964249;
			aux.iconURL = "com/assets/markers/university.png";
			aux.type = EntityVO.ODS;
			aux.title = "Ana Frank";
			aux.email = "info@feyalegria.com";
			aux.direction = "Macaracuay, Calle Santa Marta.";
			aux.logoURL = "assets/logos/polar.jpg";
			aux.objective = "El objetivo de Empresas Polar es lograr la eliminacion de la pobreza en todos los estractos de la sociedad. Para lo grar eso se ha puesto como meta la elaboracion de un plan de nutricion nacional.";
			aux.phone = "23232323";
			aux.webURL = "www.estaeslapaginaweb.com";
			arrayEntities.addItem(aux);
			
			var aux : EntityVO = new EntityVO();
			aux.lat = 5;
			aux.long = -67.637659;
			aux.iconURL = "com/assets/markers/university.png";
			aux.title = "FUNDANA";
			aux.type = EntityVO.ODS;
			aux.email = "info@feyalegria.com";
			aux.direction = "Macaracuay, Calle Santa Marta.";
			aux.logoURL = "assets/logos/polar.jpg";
			aux.objective = "El objetivo de Empresas Polar es lograr la eliminacion de la pobreza en todos los estractos de la sociedad. Para lo grar eso se ha puesto como meta la elaboracion de un plan de nutricion nacional.";
			aux.phone = "23232323";
			aux.webURL = "www.estaeslapaginaweb.com";
			arrayEntities.addItem(aux);

			var aux : EntityVO = new EntityVO();
			aux.lat = 6;
			aux.long = -67.964249;
			aux.iconURL = "com/assets/markers/university.png";
			aux.type = EntityVO.ODS;
			aux.title = "ANAUCO";
			aux.email = "info@feyalegria.com";
			aux.direction = "Macaracuay, Calle Santa Marta.";
			aux.logoURL = "assets/logos/polar.jpg";
			aux.objective = "El objetivo de Empresas Polar es lograr la eliminacion de la pobreza en todos los estractos de la sociedad. Para lo grar eso se ha puesto como meta la elaboracion de un plan de nutricion nacional.";
			aux.phone = "23232323";
			aux.webURL = "www.estaeslapaginaweb.com";
			arrayEntities.addItem(aux);

			var aux : EntityVO = new EntityVO();
			aux.lat = 10;
			aux.long = -67;
			aux.iconURL = "com/assets/markers/university.png";
			aux.type = EntityVO.ODS;
			aux.title = "Fundacion Polar";
			aux.email = "info@polar.com";
			aux.direction = "La California, Calle Santa Marta.";
			aux.logoURL = "assets/logos/polar.jpg";
			aux.objective = "Este es el objetivo de la empresa";
			aux.phone = "345345345";
			aux.webURL = "www.estaeslapaginaweb.com";
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