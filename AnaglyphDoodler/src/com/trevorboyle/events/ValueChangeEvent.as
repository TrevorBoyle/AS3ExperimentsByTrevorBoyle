package com.trevorboyle.events {
	import flash.events.Event;

	/**
	 * @author Trevor Boyle
	 */
	public class ValueChangeEvent extends Event {
		public static const VALUE_CHANGE:String = "VALUE_CHANGE";

		public var value:Number;
		public var identifier:String;

		public function ValueChangeEvent(type : String, newValue:Number, identifier:String = "", bubbles : Boolean = false, cancelable : Boolean = false) {
			super(type, bubbles, cancelable);

			this.value = newValue;
			this.identifier = identifier;
		}

		public override function clone():Event
        {
            return new ValueChangeEvent(type, this.value, identifier, bubbles, cancelable);
        }

        public override function toString():String
        {
            return formatToString("ValueChangeEvent", "value", "identifier", "bubbles", "cancelable");
        }
	}
}
