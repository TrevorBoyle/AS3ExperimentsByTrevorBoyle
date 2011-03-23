package com.trevorboyle.anaglyph {
	import flash.display.BlendMode;
	import flash.display.Sprite;

	/**
	 * @author Trevor Boyle
	 */
	public class AnaglyphSprite extends Sprite implements IAnaglyphSprite {
		private var _blueLayer:Sprite;
		private var _redLayer:Sprite;

		public function AnaglyphSprite(){
			_redLayer = new Sprite();
			addChild(_redLayer);

			_blueLayer = new Sprite();
			addChild(_blueLayer);

			_blueLayer.blendMode = BlendMode.MULTIPLY;
		}

		public function get blueLayer() : Sprite {
			return _blueLayer;
		}

		public function get redLayer() : Sprite {
			return _redLayer;
		}
	}
}
