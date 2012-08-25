package  
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.WeakFunctionClosure;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author myachin
	 */
	public class LevelSprite extends Sprite
	{
		[Embed(source = 'soil.png')]
		public static var _soilClass:Class;		
		public static var _soil:Bitmap = new _soilClass as Bitmap;
		
		public static var DEPTH:int = 1000;
		public static var groundMap:BitmapData = new BitmapData(200, DEPTH, true, 0xff000000);
		public static var groundBmp:Bitmap = new Bitmap(groundMap);
		
		public static var mapMask:Sprite = new Sprite;
		
		public static var soilSprite:Sprite = new Sprite;
		
		public static var pidorList:Array = new Array;
		
		public static var THIS:LevelSprite = null;
		
		public static var maskBmp:BitmapData = new BitmapData(200, DEPTH, true, 0xff000000);
		public static var maskedSoil:Bitmap = new Bitmap(maskBmp);
				
		public function LevelSprite() 
		{
			THIS = this;
			
			mapMask.addChild(groundBmp);
			addChild(mapMask);
			
			groundBmp.scaleX = 4;
			groundBmp.scaleY = 4;
			
			soilSprite.addChild( groundBmp );
			
			addChild(soilSprite);
			addEventListener(Event.ENTER_FRAME, onFrame);
			
			//stage.addEventListener(MouseEvent.MOUSE_MOVE, onMove);
			
			
		}
		
		public static function random (a:Number, b:Number):Number
		{
			return a + (b - a) * Math.random();
		}
		
		public function onMove (e:MouseEvent = null) : void
		{

		}
		public function onFrame (e:Event = null) : void
		{
			groundBmp.bitmapData = groundMap;
			
			if (Main.THIS.mouseY < 50)
			{
				if ( y < 0)
				{
					y += 5;
				}
			}
			
			if (Main.THIS.mouseY > 550)
			{
				if ( y >= - 4000 + 600)
				{
					y -= 5;
				}				
			}			
			
			////////////////////////////
			// UNIT LOGIC
			for (var i:int = 0; i < pidorList.length; i++) 
			{
				var pidor:Unit = pidorList[i] as Unit;
				
				// check the current position of Pidor:
				var pix:uint = groundMap.getPixel32( pidor.x / 4, pidor.y / 4 );
				//var pixLeft:uint = groundMap.getPixel32( pidor.x / 4 - 1 >= 0 ? pidor.x / 4 - 1 : 0, pidor.y / 4 );
				//var pixRight:uint = groundMap.getPixel32( pidor.x / 4 - 1 <= 200 ? pidor.x / 4 + 1 : 200, pidor.y / 4 );
				
				if (pix==0) {	
					//while (pix == 0) {			
						pidor.y += random(0, 2);
						pidor.x += random( -1, 2) * pidor.orientation;					
						pix = groundMap.getPixel32( pidor.x / 4, pidor.y / 4 );
					//}					
					
				}		
				else if (pix != 0)
				{					
					// вырезаем кусок почвы!
					if (pidor.waiting == 0){
						for (var j:int = 0; j < 9; j++) 
						{
							groundMap.fillRect( new Rectangle( pidor.x / 4 + random( -3, 4), pidor.y / 4 + random( -3, 4), random(2, 4), random(2, 4)), 0x0000ffff );
						}
						pidor.waiting = Unit.standartWaiting;
					}
					else pidor.waiting--;
				}
				
				if (pidor.x >= 780) {
					pidor.orientation *= -1.0;
					pidor.x = 780;
				}
				if (pidor.x <= 20) {
					pidor.orientation *= -1.0;
					pidor.x = 20;						
				}				
			}
		}
		
		public static function newLevel():void
		{
			groundMap.fillRect(new Rectangle(0, 0, 200, DEPTH), 0xff000000);
			
			groundMap.copyPixels( _soil.bitmapData, new Rectangle(0, 0, 200, DEPTH), new Point(0, 0) );
			for (var i:int = 0; i < 12; i++) 
			{
					
				var unit:Unit = new Unit;
				unit.x = random(10,790);
				unit.y = 5;
				unit.orientation = (1 + Math.random() * 2) - 2;
				THIS.addChild( unit );
				pidorList.push( unit );
			}
			
		}
		
	}

}