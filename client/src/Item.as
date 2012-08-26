package  
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author 
	 */
	public class Item extends Sprite
	{
		[Embed(source = 'kost.png')]
		public static var _kostClass:Class;		
		public static var _kost:Bitmap = new _kostClass as Bitmap;
		
		public var THIS:LevelSprite = null;
		
		public var hand:int;
		
		
		public var id:int = -1;
		public var handler:int = -1;
		public function Item() 
		{
			var kost:Bitmap = new _kostClass as Bitmap;
			kost.x = -16;
			kost.y = -16;
			
			addChild(kost);
			
			var pp:Sprite = new Sprite;
			hand = 0;
			
			addEventListener(MouseEvent.MOUSE_DOWN, onDown);
			addEventListener(MouseEvent.MOUSE_UP, onUp);
			
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
		
		public function onFrame (e:Event = null) : void
		{
			//tf.text = id.toString() + " " + handler ;
		}
		public function onDown (e:MouseEvent = null) : void
		{
			hand = 1;
			
			addEventListener(MouseEvent.MOUSE_MOVE, onMove);	
		}
		public function onUp (e:MouseEvent = null) : void
		{
			hand = 0;			
			removeEventListener(MouseEvent.MOUSE_MOVE, onMove);
		}
		public function onMove (e:MouseEvent = null) : void
		{
			if (hand == 0) {
				removeEventListener(MouseEvent.MOUSE_MOVE, onMove);
				return;
			}
			THIS.moveItem(id, 0,0);
		}
		
	}

}