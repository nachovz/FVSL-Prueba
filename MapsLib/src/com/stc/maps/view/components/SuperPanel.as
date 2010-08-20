package com.stc.maps.view.components
{
    import flash.events.MouseEvent;
    
    import mx.containers.Panel;
    import mx.containers.VBox;
    import mx.controls.Button;
    import mx.core.UIComponent;
    import mx.effects.Resize;
    import mx.events.EffectEvent;
    
    public class SuperPanel extends Panel {
        [Bindable] public var showControls:Boolean = false;
                
        private var pTitleBar:UIComponent;
        private var oW:Number;
        private var oH:Number;
        private var oX:Number;
        private var oY:Number;
        private var normalMaxButton:Button    = new Button();
        private var closeButton:Button        = new Button();
        private var upMotion:Resize            = new Resize();
        private var downMotion:Resize        = new Resize();
        private var resizeCur:Number        = 0;
        private var _expanded : Boolean;
                
        public function SuperPanel() {}

        override protected function createChildren():void {
            super.createChildren();
            this.pTitleBar = super.titleBar;
            //this.setStyle("headerColors", [0xC3D1D9, 0xD2DCE2]);
            //this.setStyle("borderColor", 0xD2DCE2);
            this.horizontalScrollPolicy = "off";
            this.verticalScrollPolicy = "off";
            
            if (showControls) {
                this.closeButton.width             = 10;
                this.closeButton.height            = 10;
                this.closeButton.styleName         = "closeBtn";
                this.pTitleBar.addChild(this.closeButton);
            }
            
            this.positionChildren();    
            this.addListeners();
        }
        
        public function get isExpanded() : Boolean
        {
        	if(!oH) return true;
        	
            return _expanded;
        }
        
        public function initPos():void {
			trace("Super Panel - initPos");
            this.oW = this.width;
            this.oH = this.height;//FIX
            this.oX = this.x;
            this.oY = this.y;
			
        }
		
		
    
        public function positionChildren():void {
			trace("Super Panel - positionChildren");
            if (showControls) {
                this.normalMaxButton.buttonMode    = true;
                this.normalMaxButton.useHandCursor = true;
                this.normalMaxButton.x = this.unscaledWidth - this.normalMaxButton.width - 24;
                this.normalMaxButton.y = 8;
                this.closeButton.buttonMode       = true;
                this.closeButton.useHandCursor = true;
                this.closeButton.x = this.unscaledWidth - this.closeButton.width - 8;
                this.closeButton.y = 8;
            }
            
        }
        
        public function addListeners():void {
			trace("Super Panel - addListeners");
            this.pTitleBar.addEventListener(MouseEvent.CLICK, titleBarClickHandler, false, 0, true);
            this.closeButton.addEventListener(MouseEvent.CLICK, closeClickHandler, false, 0, true);
        }
		/*private var invalidateNaN:Boolean = false;
		private function endEffect(event:EffectEvent):void{
			trace("Super Panel - endEffect");
			
			invalidateNaN = true;
		}*/
		
        public function titleBarClickHandler(event:MouseEvent=null):void {
            
			trace("Super Panel - titleBarClickHandler");
			/*if(!this.upMotion.hasEventListener(EffectEvent.EFFECT_END))
				this.upMotion.addEventListener(EffectEvent.EFFECT_END,endEffect);
            this.upMotion.target = this;
            this.upMotion.duration = 300;
            this.upMotion.heightFrom = oH;
            this.upMotion.heightTo = 22;
            this.upMotion.end();
            
			if(!this.downMotion.hasEventListener(EffectEvent.EFFECT_END))
				this.downMotion.addEventListener(EffectEvent.EFFECT_END,endEffect);
            this.downMotion.target = this;
            this.downMotion.duration = 300;
            this.downMotion.heightFrom = 22;
            this.downMotion.heightTo = oH;
            this.downMotion.end();*/
            
           if (this.width < screen.width) {
              //  if (this.height == oH) {
               if (this.height == 316) {
                   // this.upMotion.play();
					this.height = 22;
                    _expanded = false;
					
                } else {
                    //this.downMotion.play();
					this.height = 316;
                    _expanded = true;
                }
            }
          /* if (this.width < screen.width) {
                if (_expanded) {
                    this.upMotion.play();
                    _expanded = false;
                } else {
                    this.downMotion.play();
                    _expanded = true;
                }
            }*/
            
        }
        
        public function closeClickHandler(event:MouseEvent):void
        {
			trace("Super Panel - closeClickHandler");
        	this.parent.removeChild(this);
        }
		
		/*override protected function commitProperties():void{
			trace("Super Panel - Commit Properties " );
			print()
			super.commitProperties();
			if(invalidateNaN){
				invalidateNaN = false; 
				this.explicitHeight = NaN;
			}
		}
		override protected function measure():void{
			trace("Super Panel - Measure");
			print()
			super.measure();
		}
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void{
			trace("Super Panel - Update Display List (unscaledWidth,unscaledHeight)" );
			print()
			if(!_expanded)
				unscaledHeight = 22;
				super.updateDisplayList(unscaledWidth,unscaledHeight);
		}
        
		private function print():void{
			trace("(this.width,this.height) \t\t -> \t ("+this.width+","+this.height+")");
			trace("(unscaledWidth,unscaledHeight) \t\t -> \t ("+unscaledWidth+","+unscaledHeight+")");
			trace("(measuredWidth,measuredHeight) \t\t -> \t ("+measuredWidth+","+measuredHeight+")");
			trace("(measuredMinWidth,measuredMinHeight) \t -> \t ("+measuredMinWidth+","+measuredMinHeight+")");
			trace("(explicitWidth,explicitHeight) \t\t -> \t ("+explicitWidth+","+explicitHeight+")");
			trace("(explicitMinWidth,explicitMinHeight) \t -> \t ("+explicitMinWidth+","+explicitMinHeight+")");
			trace("(explicitMaxWidth,explicitMaxHeight) \t -> \t ("+explicitMaxWidth+","+explicitMaxHeight+")");
		}*/
    }
    
}