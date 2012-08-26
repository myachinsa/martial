package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.events.MouseEvent;
	import flash.text.*;
	import flash.text.TextFormat;

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
		
		public static var scrollUp:Sprite = new Sprite;
		public static var scrollDown:Sprite = new Sprite;
		
		
		public static var resultSprite:Sprite = new Sprite;
		public static var tfr:TextField;
		public static var LooseScreen:Sprite;
		
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

		
		public function toLoose() : void {
			LooseScreen.alpha = 0.3;
			removeChild(scrollUp);
			removeChild(scrollDown);
			addChild(LooseScreen);
		}
		public function onOK (e:Event = null) : void
		{
			removeChild(LooseScreen);
			tfr.text = "relics : 0";			
			scrollUp.visible = true;
			scrollDown.visible = true;
			lvl.destroy();
			if(lvl != null){
				removeChild(lvl);
				lvl = null;
			}
			lvl = new LevelSprite;
			
			removeChild(resultSprite);
			addChild( lvl );
			addChild(scrollUp);
			addChild(resultSprite);
			addChild(scrollDown);
			lvl.newLevel();
			LevelSprite.scrollUp = scrollUp;
			LevelSprite.scrollDown = scrollDown;
			LevelSprite.tfr = tfr;
			LevelSprite.resultSprite = resultSprite;
			LevelSprite.MAIN = THIS;
		}
		public var lvl:LevelSprite = null;
		public function start (e:Event = null) : void
		{
			Preloader.firstScreen.visible = false;
			removeChild(firstScreen);
			firstScreen.visible = false;
			
			lvl = new LevelSprite;
			addChild( lvl );
			LooseScreen = new Sprite;
			LooseScreen.graphics.beginFill(0x333433, 0.3);
			LooseScreen.alpha = 0.7;
			
			LooseScreen.graphics.drawRect(10, 10, 780, 580);
			var ttf:TextFormat = new TextFormat();
			ttf.color = 0xffffff;
			ttf.size = 40;
			ttf.font = "Tahoma";
			
			var alf:TextField = new TextField;
			alf.defaultTextFormat = ttf;
			alf.x = 300;
			alf.y = 200;
			alf.width = 300;
			alf.mouseEnabled = false;
			alf.text = "all relics found";
			var yl:TextField = new TextField;
			yl.defaultTextFormat = ttf;
			yl.x = 300;
			yl.y = 230;
			yl.width = 300;
			yl.mouseEnabled = false;
			yl.text = "you loose";
			LooseScreen.addChild(yl);
			LooseScreen.addChild(alf);
			var okButton:Sprite = new Sprite;
			okButton.buttonMode = true;
			okButton.graphics.drawRect(0, 0, 200, 50);
			var bt:TextField = new TextField;
			bt.defaultTextFormat = ttf;
			bt.x = 20;
			bt.y = 30;
			bt.width = 300;
			bt.mouseEnabled = false;
			bt.text = "OK";
			okButton.addChild(bt);
			okButton.addEventListener(MouseEvent.CLICK, onOK);
			okButton.x = 400;
			okButton.y = 100;
			LooseScreen.addChild(okButton);
			
			
			
			resultSprite.graphics.beginFill(0x333333, 0.3);
			resultSprite.graphics.drawRect(600, 10, 190, 37);
			
			ttf.color = 0xffffff;
			ttf.size = 19;
			
			tfr = new TextField;
			tfr.defaultTextFormat = ttf;
			tfr.x = 610;
			tfr.y = 12;
			tfr.mouseEnabled = false;
			tfr.text = "relics : 0";
			resultSprite.addChild(tfr);		
			
			scrollUp.graphics.beginFill(0xcccccc, 0.3);
			scrollDown.graphics.beginFill(0xcccccc, 0.3);
			for (var i:int = 0; i < 200; ++i) 
			{
				scrollUp.graphics.drawRect(i*4+1, 50, 3, 2);			
				scrollDown.graphics.drawRect(i*4+1, 550, 3, 2);
			}
			
			scrollUp.graphics.beginFill(0x333333, 0.2);
			scrollUp.graphics.drawRect(10, 30, 70, 17);
			
			scrollDown.graphics.beginFill(0x333333, 0.2);
			scrollDown.graphics.drawRect(10, 552, 70, 17);
			
			ttf = new TextFormat();
			ttf.color = 0xffffff;
			ttf.size = 11;
			
			var tfu:TextField = new TextField;
			tfu.defaultTextFormat = ttf;
			tfu.x = 10;
			tfu.y = 30;
			tfu.mouseEnabled = false;
			tfu.text = "scroll ^";
			scrollUp.addChild(tfu);
			var tfd:TextField = new TextField;
			tfd.defaultTextFormat = ttf;
			tfd.x = 10;
			tfd.y = 552;
			tfd.mouseEnabled = false;			
			tfd.text = "scroll";
			scrollDown.addChild(tfd);					
			
			addChild(scrollUp);
			addChild(scrollDown);
			addChild(resultSprite);
			
			
			lvl.newLevel();
			LevelSprite.scrollUp = scrollUp;
			LevelSprite.scrollDown = scrollDown;
			LevelSprite.tfr = tfr;
			LevelSprite.resultSprite = resultSprite;
			LevelSprite.MAIN = THIS;
		}
	}

}