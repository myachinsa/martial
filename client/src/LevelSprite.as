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
		public static var itemList:Array = new Array;
		
		public static var THIS:LevelSprite = null;
		
		public static var maskBmp:BitmapData = new BitmapData(200, DEPTH, true, 0xff000000);
		public static var maskedSoil:Bitmap = new Bitmap(maskBmp);
		
		public static var standartNewPidorWait:int = 200; 
		public static var newPidorWait:int = standartNewPidorWait;
		public static var pidorCnt:int = 0;
				
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
			//добавляем реликвии
			for (var i:int = 0; i < 800; ++i) {
				var item:Item = new Item;
				item.x = random(10, 790);
				item.y = random( 500, DEPTH * 4);
				item.id = i;
				itemList.push(item);
				THIS.addChild(item);				
			}
			
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
			// PIDORS LOGIC
			for (var i:int = 0; i < pidorList.length; i++) 
			{
				var pidor:Unit = pidorList[i] as Unit;
				if (pidor == null) continue;
				
				// check the current position of Pidor:
				var pix:uint = groundMap.getPixel32( pidor.x / 4, pidor.y / 4 - 1 );
				//var pixLeft:uint = groundMap.getPixel32( pidor.x / 4 - 1 >= 0 ? pidor.x / 4 - 1 : 0, pidor.y / 4 );
				//var pixRight:uint = groundMap.getPixel32( pidor.x / 4 - 1 <= 200 ? pidor.x / 4 + 1 : 200, pidor.y / 4 );
				
				//if (pidor.waiting == 0) {
					//trace(pidor.id);
					var min:Number = -1;
					var argMinX:int = 0;
					var argMinY:int = 0;
					for each (var item:Item in itemList) 
					{
						if (item == null) continue;
						//trace(item.id);
						var dist:Number = (item.x - pidor.x) * (item.x -pidor.x) + (item.y - pidor.y) * (item.y - pidor.y);
						if (dist < 400) {
							THIS.removeChild(item);
							itemList[item.id] = null;							
						}
						if (item.y - 20 < pidor.y && (min == -1 || dist < min)) {
							min = dist;
							argMinX = pidor.x - item.x;
							argMinY = pidor.y - item.y;
						}
					}
					if (argMinX < -20) pidor.orientation = -1;
					else if (argMinX > 20) pidor.orientation = 1;
					else pidor.orientation = 0;
				//}
				
				if (pix==0) {	
					//while (pix == 0) {			
						pidor.y += random(0, 2);
						pidor.x += random( -1, -1) * pidor.orientation;					
						pix = groundMap.getPixel32( pidor.x / 4, pidor.y / 4 );
					//}					
					
				}		
				else
				{					
					groundMap.fillRect( new Rectangle(pidor.x / 4 , pidor.y / 4 , 1, 1), 0x0000ffff );
					
					
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
			
			if (newPidorWait <= 0) {
				newPidor();
				newPidorWait = Math.random() * standartNewPidorWait;
			}
			else newPidorWait--;
		}
		public static function newPidor():void {
			var unit:Unit = new Unit;
				unit.x = random(10, 790);
				unit.y = 0;
				/*
				trace(_soil.bitmapData.getPixel32(unit.x / 4, unit.y / 4));
				while (unit.y > -4 * DEPTH && _soil.bitmapData.getPixel32(unit.x / 4, unit.y / 4) == 0) {
					trace("y:" + unit.y);
					
					trace("i:" + _soil.bitmapData.getPixel32(unit.x / 4, unit.y / 4));
					unit.y -= 4;
				}
				*/
				unit.orientation = (1 + Math.random() * 2) - 2;
				unit.id = pidorCnt;
				pidorCnt++;
				unit.buttonMode = true;
				unit.THIS = THIS;
				unit.useHandCursor = false;
				THIS.addChild( unit );
				pidorList.push( unit );
		}
		
		public static function newLevel():void
		{
			groundMap.fillRect(new Rectangle(0, 0, 200, DEPTH), 0xff000000);
			
			groundMap.copyPixels( _soil.bitmapData, new Rectangle(0, 0, 200, DEPTH), new Point(0, 0) );
			for (var i:int = 0; i < 12; i++) 
			{
					
				newPidor();
			}
			
		}
		public function fuckPidor (id:int) : void
		{
			removeChild(pidorList[id]);
			pidorList[id] = null;	
		}
		
	}

}