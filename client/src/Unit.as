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
		
		public function Unit() 
		{
			graphics.beginFill(0xff0000, 1);
			graphics.drawCircle(0, 0, 20);
		}
		
	}

}