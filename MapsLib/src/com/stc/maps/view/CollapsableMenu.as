package com.stc.maps.view
{
	import com.stc.maps.view.components.EntityRendererList;
	import com.stc.maps.view.components.LayoutAnimator;
	import com.stc.maps.view.components.LayoutTarget;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Image;
	import mx.controls.LinkButton;
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
/* 	import flash.events.MouseEvent; */
 	import flash.events.MouseEvent;

	public class CollapsableMenu extends UIComponent
	{
        //[Embed("com/assets/img/tools.png")]
        //private var toolsIcon:Class;	
		
		private var content : EntityRendererList = new EntityRendererList();
		private var expandButton : Image = new Image();
		
		private  var layoutAnimator : LayoutAnimator = new LayoutAnimator();
		private  var layoutTarget : LayoutTarget;
		
		private var _expandedWidth : Number;
		private var _expandedHeight : Number;
		private var expandButtonWidth : Number = 42;
		private var expandButtonHeight : Number = 169;
		private var contentWidth : Number = 50;
		private var contentHeight : Number = 100;
		private var expandButtonX : Number = 50;
		private var expandButtonY : Number = 100;
		
		private var collapsed : Boolean = false;
		
		private var _entities : ArrayCollection;
		
		public function set entities(value:ArrayCollection):void
		{
			if(value)
			{
				this._entities = value;
				
				invalidateProperties();
			}
		}
		
		public function get entities() : ArrayCollection
		{
			return _entities;
		}
		public function set expandedWidth(value:Number):void
		{
			this._expandedWidth = value;
		}
		
		public function get expandedWidth() : Number
		{
			return _expandedWidth;
		}

		public function set expandedHeight(value:Number):void
		{
			this._expandedHeight = value;
		}
		
		public function get expandedHeight() : Number
		{
			return _expandedHeight;
		}
		
		override public function set width(value:Number):void
		{
			super.width = value;
			contentHeight = value;
			expandButtonX = value;
		}

		override public function set height(value:Number):void
		{
			super.height = value;
			contentHeight = value;
			expandButtonY = value/2;
		}
		
		public function CollapsableMenu()
		{
			super();
		}
		
		public function generateLayout() : void
		{
			layoutTarget = layoutAnimator.targetFor(content);
			layoutTarget.unscaledWidth = Number(contentWidth);
			layoutTarget.unscaledHeight = Number(contentHeight);
			layoutTarget.alpha = 1;
			
			layoutTarget = layoutAnimator.targetFor(expandButton);
			layoutTarget.x = Number(expandButtonX);
			layoutTarget.y = Number(expandButtonY);
			layoutTarget.unscaledWidth = Number(expandButtonWidth);
			layoutTarget.unscaledHeight = Number(expandButtonHeight);
			layoutTarget.alpha = 1;
		}
		
		private function resizeToolbar(ev : MouseEvent=null) : void
		{
			if(collapsed)
			{
				collapsed = false;
				contentWidth = _expandedWidth;
				expandButtonX = _expandedWidth;
			}
			else
			{
				collapsed = true;
				contentWidth = 0;
				expandButtonX = 0;
			}
			
			layoutAnimator.animationSpeed = 0.1;
			layoutAnimator.invalidateLayout();
		}
		
		private function collapsableMenu_creationComplete(ev : FlexEvent) : void
		{
			resizeToolbar();
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			if(entities)
			{
				content.entities = entities;
			}
		}
		
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			layoutAnimator.layoutFunction = generateLayout;

			content.setStyle("backgroundColor","#FFFFFF");
			content.setStyle("borderColor","#FFFFFF");
			content.horizontalScrollPolicy = "off";
			content.verticalScrollPolicy = "off";
			
			expandButton.width = expandButtonWidth;
			expandButton.height = expandButtonHeight;
			expandButton.addEventListener(MouseEvent.CLICK,resizeToolbar);
			expandButton.source = "com/assets/img/tools.png";
			
			addChild(expandButton);
			addChild(content);
			expandButton.addEventListener(FlexEvent.CREATION_COMPLETE,collapsableMenu_creationComplete);
			
		}
		
		override protected function measure():void
		{
       		super.measure();
    		
		}
		
	}
}