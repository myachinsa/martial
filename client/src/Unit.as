package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.display.Bitmap;
	/**
	 * ...
	 * @author myachin
	 */
	
	 
	public class Unit extends Sprite
	{
		public static var pipiska:int = 0;
		public static var standartWaiting:int = 20;
		public var pidorWaiting:int = 20;
		public var waiting:int = standartWaiting;
		
		public var speed:int = 2;
		public var orientation:int = 1;
		public var id:int = -1;
		public var itemId:int = -1;
		public var go:int = 1;
		
		[Embed(source = 'padaet.png')]
		public static var _padaetClass:Class;		
		public static var _padaet:Bitmap = new _padaetClass as Bitmap;

		public var THIS:LevelSprite = null;
		public var anim:Animator
		
		public function Unit() 
		{
			var pp:Sprite = new Sprite;
			
			pp.graphics.beginFill(0xff0000, 0);
			pp.graphics.drawCircle(0, 0, 9);
			addChild(pp);
			pp.addEventListener(MouseEvent.CLICK, fuck);
			
			anim = new Animator( _padaet as Bitmap);
			anim.frames = [0, 1, 2, 3, 4];
			
			anim.x = -8;
			anim.y = -8;
			addChild(anim);
			
			addEventListener(Event.ENTER_FRAME, onFrame);
			
			var ttf:TextFormat = new TextFormat();
			ttf.color = 0xffffff;
			ttf.size = 18;
			
			tf = new TextField;
			tf.defaultTextFormat = ttf;
			tf.x = 6;
			tf.y = -6;
			tf.mouseEnabled = false;
			addChild(tf);
		}
		
		public var tf:TextField;
		
		public function fallAnimation():void
		{
			anim.frames = [0, 1, 2, 3, 4];
		}
		
		public function leftAnimation():void
		{
			anim.frames = [8,9,10];
		}
		
		public function rightAnimation():void
		{
			anim.frames = [5,6,7];
		}		
		
		public function fuck (e:MouseEvent = null) : void
		{
			//THIS.Pidor(id);
			y -= 20;
		}
		
		public function onFrame (e:Event = null) : void
		{
			tf.text = orientation.toString() + " " + waiting + " " + itemId;
		}
	}

}