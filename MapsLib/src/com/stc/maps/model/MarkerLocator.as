package com.stc.maps.model
{
	import com.adobe.cairngorm.model.IModelLocator;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	
	import mx.controls.SWFLoader;
	import mx.core.Container;
	import mx.core.IChildList;

	[Bindable]
	public class MarkerLocator implements com.adobe.cairngorm.model.IModelLocator
	{
		private static var markerLocator 	:com.stc.maps.model.MarkerLocator;
		private static var _theSWF 			:SWFLoader;
		
		public static function getInstance() : com.stc.maps.model.MarkerLocator
		{
			if ( markerLocator == null ){
				markerLocator = new com.stc.maps.model.MarkerLocator();
				_theSWF = new SWFLoader();
				_theSWF.addEventListener(Event.COMPLETE,loadCompleteEvent,false,0,true);
				_theSWF.addEventListener(IOErrorEvent.IO_ERROR,ioErrorEvent,false,0,true);
				_theSWF.load("com/assets/markers/markers.swf");
				
			}
			
			return markerLocator;
		}
		
		public function MarkerLocator()
		{
			if ( MarkerLocator.markerLocator != null )
				throw new Error( "Only one MarkerLocator instance should be instantiated" );	
		}
		
		private static function loadCompleteEvent(event:Event):void{
			trace("SWF READY");
		}
		private static function ioErrorEvent(event:IOErrorEvent):void{
			trace("Error Loading SWF");
		}
		
		public function getMarkerComponent(name:String = "singleFlag",color:uint = 0x0000FF ,withLabel:Boolean = false,theText:String = "0"):Container{
			var auxContainer:Container = new Container;
			auxContainer.width = 25;
			auxContainer.height = 32;
			auxContainer.rawChildren.addChild(_theSWF['content'].getInstance(name ,color ,1 ));
			if(withLabel){
				var auxRawChildren:IChildList = auxContainer.rawChildren;
				var auxMC:MovieClip = MovieClip(auxRawChildren.getChildAt(0))
				_theSWF['content'].labelText(auxMC ,theText)
			}
			return auxContainer;
		}
		
		public function changeColor(color:uint,alphaNumber:uint,theContainer:Container):void{
			var auxRawChildren:IChildList = theContainer.rawChildren;
			var auxMC:MovieClip = MovieClip(auxRawChildren.getChildAt(0))
			_theSWF['content'].changeColor(color,alphaNumber,auxMC);
		}
		public function changeLabel(theContainer:Container,theText:String,textColor:uint):void{
			var auxRawChildren:IChildList = theContainer.rawChildren;
			var auxMC:MovieClip = MovieClip(auxRawChildren.getChildAt(0))
			_theSWF['content'].labelText(auxMC ,theText,textColor)
		}
		
		
	}
}