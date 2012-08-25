package  
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author myachin
	 */
	public class Unit extends Sprite
	{
		public static var pipiska:int = 0;
		public static var standartWaiting:int = 50;
		public var waiting:int = standartWaiting;
		public var orientation:Number = 1.0;
		
		public function Unit() 
		{
			graphics.beginFill(0xff0000, 1);
			graphics.drawCircle(0, -2, 5);
		}
		
	}

}