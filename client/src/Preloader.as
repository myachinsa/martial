package 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.filters.BlurFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.getDefinitionByName;
	
	/**
	 * ...
	 * @author myachin
	 */
	public class Preloader extends MovieClip 
	{

		
		public static var coefficients:Array = [];
		
		public static var firstScreen:Sprite = new Sprite;
		
		public static var curve:Sprite = new Sprite;
		
		public static var fbBmpData:BitmapData = new BitmapData(1000, 1000, true, 0xff000000);
		public static var fbBmp:Bitmap = new Bitmap(fbBmpData);
		
		public static var fbBmpCont:Sprite = new Sprite;
		public static var curveCont:Sprite = new Sprite;
		
		public function Preloader() 
		{
			addChild(firstScreen);
			
			if (stage) {
				stage.scaleMode = StageScaleMode.NO_SCALE;
				stage.align = StageAlign.TOP_LEFT;
			}
			addEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.addEventListener(ProgressEvent.PROGRESS, progress);
			loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioError);
			
			// TODO show loader
			
			for (var i:int = 0; i < 33000; i++) 
			{
				coefficients[i] = Math.random();
			}
			
			fbBmp.x = -500;
			fbBmp.y = -500;
			fbBmpCont.addChild(fbBmp);
			
			fbBmpCont.scaleX = 1.05;
			fbBmpCont.scaleY = 1.05;
			fbBmpCont.x = 400;
			fbBmpCont.y = 300;
			firstScreen.addChild(fbBmpCont);
			//addChild(curve);
			
			curve.alpha = 0.5;
			fbBmp.alpha = 0.98;
			
			curveCont.addChild( curve );
			
			addEventListener(Event.ENTER_FRAME, function(e:Event):void { 
					if (firstScreen.visible)
					{
						tau += 0.01;
						if (tau > 1) tau = 0;
						drawCurve( tau );
						fbBmpCont.rotation += 1;					
						alpha += 0.1;
					}
				} );			
		}
		
		private function ioError(e:IOErrorEvent):void 
		{
			trace(e.text);
		}
		
		private function progress(e:ProgressEvent):void 
		{
			// TODO update loader
			
			var value:Number = e.bytesLoaded / e.bytesTotal;
			

		}
		

		
		public function drawCurve ( value:Number ):void
		{
			curve.graphics.clear();
			curve.graphics.beginFill(Math.random()*0xffffff, 0.3);
			curve.graphics.lineStyle(0, 0x888888, 0.6);
			
			var xprev:Number = 0;
			var yprev:Number = 0;
			
			for (var i:int = 0; i < 100 * value; i++) 
			{
				var x0:Number, y0:Number;
				
				x0 = 0;
				y0 = 0;
				
				for (var j:int = 0; j < 50; j++) 
				{
					x0 += 100*coefficients[j * 6] * Math.cos(  0.3 *(0.5+value)* i * coefficients[j * 6 + 1] + 6 * coefficients[j * 6 + 2]) ;
					y0 += 100*coefficients[j * 6 + 3] * Math.cos( 0.3 *(0.5+value)* i * coefficients[j * 6 + 4] + 6 * coefficients[j * 6 + 5]) ;
				
				}
				if (i==0) curve.graphics.moveTo(x0,y0);
				curve.graphics.curveTo(x0, y0, xprev, yprev);
				
				xprev = x0;
				yprev = y0;
			}
			
			curve.width = 60 +0.9*curve.width;
			curve.height = 40 +0.9*curve.height;
			
			curve.x = 400;
			curve.y = 300;		
			
			if (main) main.alpha = 0.1;
			
			
			fbBmpData.draw( this, null, null, BlendMode.DIFFERENCE );
			fbBmpData.draw( curveCont );
			if (main) main.alpha = 1.0;
			
			//fbBmpData.applyFilter( fbBmpData, new Rectangle(100, 100, 600, 400), new Point(0, 0), new BlurFilter() );
			fbBmp.bitmapData = fbBmpData;
		}
		
		private function checkFrame(e:Event):void 
		{
			if (currentFrame == totalFrames) 
			{
				stop();
				loadingFinished();
			}
		}
		
		private function loadingFinished():void 
		{
			removeEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.removeEventListener(ProgressEvent.PROGRESS, progress);
			loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioError);
			
			// TODO hide loader
			
			startup();
		}
		
		public static var tau:Number = 0;
		public static var alpha:Number = 0;
		
		public static var main:DisplayObject = null;
		
		private function startup():void 
		{
			var mainClass:Class = getDefinitionByName("Main") as Class;
			main = new mainClass() as DisplayObject
			addChild(main);
			

		}
		
	}
	
}