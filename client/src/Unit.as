package  
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author myachin
	 */
	public class Unit extends Sprite
	{
		public static var pipiska:int = 0;
		public static var standartWaiting:int = 20;
		public var waiting:int = standartWaiting;
		public var orientation:Number = 1.0;
		public var id:int = -1;
		
		
		public var THIS:LevelSprite = null;
		
		public function Unit() 
		{
			var pp:Sprite = new Sprite;
			
			pp.graphics.beginFill(0xff0000, 1);
			pp.graphics.drawCircle(0, -2, 5);
			addChild(pp);
			pp.addEventListener(MouseEvent.CLICK, fuck);
			
		}
		public function fuck (e:MouseEvent = null) : void
		{
			THIS.fuckPidor(id);
		}
		
		
	}

}