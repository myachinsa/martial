package  
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
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
		
		public var id:int = -1;
		public var handler:int = -1;
		public function Item() 
		{
			var kost:Bitmap = new _kostClass as Bitmap;
			kost.x = -16;
			kost.y = -16;
			
			addChild(kost);
			
			var pp:Sprite = new Sprite;
			
			pp.graphics.beginFill(0x00ff00, 0);
			pp.graphics.drawCircle(0, 0, 5);
			addChild(pp);
			//pp.addEventListener(MouseEvent.CLICK, fuck);
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
		
	}

}