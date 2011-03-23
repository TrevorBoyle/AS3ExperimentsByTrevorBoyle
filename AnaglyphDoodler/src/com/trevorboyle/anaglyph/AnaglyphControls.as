package com.trevorboyle.anaglyph {
	import com.bit101.components.HUISlider;
	import com.bit101.components.PushButton;
	import com.bit101.components.TextArea;
	import com.trevorboyle.events.ValueChangeEvent;

	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * @author Trevor Boyle
	 */
	public class AnaglyphControls extends Sprite {

		public static const DEPTH_CHANGED:String = "DEPTH_CHANGED";
		public static const WIDTH_CHANGED:String = "WIDTH_CHANGED";
		public static const UNDO_COMMAND:String = "UNDO_COMMAND";
		public static const SAVE_COMMAND:String = "SAVE_COMMAND";
		public static const CLEAR_COMMAND : String = "CLEAR_COMMAND";

		private const HORIZONTAL_COMPONENT_SPACING:int = 20;
		private const VERTICAL_COMPONENT_SPACING:int = 10;

		private const LINE_DEPTH_LABEL:String = "Draw Distance";
		private const LINE_WIDTH_LABEL:String = "Brush Thickness";
		private const UNDO_LABEL:String = "Undo";
		private const RESTART_LABEL:String = "New Picture";
		private const SAVE_IMAGE_LABEL:String = "Save Picture";

		private const INSTRUCTION_TEXT : String = "Instructions:\n1. Put your anaglyph (blue/red) glasses on.\n2. Use the '"+LINE_DEPTH_LABEL+"' slider to choose the line depth/distance.\n3. Use the '"+LINE_WIDTH_LABEL+"' slider to choose the line width.\n4. Click and drag to draw.\n5. '"+SAVE_IMAGE_LABEL+"' to enjoy later.\n\nInfo:\nCreated by Trevor Boyle\nMinimal Comps by Keith Peters\n\nSource Code:\nAvailable on GitHub - https://github.com/TrevorBoyle/AS3ExperimentsByTrevorBoyle";

		private var _instructionText:TextArea;
		private var _lineDepthSlider:HUISlider;
		private var _lineWidthSlider:HUISlider;
		private var _cleanCanvasBtn:PushButton;
		private var _undoBtn:PushButton;
		private var _saveBtn:PushButton;
		private var _background:Sprite;

		public function AnaglyphControls() {
			init();
		}

		private function init():void{
			_instructionText = new TextArea(null, 0, 0, INSTRUCTION_TEXT);
			_instructionText.editable = false;
			_instructionText.width = 340;
			_instructionText.x = 30;
			_instructionText.y = 0;
			addChild(_instructionText);

			_lineDepthSlider = new HUISlider(null, 0, 0, LINE_DEPTH_LABEL, lineDepthChanged);
			_lineDepthSlider.labelPrecision = 0;
			_lineDepthSlider.setSliderParams(-200,200,-100);
			_lineDepthSlider.x = _instructionText.x + _instructionText.width + HORIZONTAL_COMPONENT_SPACING ;
			_lineDepthSlider.y = 0;
			addChild(_lineDepthSlider);
			lineDepthChanged();

			_lineWidthSlider = new HUISlider(null, 0, 0, LINE_WIDTH_LABEL, lineWidthChanged);
			_lineWidthSlider.labelPrecision = 0;
			_lineWidthSlider.setSliderParams(1,5,2);
			_lineWidthSlider.x = _lineDepthSlider.x;
			_lineWidthSlider.y = _lineDepthSlider.y + _lineDepthSlider.height + VERTICAL_COMPONENT_SPACING;
			addChild(_lineWidthSlider);
			lineWidthChanged();

			_undoBtn = new PushButton(null, 0, 0, UNDO_LABEL, undoClicked);
			_undoBtn.x = _lineDepthSlider.x + (_lineDepthSlider.width - 25) + HORIZONTAL_COMPONENT_SPACING;
			_undoBtn.y = 0;
			addChild(_undoBtn);

			_cleanCanvasBtn = new PushButton(null, 0, 0, RESTART_LABEL, cleanClicked);
			_cleanCanvasBtn.x = _undoBtn.x;
			_cleanCanvasBtn.y = _undoBtn.y + _undoBtn.height + VERTICAL_COMPONENT_SPACING;
			addChild(_cleanCanvasBtn);

			_saveBtn = new PushButton(null, 0, 0, SAVE_IMAGE_LABEL, saveClicked);
			_saveBtn.x = _cleanCanvasBtn.x;
			_saveBtn.y = _cleanCanvasBtn.y + _cleanCanvasBtn.height + VERTICAL_COMPONENT_SPACING;
			addChild(_saveBtn);
		}

		public function drawBackground():void{
			if(!_background){
				_background = new Sprite();
				_background.name = "background";
			}

			_background.graphics.clear();
			_background.graphics.beginFill(0xFFFFFF, 1);
			_background.graphics.drawRect(0, 0, stage.stageWidth, this.height + 20);
			_background.graphics.endFill();
			this.addChildAt(_background, 0);
		}

		public function update():void{
			lineDepthChanged();
			lineWidthChanged();
		}

		private function lineDepthChanged(e:Event = null) : void {
			dispatchEvent(new ValueChangeEvent(DEPTH_CHANGED, Math.round(_lineDepthSlider.value)));
		}

		private function lineWidthChanged(e:Event = null) : void {
			dispatchEvent(new ValueChangeEvent(WIDTH_CHANGED, Math.round(_lineWidthSlider.value)));
		}

		private function undoClicked(e:Event = null) : void {
			dispatchEvent(new Event(UNDO_COMMAND));
		}

		private function cleanClicked(e:Event = null) : void {
			dispatchEvent(new Event(CLEAR_COMMAND));
		}

		private function saveClicked(e:Event = null) : void {
			dispatchEvent(new Event(SAVE_COMMAND));
		}
	}
}