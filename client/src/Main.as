package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.Bitmap;
	import flash.events.MouseEvent;

	/**
	 * ...
	 * @author myachin
	 */
	[Frame(factoryClass="Preloader")]
	public class Main extends Sprite 
	{
		[Embed(source = 'logo.png')]
		public static var _logoClass:Class;		
		public static var _logo:Bitmap = new _logoClass as Bitmap;
		
		[Embed(source = 'start.png')]
		public static var _startClass:Class;		
		public static var _start:Bitmap = new _startClass as Bitmap;
		
		public static var firstScreen:Sprite = new Sprite;
		
		public static var THIS:Main = null;
		
		public function Main():void 
		{
			THIS = this;
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			addChild( firstScreen );
			
			_logo.x = 200;
			_logo.y = 100;
			//_logo.smoothing = true;
			firstScreen.addChild(_logo);
			
			var startButton:Sprite = new Sprite;
			startButton.addChild(_start);
			startButton.buttonMode = true;
			startButton.useHandCursor = true;
			
			startButton.x = 400 - startButton.width / 2;
			startButton.y = 400;
			
			firstScreen.addChild(startButton);		
			
			startButton.addEventListener(MouseEvent.CLICK, start);
		}

		
		
		public function start (e:Event = null) : void
		{
			Preloader.firstScreen.visible = false;
			removeChild(firstScreen);
			firstScreen.visible = false;
			
			
			addChild( new LevelSprite );
			LevelSprite.newLevel();
		}
	}

}