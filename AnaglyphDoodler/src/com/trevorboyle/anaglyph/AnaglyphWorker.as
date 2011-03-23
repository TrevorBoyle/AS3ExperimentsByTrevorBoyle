package com.trevorboyle.anaglyph {
	import com.trevorboyle.geom.Point3D;

	import flash.display.Graphics;
	import flash.display.Sprite;

	/**
	 * @author Trevor Boyle
	 */
	public class AnaglyphWorker {

		//Multiplier to convert depth into the red/blue line seperation.
		private static const DEPTH_CONVERSION:Number = 0.05;

		public static function draw(target:IAnaglyphSprite, startPoint3D:Point3D, endPoint3D:Point3D, thickness:int=1):void{

			var blueLayer:Sprite = Sprite(target.blueLayer);
			var blueLayerGraphics:Graphics = blueLayer.graphics;
			var redLayer:Sprite = Sprite(target.redLayer);
			var redLayerGraphics:Graphics = redLayer.graphics;

			blueLayerGraphics.lineStyle(thickness,0x00FFFF,1);
			if(startPoint3D!=null){
				blueLayerGraphics.moveTo(startPoint3D.x+(startPoint3D.z*DEPTH_CONVERSION), startPoint3D.y);
			}
			blueLayerGraphics.lineTo(endPoint3D.x+(endPoint3D.z*DEPTH_CONVERSION), endPoint3D.y);
			blueLayerGraphics.endFill();

			redLayerGraphics.lineStyle(thickness,0xFF0000,1);
			if(startPoint3D!=null){
				redLayerGraphics.moveTo(startPoint3D.x-(startPoint3D.z*DEPTH_CONVERSION), startPoint3D.y);
			}
			redLayerGraphics.lineTo(endPoint3D.x-(endPoint3D.z*DEPTH_CONVERSION), endPoint3D.y);
			redLayerGraphics.endFill();
		}

		public static function drawCube(target:IAnaglyphSprite, startPoint3D:Point3D, sideLength:Number = 100, thickness:int=1):void{
			var blueLayer:Sprite = Sprite(target.blueLayer);
			var blueLayerGraphics:Graphics = blueLayer.graphics;
			var redLayer:Sprite = Sprite(target.redLayer);
			var redLayerGraphics:Graphics = redLayer.graphics;

			var zDepth:Number = (startPoint3D.z*DEPTH_CONVERSION);
			var sideLengthDepth:Number = (sideLength*DEPTH_CONVERSION);

			blueLayerGraphics.lineStyle(thickness,0x00FFFF,1);
			blueLayerGraphics.moveTo(startPoint3D.x + zDepth, startPoint3D.y);//left top
			blueLayerGraphics.lineTo(startPoint3D.x + zDepth, startPoint3D.y + sideLength);//left bottom
			blueLayerGraphics.lineTo((startPoint3D.x + sideLength) + (zDepth + sideLengthDepth), startPoint3D.y + (sideLength*1.5));//middle bottom
			blueLayerGraphics.lineTo((startPoint3D.x + (sideLength*2)) + zDepth, startPoint3D.y + sideLength);//right bottom
			blueLayerGraphics.lineTo((startPoint3D.x + (sideLength*2)) + zDepth, startPoint3D.y);//right top
			blueLayerGraphics.lineTo((startPoint3D.x + sideLength) + (zDepth + sideLengthDepth), startPoint3D.y + (sideLength*0.5));//middle top
			blueLayerGraphics.lineTo(startPoint3D.x + zDepth, startPoint3D.y);//left top
			blueLayerGraphics.moveTo((startPoint3D.x + sideLength) + (zDepth + sideLengthDepth), startPoint3D.y + (sideLength*0.5));//middle top
			blueLayerGraphics.lineTo((startPoint3D.x + sideLength) + (zDepth + sideLengthDepth), startPoint3D.y + (sideLength*1.5));//middle bottom
			blueLayerGraphics.moveTo(startPoint3D.x + zDepth, startPoint3D.y);//left top
			blueLayerGraphics.lineTo((startPoint3D.x + sideLength) + (zDepth - sideLengthDepth), startPoint3D.y - (sideLength*0.5));//middle back
			blueLayerGraphics.lineTo((startPoint3D.x + (sideLength*2)) + zDepth, startPoint3D.y);//right top
			blueLayerGraphics.endFill();

			redLayerGraphics.lineStyle(thickness,0xFF0000,1);
			redLayerGraphics.moveTo(startPoint3D.x - zDepth, startPoint3D.y);//left top
			redLayerGraphics.lineTo(startPoint3D.x - zDepth, startPoint3D.y + sideLength);//left bottom
			redLayerGraphics.lineTo((startPoint3D.x + sideLength) - (zDepth + sideLengthDepth), startPoint3D.y + (sideLength*1.5));//middle bottom
			redLayerGraphics.lineTo((startPoint3D.x + (sideLength*2)) - zDepth, startPoint3D.y + sideLength);//right bottom
			redLayerGraphics.lineTo((startPoint3D.x + (sideLength*2)) - zDepth, startPoint3D.y);//right top
			redLayerGraphics.lineTo((startPoint3D.x + sideLength) - (zDepth + sideLengthDepth), startPoint3D.y + (sideLength*0.5));//middle top
			redLayerGraphics.lineTo(startPoint3D.x - zDepth, startPoint3D.y);//left top
			redLayerGraphics.moveTo((startPoint3D.x + sideLength) - (zDepth + sideLengthDepth), startPoint3D.y + (sideLength*0.5));//middle top
			redLayerGraphics.lineTo((startPoint3D.x + sideLength) - (zDepth + sideLengthDepth), startPoint3D.y + (sideLength*1.5));//middle bottom
			redLayerGraphics.moveTo(startPoint3D.x - zDepth, startPoint3D.y);//left top
			redLayerGraphics.lineTo((startPoint3D.x + sideLength) - (zDepth - sideLengthDepth), startPoint3D.y - (sideLength*0.5));//middle back
			redLayerGraphics.lineTo((startPoint3D.x + (sideLength*2)) - zDepth, startPoint3D.y);//right top
			redLayerGraphics.endFill();
		}

		public static function drawPyramid(target:IAnaglyphSprite, startPoint3D:Point3D, sideLength:Number = 100, thickness:int = 1):void{
			var blueLayer:Sprite = Sprite(target.blueLayer);
			var blueLayerGraphics:Graphics = blueLayer.graphics;
			var redLayer:Sprite = Sprite(target.redLayer);
			var redLayerGraphics:Graphics = redLayer.graphics;

			var zDepth:Number = (startPoint3D.z*DEPTH_CONVERSION);
			var sideLengthDepth:Number = (sideLength*DEPTH_CONVERSION);

			blueLayerGraphics.lineStyle(thickness,0x00FFFF,1);
			blueLayerGraphics.moveTo(startPoint3D.x + zDepth, startPoint3D.y + sideLength);//left bottom
			blueLayerGraphics.lineTo((startPoint3D.x + sideLength) + (zDepth + sideLengthDepth), startPoint3D.y + (sideLength*1.5));//middle bottom
			blueLayerGraphics.lineTo((startPoint3D.x + (sideLength*2)) + zDepth, startPoint3D.y + sideLength);//right bottom
			blueLayerGraphics.lineTo((startPoint3D.x + sideLength) + zDepth, startPoint3D.y - (sideLength*0.5));//middle back
			blueLayerGraphics.lineTo(startPoint3D.x + zDepth, startPoint3D.y + sideLength);//left bottom
			blueLayerGraphics.moveTo((startPoint3D.x + sideLength) + zDepth, startPoint3D.y - (sideLength*0.5));//middle back
			blueLayerGraphics.lineTo((startPoint3D.x + sideLength) + (zDepth + sideLengthDepth), startPoint3D.y + (sideLength*1.5));//middle bottom
			blueLayerGraphics.endFill();

			redLayerGraphics.lineStyle(thickness,0xFF0000,1);
			redLayerGraphics.moveTo(startPoint3D.x - zDepth, startPoint3D.y + sideLength);//left bottom
			redLayerGraphics.lineTo((startPoint3D.x + sideLength) - (zDepth + sideLengthDepth), startPoint3D.y + (sideLength*1.5));//middle bottom
			redLayerGraphics.lineTo((startPoint3D.x + (sideLength*2)) - zDepth, startPoint3D.y + sideLength);//right bottom
			redLayerGraphics.lineTo((startPoint3D.x + sideLength) - zDepth, startPoint3D.y - (sideLength*0.5));//apex
			redLayerGraphics.lineTo(startPoint3D.x - zDepth, startPoint3D.y + sideLength);//left bottom
			redLayerGraphics.moveTo((startPoint3D.x + sideLength) - zDepth, startPoint3D.y - (sideLength*0.5));//apex
			redLayerGraphics.lineTo((startPoint3D.x + sideLength) - (zDepth + sideLengthDepth), startPoint3D.y + (sideLength*1.5));//middle bottom
			redLayerGraphics.endFill();
		}
	}
}
