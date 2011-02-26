package com.trevorboyle {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Point;

	/**
	 * @author Trevor Boyle
	 */
	public class Sky extends Sprite {

		public function Sky() {
		}

		public function init():void{
			var mySkyBitmapData:BitmapData = new BitmapData(stage.stageWidth, stage.stageHeight, false, 0x87CEEB);
			var mySkyBitmap:Bitmap = new Bitmap(mySkyBitmapData);
			addChild(mySkyBitmap);

			var myCloudBitmapData:BitmapData = new BitmapData(stage.stageWidth, stage.stageHeight);
			myCloudBitmapData.perlinNoise(100, 100, 8, 0, false, true, 1, true);
			myCloudBitmapData.applyFilter(myCloudBitmapData, myCloudBitmapData.rect, new Point(), new ColorMatrixFilter([0,0,0,0,255, 0,0,0,0,255, 0,0,0,0,255, 1,0,0,0,0]));

			var myCloudBitmap:Bitmap = new Bitmap(myCloudBitmapData);
			addChild(myCloudBitmap);
		}
	}
}
