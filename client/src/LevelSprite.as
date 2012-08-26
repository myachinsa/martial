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
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author myachin
	 */
	public class LevelSprite extends Sprite
	{
		[Embed(source = 'soil.png')]
		public static var _soilClass:Class;		
		public static var _soil:Bitmap = new _soilClass as Bitmap;
		
		public static var DEPTH:int = 300;
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
		
		public var movingItemId:int = -1;
		public var movingItemX:int = 0;
		public var movingItemY:int = 0;
		public var foundRecicts:int = 0;
		
		public static var scrollUp:Sprite = new Sprite;
		public static var scrollDown:Sprite = new Sprite;
		public static var tfr:TextField;
		public static var resultSprite:Sprite = new Sprite;
		public static var flushResults:int = 0;
		public static var Loose:int = 0;
		public static var TotalRelics:int = 0;
		
		public static var MAIN:Main = null;
		
		
				
		public function LevelSprite() 
		{
			THIS = this;
			Loose = 0;
			foundRecicts = 0;
			
			//mapMask.addChild(groundBmp);
			//addChild(mapMask);
			
			groundBmp.scaleX = 4;
			groundBmp.scaleY = 4;
			TotalRelics = 1;// random(60, 80);
			
			soilSprite.addChild( groundBmp );
			addChild(soilSprite);
			
			var setkaBMPData:BitmapData = new BitmapData(800, 4 * DEPTH, true, 0x00000000);
			
			
			// bug for future
			for (var j:int = 0; j < 200; j++) 
			{
				setkaBMPData.fillRect(new Rectangle(j * 4 + 2, 0, 1, 4 * DEPTH), 0x09000000);
			}
			for (var k:int = 0; k < DEPTH; k++) 
			{
				setkaBMPData.fillRect(new Rectangle(0, k * 4 + 2, 800, 1), 0x09000000);
			}
			//
			
			for (j = 0; j < 200; j++) 
			{
				setkaBMPData.fillRect(new Rectangle(j * 4 + 3, 0, 1, 4 * DEPTH), 0xcc000000);
			}
			for (k = 0; k < DEPTH; k++) 
			{
				setkaBMPData.fillRect(new Rectangle(0, k * 4 + 3, 800, 1), 0xcc000000);
			}		
			
			var setka:Bitmap = new Bitmap(setkaBMPData);
			
			
			
			
			addChild(setka);
			
			addEventListener(Event.ENTER_FRAME, onFrame);
			
			//stage.addEventListener(MouseEvent.MOUSE_MOVE, onMove);

			
			addEventListener(MouseEvent.MOUSE_DOWN, onDown);
			
			addEventListener(MouseEvent.MOUSE_UP, onUp);
			
			
			var ttf:TextFormat = new TextFormat();
			ttf.color = 0xffffff;
			ttf.size = 18;
			
			tf = new TextField;
			tf.defaultTextFormat = ttf;
			tf.x = 100;
			tf.y = 100;
			tf.mouseEnabled = false;
			addChild(tf);
			
			
		}
		public var tf:TextField;
		public function onDown (e:MouseEvent = null) : void
		{
			if (e.target is Item) {
				
				addEventListener(MouseEvent.MOUSE_MOVE, onMove);
				
			}
			else{
				groundMap.setPixel32( mouseX / 4, mouseY / 4, 0xff000000 + 0x00ffffff * Math.random() );
			}
		}
		public function onUp (e:MouseEvent = null) : void
		{
			
			removeEventListener(MouseEvent.MOUSE_MOVE, onMove);
			movingItemId = -1;
			tf.text = "UP";
			for each (var item:Item in itemList) 
			{
				if (item == null) continue;
				item.hand = 0;
			}
		}
		public static function random (a:Number, b:Number):Number
		{
			return a + (b - a) * Math.random();
		}
		
		public function onMove (e:MouseEvent = null) : void
		{
			//if (e.target is Item) {
			//	moveItem((e.target as Item).id, 0, 0);
			//}
			tf.text = "moving " + movingItemId;
			if (movingItemId != -1) 
			{
				moveItem(movingItemId, mouseX, mouseY);
			}
		}
		public function fffffound():void 
		{
			resultSprite.alpha = 1;
			foundRecicts ++;
			flushResults = 700;
			tfr.text = "relics : " + foundRecicts.toString();
			
			if (foundRecicts >= TotalRelics) Loose = 1;
		}
		public function onFrame (e:Event = null) : void
		{
			if (Loose == 1) {
				removeEventListener(Event.ENTER_FRAME, onFrame);
				MAIN.toLoose();				
				return;				
			}
			groundBmp.bitmapData = groundMap;
			//if (resultSprite.alpha < 0.4) flushResults = 0;
			flushResults -= 1;
			if (flushResults > 599)
			{
				resultSprite.alpha = 0.5 + 0.4*Math.sin(Math.PI*(flushResults/30.0));
			}
			else {
				resultSprite.alpha = 0.3;
				flushResults = 0;
			}
			
			scrollUp.alpha = -y/(4*DEPTH - 600);	
			scrollDown.alpha = (y + 4*DEPTH - 600)/(4*DEPTH - 600);	
			
			if (Main.THIS.mouseY < 50)
			{
				if ( y < 0)
				{
					y += 5;
					
				}
			}
			
			if (Main.THIS.mouseY > 550)
			{
				if ( y >= -4*DEPTH + 600)
				{
					y -= 5;
				}				
			}
			if (movingItemId == -1) 
			{
				for each (var item:Item in itemList) 
				{
					if (item == null) continue;
					var pix1:uint = groundMap.getPixel32( item.x / 4, item.y / 4 + 1 );
					var pix2:uint = groundMap.getPixel32( item.x / 4, item.y / 4 + 2 );
					//tf.text = pix1.toString() + " " + pix2.toString();
					if (pix1 == 0 && pix2 == 0)
					{
						item.y += 4;
					}
				}
			}
			else 
			{
				var ii:Item = itemList[movingItemId];
				
				if (ii != null) 
				{
					var dx:Number = ii.x - movingItemX;
					var dy:Number = ii.y - movingItemY;
					if (Math.abs(dx) <= 4) ii.x = movingItemX;
					if (Math.abs(dy) <= 4) ii.y = movingItemY;
					ii.x -= dx / 2;
					ii.y -= dy / 2;
				}
				else {
					movingItemId = -1;
				}
			}
			
			
			
			////////////////////////////
			// PIDORS LOGIC
			for (var i:int = 0; i < pidorList.length; i++) 
			{
				var pidor:Unit = pidorList[i] as Unit;
				
				
				if (pidor == null) continue;
				if (pidor.y > DEPTH * 4) 
				{
					THIS.removeChild(pidor);
					pidor.killde = 1;
					pidorList[pidor.id] = null;
					continue;
				}
				var itemToHand:Item = pidor.itemId == -1 ? null:itemList[pidor.itemId]; 
				if (itemToHand != null) 
				{
					if (itemToHand.y + 5 < pidor.y) 
					{
						pidor.itemId = -1;
						itemToHand.handler = -1;
					}
				}
				else pidor.itemId = -1;
				
				
				
				// check the current position of Pidor:
				var pix:uint = groundMap.getPixel32( pidor.x / 4, pidor.y / 4 + 1 );
				
				//var pixLeft:uint = groundMap.getPixel32( pidor.x / 4 - 1 >= 0 ? pidor.x / 4 - 1 : 0, pidor.y / 4 );
				//var pixRight:uint = groundMap.getPixel32( pidor.x / 4 - 1 <= 200 ? pidor.x / 4 + 1 : 200, pidor.y / 4 );
				
				//if (pidor.itemId == -1) {
					//trace(pidor.id);
					var min:Number = 80000;
					var argMinX:int = 0;
					var argMinY:int = 0;
					var argMinID:int = -1;
					for each (item in itemList) 
					{
						if (item == null) continue;
						//trace(item.id);
						var dist:Number = (item.x - pidor.x) * (item.x -pidor.x) + (item.y - pidor.y) * (item.y - pidor.y);
						if (dist < 440) {
							THIS.removeChild(item);
							item.killde = 1;
							itemList[item.id] = null;	
							fffffound();
						}
						if (pidor.itemId != -1) {
							if (itemList[pidor.itemId] == null) {
								pidor.itemId = -1;
								continue;
							}
							argMinX = pidor.x - itemList[pidor.itemId].x;
							argMinY = pidor.y - itemList[pidor.itemId].y;
							
							if (argMinX > 50) pidor.orientation = -1;
							else if (argMinX < -50) pidor.orientation = 1;
							//argMinID = item.id;
							
							continue;
						}
						
						if (item.handler == -1 && item.y > pidor.y && dist < min) {
							min = dist;
							argMinX = pidor.x - item.x;
							argMinY = pidor.y - item.y;
							argMinID = item.id;
						}
						
					}
					if (argMinID != -1 && pidor.go == 0){
						if (argMinX > 50) pidor.orientation = -1;
						else if (argMinX < -50) pidor.orientation = 1;
						else pidor.orientation = 0;
						
						if (itemList[argMinID] == null)
						{
							pidor.itemId = -1;
						}
						else 
						{
								
							pidor.itemId = argMinID;
							itemList[argMinID].handler = pidor.id;
						}
						//item.handler = pidor.id;							
						
					}
					//if (argMinID >= 0)(itemList[id] as Item).handled = 1;
				//}
				
				if (pix == 0) 
				{	
					if (groundMap.getPixel32( pidor.x / 4, pidor.y / 4 + 2 ) != 0)
					{
						pidor.y = 4 * (pidor.y / 4);
						
						pidor.go = 1;
						
						
						if (pidor.orientation == 0) {
							if(pidor.itemId != -1){
								if (itemList[pidor.itemId] == null) {
									pidor.itemId = -1;
									continue;
								}
								else{
									argMinX = pidor.x - itemList[pidor.itemId].x;
									argMinY = pidor.y - itemList[pidor.itemId].y;
								
									if (argMinX < -50) pidor.orientation = 1;
									else if (argMinX > 50) pidor.orientation = -1;
									else pidor.orientation = Math.random()>0.5?1:-1;
									pidor.waiting++;
								}
							}
							else pidor.orientation = Math.random()>0.5?1:-1;
						}
					
						if (groundMap.getPixel32( (pidor.x  + pidor.orientation) / 4, pidor.y / 4 + 1 ) == 0)
						{
							pidor.x += pidor.orientation;					
						}
						else
						{
							pidor.y += 1;// int(random(0, 2));
						}
						
						if (pidor.orientation < 0) pidor.leftAnimation();
						else pidor.rightAnimation();
					}
					else
					{
						pidor.fallAnimation();
						pidor.go = 0;
						pidor.y += int(random(1, 6) * pidor.speed / 4.0);
						pidor.x += pidor.orientation;					
						//pix = groundMap.getPixel32( pidor.x / 4, pidor.y / 4 );
					}
					//}					
					
				}		
				else
				{					
					//groundMap.fillRect( new Rectangle(pidor.x / 4 , pidor.y / 4 , 1, 1), 0x0000ffff );
					
					
					// вырезаем кусок почвы!
					if (pidor.waiting == 0 && pidor.go == 0){
						for (var j:int = 0; j < 29; j++) 
						{
							groundMap.fillRect( new Rectangle( pidor.x / 4 + random( -3, 4), pidor.y / 4 + random( -3, 4), random(2, 4), random(2, 4)), 0x0000ffff );
						}
						
						pidor.waiting = pidor.pidorWaiting;
						
						
					}
					else if (pidor.waiting == 0) {
						
						
						for (j = 0; j < 29; j++) 
						{
							groundMap.fillRect( new Rectangle( pidor.x / 4 + random( -3, 4), pidor.y / 4 + random( 0, 4), random(2, 4), random(1, 4)), 0x0000ffff );
						}
						
						pidor.waiting = pidor.pidorWaiting;
						pidor.go = 0;
						
					}
					else 
					{
						pidor.bombAnimation ();
						pidor.waiting--;
					}
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
				unit.itemId = -1;
				pidorCnt++;
				unit.buttonMode = true;
				unit.THIS = THIS;
				unit.pidorWaiting = Unit.standartWaiting * random(0.7, 2.0);
				unit.speed = random(1,2);
				unit.useHandCursor = false;
				THIS.addChild( unit );
				pidorList.push( unit );
		}
		public function destroy():void {
			movingItemId = -1;
			var item:Item;
			for each (item in itemList) 
			{
				if (item == null) continue;
				item.removeEventListener(Event.ENTER_FRAME,item.onFrame);
				removeChild(item);
				item.killde = 1;
				item = null;
			}
			var pidor:Unit;
			for each (pidor in pidorList) 
			{
				if (pidor == null) continue;
				pidor.removeEventListener(Event.ENTER_FRAME,pidor.onFrame);
				removeChild(pidor);
				pidor.killde = 1;
				pidor = null;
			}
		}
		
		public static function newLevel():void
		{
			groundMap.fillRect(new Rectangle(0, 0, 200, DEPTH), 0xff000000);
			
			groundMap.copyPixels( _soil.bitmapData, new Rectangle(0, 0, 200, DEPTH), new Point(0, 0) );
			for (var i:int = 0; i < 6; i++) 
			{
					
				newPidor();
			}
			
			//добавляем реликвии
			for (i = 0; i < TotalRelics; ++i) {
				var item:Item = new Item;
				item.x = random(10, 790);
				item.y = random( 500, DEPTH * 4);
				item.id = i;
				item.THIS = THIS;
				itemList.push(item);
				
				THIS.addChild(item);				
			}			
		}
		
		public function moveItem (id:int, x:int, y:int) : void
		{
			if (id == -1) return;
			var item:Item = itemList[id];
			if (item == null) return;
			//item.tf.text = id.toString() + " " + mouseX + " " + mouseY;
			movingItemId = id;
			movingItemX = mouseX + 0;// x / 2;
			movingItemY  = mouseY + 0;// y / 2;
			if (movingItemX > 790) {
				movingItemX = 790;
				item.x = movingItemX;
				item.y = movingItemY;
				item.hand = 0;
				movingItemId = -1;
			}
			if (movingItemY > DEPTH * 4) {
				movingItemX = DEPTH * 4;
				item.x = movingItemX;
				item.y = movingItemY;
				item.hand = 0;	
				movingItemId = -1;
			}
			if (movingItemX < 5) {
				movingItemX = 5;				
				item.x = movingItemX;
				item.y = movingItemY;
				item.hand = 0;
				movingItemId = -1;
			}
			if (movingItemY < 5) {
				movingItemX = 5; 
				item.x = movingItemX;
				item.y = movingItemY;
				item.hand = 0;
				movingItemId = -1;
			}
			
			
		}
		
		public function fuckPidor (id:int) : void
		{
			removeChild(pidorList[id]);
			pidorList[id] = null;	
		}
		public function molnijaPidora (id:int) : void
		{
			//removeChild(pidorList[id]);
			//pidorList[id] = null;
			
			var pidoras:Unit = pidorList[id];
			if (pidoras == null) return;
			THIS.graphics.lineStyle(0, 0xffff00, 0.6);
			THIS.graphics.moveTo(pidoras.pathX[0], pidoras.pathY[0]);
			for (var i:int = 1; i < pidoras.pathCnt; ++i) 
			{
				THIS.graphics.lineTo(pidoras.pathX[i], pidoras.pathY[i]);
			}
		}
		
	}

}