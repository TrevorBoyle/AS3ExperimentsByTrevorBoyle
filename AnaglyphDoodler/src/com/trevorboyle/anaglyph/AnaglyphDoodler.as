package com.trevorboyle.anaglyph {
	import com.trevorboyle.events.ValueChangeEvent;

	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * @author Trevor Boyle
	 */
	public class AnaglyphDoodler extends Sprite{

		private var _canvas:AnaglyphCanvas;

		private var _controls:AnaglyphControls;

		public function AnaglyphDoodler() {
			//wait until it is added to the stage and ready before init
			this.addEventListener(Event.ENTER_FRAME, init);
		}

		private function init(e:Event = null):void{
			this.removeEventListener(Event.ENTER_FRAME, init);

			initCanvas();

			initControls();

			stage.addEventListener(Event.RESIZE, resizeHandler);
			resizeHandler();

			_canvas.createInitialDrawings();
		}

		private function initCanvas():void{
			_canvas = new AnaglyphCanvas();
			addChildAt(_canvas, 0);
		}

		private function initControls():void{
			_controls = new AnaglyphControls();

			_controls.addEventListener(AnaglyphControls.DEPTH_CHANGED, lineDepthChanged);
			_controls.addEventListener(AnaglyphControls.WIDTH_CHANGED, lineWidthChanged);
			_controls.addEventListener(AnaglyphControls.UNDO_COMMAND, clearLast);
			_controls.addEventListener(AnaglyphControls.CLEAR_COMMAND, clearAll);
			_controls.addEventListener(AnaglyphControls.SAVE_COMMAND, saveImage);

			_controls.update();
			addChild(_controls);
		}

		private function clearLast(e:Event = null) : void {
			_canvas.undo();
		}

		private function clearAll(e:Event = null) : void {
			_canvas.clear();
		}

		private function saveImage(e:Event = null) : void {
			_canvas.save();
		}

		private function resizeHandler(e:Event = null):void{
			_controls.drawBackground();
			_controls.y = stage.stageHeight - _controls.height;

			_canvas.drawBackground(stage.stageWidth, stage.stageHeight - _controls.height);
		}

		private function lineDepthChanged(e:ValueChangeEvent) : void {
			setLineDepth(e.value);
		}

		private function lineWidthChanged(e:ValueChangeEvent) : void {
			setLineWidth(e.value);
		}

		private function setLineWidth(lineWidth : int) : void {
			_canvas.lineWidth = lineWidth;
		}

		private function setLineDepth(lineDepth : int) : void {
			_canvas.lineDepth = lineDepth;
		}
	}
}
