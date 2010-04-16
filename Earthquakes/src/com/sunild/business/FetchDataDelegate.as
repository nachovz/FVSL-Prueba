package com.sunild.business
{
	import com.adobe.cairngorm.business.ServiceLocator;
	import com.sunild.model.EarthquakesModel;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	public class FetchDataDelegate
	{
		private var responder:IResponder;
		private var service:Object;
		
		public function FetchDataDelegate(responder:IResponder)
		{
			this.responder = responder;
			this.service = ServiceLocator.getInstance().getHTTPService("earthquakeData");
		}
		
		public function fetchData():void
		{
			var token:AsyncToken = service.send();
			token.addResponder(responder);
		}

	}
}