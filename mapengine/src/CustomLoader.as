package
{
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.filters.DropShadowFilter;
	import flash.geom.Matrix;
	
	import mx.containers.Canvas;
	import mx.controls.Image;
	import mx.controls.Label;
	import mx.controls.ProgressBar;
	import mx.core.Application;

	public class CustomLoader extends Canvas
	{
		[Embed("/assets/loader.png") ]
		[Bindable] public var Logo:Class;  
		private var t:Label;
		private var f:DropShadowFilter = new DropShadowFilter(2,45,0x000000,0.5)
		private var pathfLogo:DisplayObject;
		private var bar:Canvas =new Canvas;
		private var mainColor:uint=0x00AEEF;
		
		private var type:String		= GradientType.LINEAR;
		private var colors:Array	= [0xFFFFFF, 0x999999];
		private var alphas:Array	= [1, 1];
		private var ratios:Array	= [0, 255];
		private var matrix:Matrix	= new Matrix();
		
		
		
		public function CustomLoader()
		{
			percentWidth = 100;
			percentHeight = 100;
			var indent:int = 20;
			var height:int = 20;
			
			//creates all visual elements
			createAssets();
		}
		
		
		protected function createAssets():void
		{
			
			
			//create the logo
			pathfLogo = new Logo();
			pathfLogo.x = Application.application.width/2 - pathfLogo.width/2;
			pathfLogo.y = Application.application.height/2 - pathfLogo.height/2;
			pathfLogo.filters = [f];
			var im:Image = new Image;
			im.source= pathfLogo;
			
			//craate bar
			bar.setStyle("trackHeight", 25);
			bar.x = Application.application.width/2 /*- bar.width/2 */- pathfLogo.width/2 + 15;
			bar.y = Application.application.height/2 - bar.height + pathfLogo.height/2- 17;
			addChild(bar);
			
			addChild(im); 
			t = new Label()
			t.y = pathfLogo.y +pathfLogo.height -35;
			t.x = pathfLogo.x + pathfLogo.width/2 -20;
			t.setStyle("color",0x00AEEF);
			t.setStyle("fontSize",12);
			t.filters=[f];
			addChild(t);
		}
		
		public function draw(fractionLoaded:Number):void
		{
			t.text = int(fractionLoaded*100).toString()+"%";
			
			pathfLogo.x = Application.application.width/2 - pathfLogo.width/2;
			pathfLogo.y = Application.application.height/2 - pathfLogo.height/2;
			
			bar.setStyle("backgroundColor",0x00AEEF);
			bar.x = Application.application.width/2 /*- bar.width/2 */- pathfLogo.width/2 + 15;
			bar.y = Application.application.height/2 - bar.height + pathfLogo.height/2- 17;
			bar.height = 15;
			bar.width = 257*fractionLoaded;
				
			t.y = pathfLogo.y +pathfLogo.height -35;
			t.x = pathfLogo.x + pathfLogo.width/2 -20;
		}
		
	}
}