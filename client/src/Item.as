package  
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author 
	 */
	public class Item extends Sprite
	{
		public var id:int = -1;
		public function Item() 
		{
			var pp:Sprite = new Sprite;
			
			pp.graphics.beginFill(0x00ff00, 1);
			pp.graphics.drawCircle(0, 0, 5);
			addChild(pp);
			//pp.addEventListener(MouseEvent.CLICK, fuck);
		}
		
	}

}