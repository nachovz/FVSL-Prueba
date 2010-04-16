package com.sunild.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.google.maps.LatLng;
	import com.google.maps.overlays.Marker;
	import com.sunild.business.FetchDataDelegate;
	import com.sunild.view.EarthquakeMarker;
	import com.sunild.model.EarthquakesModel;
	import com.sunild.vo.EarthquakeVO;
	
	import mx.rpc.IResponder;

	public class FetchDataCommand implements ICommand, IResponder
	{
		private var _model:EarthquakesModel = EarthquakesModel.getInstance();
		
		public function FetchDataCommand()
		{
		}

		public function execute(event:CairngormEvent):void
		{
			var d:FetchDataDelegate = new FetchDataDelegate(this);
			d.fetchData();
		}
		
		public function result(data:Object):void
		{
			var x:XML = data.result;
			_model.earthquakeVOs.source = parseAtomFeed(x);
			_model.mapMakers = createMarkers();
		}
		
		public function fault(info:Object):void
		{
			trace(info);
		}
		
		private function parseAtomFeed(x:XML):Array
		{
			var ns:Namespace = new Namespace("http://www.w3.org/2005/Atom");
			var geo:Namespace = new Namespace("http://www.georss.org/georss");
			
			default xml namespace = ns;
			
			var list:Array = [];
			var pattern:RegExp = /M (\d+\.\d+),\s(.+)/;
			
			for each (var tmp:XML in x.entry)
			{
				var vo:EarthquakeVO = new EarthquakeVO();
				vo.id = tmp.id;
				vo.title =  String(tmp.title).replace(pattern, "$2");	
				vo.magnitude = Number( String(tmp.title).replace(pattern, "$1") );
				vo.updated = tmp.updated;
				vo.link = tmp.link.@href;
				vo.summaryHtml = tmp.summary;
				
				var point:String = tmp.geo::point;
				var points:Array = point.split(" ");
				vo.latLon = new LatLng(points[0],points[1]);
				vo.elevation = tmp.geo::elev;
				vo.age = tmp.category.@term;
				
				list.push(vo);
			}
			
			return list;
		}
		
		private function createMarkers():Array
		{
			var tmp:Array = [];
			
			for each (var vo:EarthquakeVO in _model.earthquakeVOs)
			{
				var eqMarker:EarthquakeMarker = new EarthquakeMarker(vo);
				
				tmp.push(eqMarker);
			}
			return tmp;
		}
		
	}
}