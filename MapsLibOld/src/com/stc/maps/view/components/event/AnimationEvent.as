package com.stc.maps.view.components.event
{
	import flash.events.Event;

	public class AnimationEvent extends Event
	{
		public static const ANIMATION_COMPLETE : String = "animationComplete";
		
		public function AnimationEvent(type:String)
		{
			super(type, true, true);
		}
		
	}
}