package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author myachin
	 */
	public class Unit extends Sprite
	{
		public static var pipiska:int = 0;
		public static var standartWaiting:int = 20;
		public var waiting:int = standartWaiting;
		public var orientation:int = 1;
		public var id:int = -1;
		public var itemId:int = -1;
		

		public var THIS:LevelSprite = null;
		
		public function Unit() 
		{
			var pp:Sprite = new Sprite;
			
			pp.graphics.beginFill(0xff0000, 1);
			pp.graphics.drawCircle(0, 0, 9);
			addChild(pp);
			pp.addEventListener(MouseEvent.CLICK, fuck);
			
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