package com.stc.maps.view.components.map.mapplugins
{
	import mx.controls.ToggleButtonBar;
	import mx.core.IFlexDisplayObject;
	
	public class MapToggleButtonBar extends ToggleButtonBar
	{
		
	
		public function MapToggleButtonBar()
		{
			super();
		}
		
		override protected function createNavItem(label:String, icon:Class = null):IFlexDisplayObject 
		{ 
			return super.createNavItem(label,icon);
		} 
	}
}