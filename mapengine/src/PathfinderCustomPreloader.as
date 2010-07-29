package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;

	public class PathfinderCustomPreloader extends PreloaderDisplayBase
	{
		[Embed("/assets/loader.png") ]
		[Bindable] public var Logo:Class;   
		
		private var t:TextField;
		private var f:DropShadowFilter=new DropShadowFilter(2,45,0x000000,0.5)
		private var pathfLogo:DisplayObject;
		private var bar:Sprite=new Sprite();
		private var barFrame:Sprite;
		private var mainColor:uint=0x00AEEF;
		
		public function PathfinderCustomPreloader()
		{
			super();
			
		}
		
		
		// This is called when the preloader has been created as a child on the stage.
		//  Put all real initialization here.
		override public function initialize():void
		{
			super.initialize();
			var indent:int = 20;
			var height:int = 20;
			
			//creates all visual elements
			createAssets();
		}
		//this is our "animation" bit
		override protected function draw():void
		{
			t.text = int(_fractionLoaded*100).toString()+"%";
			//make objects below follow loading progress
			//positions are completely arbitrary
			//d tells us the x value of where the loading bar is at
			var d:Number=barFrame.x + barFrame.width * _fractionLoaded
			
			/*  pathfLogo.x = d - pathfLogo.width;  */
			bar.graphics.beginFill(mainColor,1)
			bar.graphics.drawRoundRectComplex(0,0,bar.width * _fractionLoaded,15,12,12,12,12);
			bar.graphics.endFill();
		}
		
		protected function createAssets():void
		{
			//create the logo
			pathfLogo = new Logo();
			pathfLogo.x = stageWidth/2 - pathfLogo.width/2;
			pathfLogo.y = stageHeight/2 - pathfLogo.height/2;
			pathfLogo.filters = [f];
			
			//craate bar
			bar = new Sprite();
			bar.graphics.drawRoundRectComplex(0,0,280,15,12,12,12,12);
			bar.x = stageWidth/2 /*- bar.width/2 */- pathfLogo.width/2 + 15;
			bar.y = stageHeight/2 - bar.height + pathfLogo.height/2- 7;
			bar.filters = [f];
			addChild(bar);
			
			//create bar frame
			barFrame = new Sprite();
			barFrame.graphics.lineStyle(2,0xFFFFFF,1)
			barFrame.graphics.drawRoundRectComplex(0,0,280,15,12,12,12,12);
			barFrame.graphics.endFill();
			barFrame.x = stageWidth/2 /*- barFrame.width/2 */- pathfLogo.width/2+15;
			barFrame.y = stageHeight/2 - barFrame.height + pathfLogo.height/2 - 7;
			barFrame.filters = [f];
			addChild(barFrame);
			
			addChild(pathfLogo); 
			//create text field to show percentage of loading
			t = new TextField()
			t.y = pathfLogo.y +pathfLogo.height -28;
			t.x = pathfLogo.x + pathfLogo.width/2 -45;
			t.textColor = 0x00AEEF;
			t.filters=[f];
			addChild(t);
			//we can format our text
			var s:TextFormat=new TextFormat("Verdana",null,0x00AEEF,null,null,null,null,null,"right");
			t.defaultTextFormat=s;
		}
	}
}