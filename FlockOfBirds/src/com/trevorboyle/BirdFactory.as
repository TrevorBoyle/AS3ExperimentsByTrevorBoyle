package com.trevorboyle {

	/**
	 * @author Trevor Boyle
	 */
	public class BirdFactory {
		public static function getNewBird():IBird{
			return new GenericBird();
		}
	}
}
