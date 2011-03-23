package com.trevorboyle.anaglyph {
	import flash.display.Sprite;

	/**
	 * @author Trevor Boyle
	 */
	public interface IAnaglyphSprite {
		function get blueLayer():Sprite;
		function get redLayer():Sprite;
	}
}
