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
		
		public var speed:Number = 2;
		public var orientation:int = 1;
		public var id:int = -1;
		public var itemId:int = -1;
		public var go:int = 1;
		
		public var pathCnt:int = 0;		
		public var pathX:Array = new Array;		
		public var pathY:Array = new Array;
		
		[Embed(source = 'padaet.png')]
		public static var _padaetClass:Class;		
		public static var _padaet:Bitmap = new _padaetClass as Bitmap;

		public var THIS:LevelSprite = null;
		public var anim:Animator;
		public var killde:int = 0;
		public function Unit() 
		{
			
			
			anim = new Animator( _padaet as Bitmap);
			anim.frames = [0, 1, 2, 3, 4];
			
			anim.x = -8;
			anim.y = -8;
			addChild(anim);
			
			anim.addEventListener(MouseEvent.CLICK, fuck);
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
			anim.repeatFrame = 0;
		}
		
		public function leftAnimation():void
		{
			anim.frames = [8, 9, 10];
			anim.repeatFrame = 0;
		}
		
		public function rightAnimation():void
		{
			anim.frames = [5, 6, 7];
			anim.repeatFrame = 0;
		}		
		
		public function bombAnimation ():void
		{
			anim.frames = [11, 12, 13, 14, 15, 16, 17, 18, 19];
			anim.repeatFrame = 7;		
		}
		
		public function fuck (e:MouseEvent = null) : void
		{
			//THIS.Pidor(id);
			//y -= 20;
			THIS.molnijaPidora(id);
			tf.text = orientation.toString() + " " + waiting + " " + itemId;
		}
		public var lastX:int;
		public var lastY:int;
		
		
		public function onFrame (e:Event = null) : void
		{
			if (killde == 1) {
				removeEventListener(Event.ENTER_FRAME, onFrame);
				return;
			}
			//tf.text = orientation.toString() + " " + waiting + " " + itemId;
			if (pathCnt == 0) 
			{
				pathX.push(x);
				lastX = x;
				pathY.push(y);
				lastY = y;
				pathCnt++;
			}
			else if (Math.abs(lastX - x) > 3 && Math.abs(lastY - y) > 3) 
			{
				pathX.push(x);
				lastX = x;
				pathY.push(y);
				lastY = y;
				pathCnt++;				
			}
		}
	}

}