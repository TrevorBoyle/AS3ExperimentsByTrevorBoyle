package com.trevorboyle {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;

	/**
	 * @author Trevor Boyle
	 */
	public class GenericBird extends Sprite implements IBird {

		//constants
		private static const BASE_SPEED:int = 6;
		private static const ADDITIONAL_RANDOM_SPEED:int = 4;
		private static const CHANCE_OF_Y_POS_CHANGE:int = 3;
		private static const MAX_ANIM_FRAMES:int = 8;

		private var _speed:int;
		private var _frameCounter:int = 0;

		//display
		private var _body:Sprite;
		private var _upWing:Sprite;
		private var _downWing:Sprite;

		public function GenericBird() {
			draw();
		}

		public function init(xPos:int, yPos:int) : void{
			this.x = xPos;
			this.y = yPos;

			//randomise bird speed
			this.speed = int(Math.random() * ADDITIONAL_RANDOM_SPEED) + BASE_SPEED;

			this.addEventListener(Event.ENTER_FRAME, animate);
		}

		private function draw() : void {
			_body = new Sprite();
			_body.graphics.beginFill(0x4b232b, 1);
			_body.graphics.drawRect(0, -1, 4, 2);
			_body.graphics.endFill();

			_upWing = new Sprite();
			_upWing.graphics.beginFill(0x764a3f, 1);
			_upWing.graphics.drawRect(1.5, -3, 1, 2);
			_upWing.graphics.endFill();

			_downWing = new Sprite();
			_downWing = new Sprite();
			_downWing.graphics.beginFill(0x1f1a16, 1);
			_downWing.graphics.drawRect(1.5, 1, 1, 1);
			_downWing.graphics.endFill();

			this.addChild(_upWing);
			this.addChild(_downWing);
			this.addChild(_body);
		}

		public function animate(e:Event = null) : void {
			this.x += this.speed;

			if( this.localToGlobal(new Point()).x > stage.stageWidth){
				//if off the stage, destroy
				destroy();
			}else{
				//cycle through animation frames
				this._frameCounter++;
				if(this._frameCounter > MAX_ANIM_FRAMES){
					_frameCounter = 1;
				}

				//flap the wings
				switch(_frameCounter){
					case 1:
					case 5:
						_upWing.visible = false;
						_downWing.visible = false;
						break;
					case 2:
					case 3:
					case 4:
						_upWing.visible = true;
						_downWing.visible = false;
						break;
					case 6:
					case 7:
					case 8:
						_upWing.visible = false;
						_downWing.visible = true;
						break;
				}

				//move the bird up and down to give the sense of flapping
				var changeYPos:int = int(Math.random() * CHANCE_OF_Y_POS_CHANGE);
				if (changeYPos == 0){
					this.y++;
				} else if (changeYPos == 1){
					this.y--;
				}
			}
		}

		public function set speed(sp:int):void{
			_speed = sp;
		}

		public function get speed():int{
			return _speed;
		}

		public function destroy():void{
			this.removeEventListener(Event.ENTER_FRAME, animate);
			if(this.parent!=null){
				parent.removeChild(this);
			}
		}
	}
}
