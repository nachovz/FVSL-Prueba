package com.stc.maps.view.components.map.specialmarkers
{
	import com.google.maps.InfoWindowOptions;
	import com.google.maps.LatLng;
	import com.google.maps.Map;
	import com.google.maps.MapEvent;
	import com.google.maps.MapMouseEvent;
	import com.google.maps.interfaces.IInfoWindow;
	import com.google.maps.interfaces.IPane;
	import com.google.maps.overlays.Marker;
	import com.google.maps.overlays.MarkerOptions;
	import com.stc.maps.view.components.map.mapplugins.InfoWindowWithEffects;
	import com.stc.maps.view.components.map.utils.ListGroupedFlags;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	import mx.collections.ArrayCollection;
	import mx.core.Application;
	import mx.core.UIComponent;
	import mx.events.EffectEvent;
	import mx.events.IndexChangedEvent;
	import mx.managers.PopUpManager;
	
	public class GroupMarkers extends Marker
	{
		private var _allMakersGrouped:Array;
		private var _allMakersGroupedEntityVO:Array;
		private var _visibleAll:Boolean = false;
		private var _time:Timer = new Timer(800,1);
		private var _timeInfo:Timer = new Timer(800,1);
		private var _timeStartInfo:Timer = new Timer(2000,1);
		private var infoWindow:IInfoWindow = null;
		
		public function GroupMarkers(arg0:LatLng, arg1:MarkerOptions=null)
		{
			super(arg0, arg1);
			addEventListener(MapMouseEvent.ROLL_OVER,mouseOverEventHandler,false,0,true);
			addEventListener(MapMouseEvent.ROLL_OUT,mouseOutEventHandler,false,0,true);
			_time.addEventListener(TimerEvent.TIMER,timerEventHandler,false,0,true);
			_timeInfo.addEventListener(TimerEvent.TIMER,closeInfoWindowEventHandler,false,0,true);
			_timeStartInfo.addEventListener(TimerEvent.TIMER,closeInfoWindowEventHandler,false,0,true);
		}
		
		public function get allMakers():Array{
			return _allMakersGrouped;
		}
		public function set allMarkers(value:Array):void{
			_allMakersGrouped = value;
		}
		public function get allEntitys():Array{
			return _allMakersGroupedEntityVO;
		}
		public function set allEntitys(value:Array):void{
			_allMakersGroupedEntityVO = value;
		}
		
		public function set visibleAll(value:Boolean):void{
			_visibleAll = value;
		}
		public function get VisibleAll():Boolean{
			return _visibleAll;
		}
		
		protected function mouseOverEventHandler(event:MapMouseEvent):void{
			trace("Mouse Over Group Marker");
			_time.reset();
			_time.start();
		}
		private var infoWindowWithEffects:InfoWindowWithEffects = new InfoWindowWithEffects; 
		protected function timerEventHandler(event:TimerEvent):void{
			trace("Timer TICK");
			infoWindowWithEffects = new InfoWindowWithEffects; 
			var options:InfoWindowOptions=new InfoWindowOptions();
			options.customContent=infoWindowWithEffects;
			options.hasShadow=false;
			options.drawDefaultFrame=false;
			options.hasCloseButton=false;
			options.width = 151;
			options.height = 52;
			options.customOffset = new Point(151/2,80);
			
			
			infoWindow = this.openInfoWindow(options,false);
			infoWindowWithEffects.addEventListener(MouseEvent.MOUSE_OVER,infoWindowMosueOverHandler,false,0,true);
			infoWindowWithEffects.addEventListener(MouseEvent.MOUSE_OUT,infoWindowMosueOutHandler,false,0,true);
			infoWindowWithEffects.addEventListener(InfoWindowWithEffects.ZOOM_IN,zoomInEventHandler,false,0,true);
			infoWindowWithEffects.addEventListener(InfoWindowWithEffects.LIST_GROUPED_FLAGS,showListEventHandler,false,0,true);
			_timeStartInfo.reset();
			_timeStartInfo.start();
		}
		
		override public function openInfoWindow(arg0:InfoWindowOptions=null, arg1:Boolean=false):IInfoWindow{
			
			return super.openInfoWindow(arg0,arg1);
			
		}
		protected function mouseOutEventHandler(event:MapMouseEvent):void{
			trace("Mouse Out Group Marker");
			_time.stop();
			_time.reset();
			
		}
		
		protected function infoWindowMosueOverHandler(event:MouseEvent):void{
			trace("1-. Info Window Mouse Over Group Marker");
			if(_timeStartInfo.running){
				_timeStartInfo.stop();
				_timeStartInfo.reset();
			}
			_timeInfo.stop();
			_timeInfo.reset();
			
		}
		
		protected function infoWindowMosueOutHandler(event:MouseEvent):void{
			trace("2-. Info Window Mouse Out Group Marker");
			_timeInfo.reset();
			_timeInfo.start();
		}
		private var auxInfoWindowWithEffects:InfoWindowWithEffects;
		protected function closeInfoWindowEventHandler(event:TimerEvent):void{
			trace("Timer TICK Close Info Window");
			if(infoWindowWithEffects){
				infoWindowWithEffects.removeEventListener(MouseEvent.MOUSE_OVER,infoWindowMosueOverHandler);
				infoWindowWithEffects.removeEventListener(MouseEvent.MOUSE_OUT,infoWindowMosueOutHandler);
				infoWindowWithEffects.removeEventListener(InfoWindowWithEffects.ZOOM_IN,zoomInEventHandler);
				infoWindowWithEffects.removeEventListener(InfoWindowWithEffects.LIST_GROUPED_FLAGS,showListEventHandler);
				infoWindowWithEffects.addEventListener(EffectEvent.EFFECT_END,closeEventEnded,false,0,true);
				infoWindowWithEffects.visible = false;
				auxInfoWindowWithEffects = infoWindowWithEffects;
				infoWindowWithEffects = null;
			}
			
		}
		
		protected function closeEventEnded(event:EffectEvent):void{
			trace("Close Info Window");
			auxInfoWindowWithEffects.removeEventListener(EffectEvent.EFFECT_END,closeEventEnded);
			this.closeInfoWindow();
			auxInfoWindowWithEffects = null;
		}
		
		protected function zoomInEventHandler(event:Event):void{
			trace("Zoom In From Group Marker");
			event.stopImmediatePropagation();
			closeKnowInfoPanel();
			var myPanel:IPane = pane;
			myPanel.map.zoomIn(getLatLng());
		}
		protected function showListEventHandler(event:Event):void{
			trace("Show List From Group Marker");
			event.stopImmediatePropagation();
			closeKnowInfoPanel();
			var listGroupedFlags:ListGroupedFlags = new ListGroupedFlags;
			listGroupedFlags.dataProvider = new ArrayCollection(_allMakersGrouped);
			PopUpManager.addPopUp(listGroupedFlags,Application.application as DisplayObject);
			PopUpManager.centerPopUp(listGroupedFlags);
		}
		
		
		private function closeKnowInfoPanel():void{
			if(infoWindowWithEffects){
				infoWindowWithEffects.removeEventListener(MouseEvent.MOUSE_OVER,infoWindowMosueOverHandler);
				infoWindowWithEffects.removeEventListener(MouseEvent.MOUSE_OUT,infoWindowMosueOutHandler);
				infoWindowWithEffects.removeEventListener(EffectEvent.EFFECT_END,closeEventEnded);
				infoWindowWithEffects.removeEventListener(InfoWindowWithEffects.ZOOM_IN,zoomInEventHandler);
				infoWindowWithEffects.removeEventListener(InfoWindowWithEffects.LIST_GROUPED_FLAGS,showListEventHandler);
				infoWindowWithEffects = null;
			}
			if(auxInfoWindowWithEffects){
				auxInfoWindowWithEffects.removeEventListener(MouseEvent.MOUSE_OVER,infoWindowMosueOverHandler);
				auxInfoWindowWithEffects.removeEventListener(MouseEvent.MOUSE_OUT,infoWindowMosueOutHandler);
				auxInfoWindowWithEffects.removeEventListener(EffectEvent.EFFECT_END,closeEventEnded);
				auxInfoWindowWithEffects.removeEventListener(InfoWindowWithEffects.ZOOM_IN,zoomInEventHandler);
				auxInfoWindowWithEffects.removeEventListener(InfoWindowWithEffects.LIST_GROUPED_FLAGS,showListEventHandler);
				auxInfoWindowWithEffects = null;
			}
			this.closeInfoWindow();
		}
		
		
	}
}