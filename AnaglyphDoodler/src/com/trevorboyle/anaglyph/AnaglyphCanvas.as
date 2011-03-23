package com.trevorboyle.anaglyph {
	import com.adobe.images.PNGEncoder;
	import com.trevorboyle.geom.Point3D;

	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.net.FileReference;
	import flash.utils.ByteArray;

	/**
	 * @author Trevor Boyle
	 */
	public class AnaglyphCanvas extends AnaglyphSprite {

		public var _lineWidth:int = 1;
		public var _lineDepth:int = 0;

		//previous 3D point to draw from
		private var _previousPoint:Point3D;
		//current 3D point to draw to
		private var _currentPoint:Point3D;

		private var _background:Sprite;

		//current target sprite to draw into
		private var _targetSprite:AnaglyphSprite;
		//array of currently displaying sprites
		private var _spriteArr:Array;

		//counter which determines when a new target sprite should be created, after a long time drawing
		private var _paintCount:int = 0;
		private const MAX_PAINT_COUNT:int = 150;

		//variables used to save image
		private var _fileRef:FileReference;
		private var _byteArr:ByteArray;
		private var _bitmapData:BitmapData;
		private var _imageCounter:int = 1;

		public function AnaglyphCanvas() {
			super();
			init();
		}

		private function init() : void {
			_previousPoint = new Point3D();
			_currentPoint = new Point3D();

			_spriteArr = [];
		}

		private function createNewTargetSprite():void{
			_paintCount = 0;
			_previousPoint = _currentPoint.clone();

			_targetSprite = new AnaglyphSprite();
			_spriteArr.push(_targetSprite);
			this.addChild(_targetSprite);
		}

		public function createInitialDrawings():void{
			createNewTargetSprite();
			AnaglyphWorker.drawCube(_targetSprite, new Point3D((_background.width/2)-200, (_background.height/2)-100, -50), 75, 2);

			createNewTargetSprite();
			AnaglyphWorker.drawPyramid(_targetSprite, new Point3D((_background.width/2)+50, (_background.height/2), 0), 75, 2);
		}

		private function myMouseDown(e:MouseEvent) : void {
			_background.removeEventListener(MouseEvent.MOUSE_DOWN, myMouseDown);

			createNewTargetSprite();

			_previousPoint.setCoordinates(this.mouseX, this.mouseY, lineDepth);

			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, paint);
		}

		private function mouseUp(e:MouseEvent) : void {
			stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, paint);
			_background.addEventListener(MouseEvent.MOUSE_DOWN, myMouseDown);
		}

		private function paint(e:MouseEvent = null) : void {
			_paintCount++;

			if(_paintCount>=MAX_PAINT_COUNT){
				createNewTargetSprite();
			}

			_currentPoint.setCoordinates(this.mouseX, this.mouseY, lineDepth);
			AnaglyphWorker.draw(_targetSprite, _previousPoint, _currentPoint, lineWidth);
			_previousPoint = null;//_currentPoint.clone();
		}

		public function save():void{
            _bitmapData = new BitmapData(_background.width, _background.height);
            _bitmapData.draw(this, new Matrix());

			//var jpgEncode:JPGEncoder = new JPGEncoder(100);
			//_ba = jpgEncode.encode(_bitmapData);
			_byteArr = PNGEncoder.encode(_bitmapData);
			_fileRef = new FileReference();
			_fileRef.save(_byteArr,"MyAnaglyph_"+_imageCounter+".png");
			_imageCounter++;
 		}

		public function undo():void{
			var sprite:AnaglyphSprite = AnaglyphSprite(_spriteArr.pop());

			if(sprite && sprite.parent) {
				sprite.parent.removeChild(sprite);
			}
		}

		public function clear():void{
			var tempLength:int = _spriteArr.length;
			for(var i:int =0; i<tempLength; i++){
				undo();
			}
		}

		public function drawBackground(width:Number, height:Number):void{
			if(!_background){
				_background = new Sprite();
				_background.name = "background";
				_background.addEventListener(MouseEvent.MOUSE_DOWN, myMouseDown);
			}

			_background.graphics.clear();
			_background.graphics.beginFill(0xFFFFFF, 1);
			_background.graphics.drawRect(0, 0, width, height);
			_background.graphics.endFill();
			this.addChildAt(_background, 0);
		}

		public function get lineWidth() : int {
			return _lineWidth;
		}

		public function set lineWidth(lineWidth : int) : void {
			_lineWidth = lineWidth;
		}

		public function get lineDepth() : int {
			return _lineDepth;
		}

		public function set lineDepth(lineDepth : int) : void {
			_lineDepth = lineDepth;
		}
	}
}