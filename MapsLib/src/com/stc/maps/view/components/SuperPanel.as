package com.stc.maps.view.components
{
    import mx.containers.Panel;
    import mx.controls.Button;
    import mx.core.UIComponent;
    import mx.effects.Resize;
    import flash.events.MouseEvent;
/*     import flash.events.MouseEvent; */
    
    public class SuperPanel extends Panel {
        [Bindable] public var showControls:Boolean = false;
                
        private var    pTitleBar:UIComponent;
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
        
        public function get isExpanded()
        {
        	if(!oH) return true;
        	
            return _expanded;
        }
        
        public function initPos():void {
            this.oW = this.width;
            this.oH = this.height;
            this.oX = this.x;
            this.oY = this.y;
        }
    
        public function positionChildren():void {
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
            this.pTitleBar.addEventListener(MouseEvent.CLICK, titleBarClickHandler, false, 0, true);
            this.closeButton.addEventListener(MouseEvent.CLICK, closeClickHandler, false, 0, true);
        }

        public function titleBarClickHandler(event:MouseEvent=null):void {
            
            this.upMotion.target = this;
            this.upMotion.duration = 300;
            this.upMotion.heightFrom = oH;
            this.upMotion.heightTo = 22;
            this.upMotion.end();
            
            this.downMotion.target = this;
            this.downMotion.duration = 300;
            this.downMotion.heightFrom = 22;
            this.downMotion.heightTo = oH;
            this.downMotion.end();
            
            if (this.width < screen.width) {
                if (this.height == oH) {
                    this.upMotion.play();
                    _expanded = false;
                } else {
                    this.downMotion.play();
                    _expanded = true;
                }
            }
        }
        
        public function closeClickHandler(event:MouseEvent):void
        {
        	this.parent.removeChild(this);
        }
        
    }
    
}