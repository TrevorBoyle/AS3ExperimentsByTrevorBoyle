package com.trevorboyle {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * @author Trevor Boyle
	 */
	public class FlockOfBirds extends Sprite {

		//Constants
		private static const MIN_SPAWN_Y_POINT:int = 15;
		private static const MAX_SPAWN_Y_POINT:int = 140;

		private static const MAX_FLOCK_HEIGHT:int = 80;
		private static const MIN_FLOCK_HEIGHT:int = 15;

		private static const MAX_BIRD_SPAWN_DELAY:int = 40;

		private static const MAX_SPAWN_Y_POINT_VARIATION:int = 15;
		private static const MAX_FLOCK_HEIGHT_VARIATION:int = 15;

		private var _sky:Sky;

		private var _birdSpawnYPoint:int = 100;
		private var _flockHeight:int = 100;

		//Timers
		private var _createBirdTimer:Timer;
		private var _flockHeightChangeTimer:Timer;
		private var _birdSpawnYChangeTimer:Timer;

		public function FlockOfBirds() {

			//wait until it is added to the stage and ready before init
			this.addEventListener(Event.ENTER_FRAME, init);
		}

		private function init(e:Event = null):void{
			this.removeEventListener(Event.ENTER_FRAME, init);

			//attach the sky to the stage
			_sky = new Sky();
			this.addChild(_sky);
			_sky.init();

			//create the timer which the y pos at which the birds will spawn
			_birdSpawnYChangeTimer = new Timer(50);
			_birdSpawnYChangeTimer.addEventListener(TimerEvent.TIMER, changeBirdSpawnYPoint);
			_birdSpawnYChangeTimer.start();

			//create the timer which will change the height of the flock
			_flockHeightChangeTimer = new Timer(75);
			_flockHeightChangeTimer.addEventListener(TimerEvent.TIMER, changeFlockHeight);
			_flockHeightChangeTimer.start();

			//creat the first bird
			createNewBirdTimer();
		}

		private function createNewBirdTimer():void{
			_createBirdTimer = new Timer(int(Math.random() * MAX_BIRD_SPAWN_DELAY), 1);
			_createBirdTimer.addEventListener(TimerEvent.TIMER, createNewBird);
			_createBirdTimer.start();
		}

		private function createNewBird(t:TimerEvent = null):void{
			if(_createBirdTimer){
				_createBirdTimer.removeEventListener(TimerEvent.TIMER, createNewBird);
			}

			//init and position bird off stage
			var bird:IBird = BirdFactory.getNewBird();
			bird.init(0 - (100 + (Math.random()*10) ), _birdSpawnYPoint + (Math.random()*_flockHeight));
			addChild(DisplayObject(bird));

			//reactivate the timer to create another bird
			createNewBirdTimer();
		}

		private function changeBirdSpawnYPoint(t:TimerEvent = null):void {
			_birdSpawnYPoint += Math.round( Math.random() * (MAX_SPAWN_Y_POINT_VARIATION*2) ) - MAX_SPAWN_Y_POINT_VARIATION;
			if (_birdSpawnYPoint > MAX_SPAWN_Y_POINT) {
				_birdSpawnYPoint = MAX_SPAWN_Y_POINT;
			} else if (_birdSpawnYPoint < MIN_SPAWN_Y_POINT) {
				_birdSpawnYPoint = MIN_SPAWN_Y_POINT;
			}
		}

		private function changeFlockHeight(t:TimerEvent = null):void {
			_flockHeight += Math.round( Math.random() * (MAX_FLOCK_HEIGHT_VARIATION*2) ) - MAX_FLOCK_HEIGHT_VARIATION;
			if (_flockHeight > MAX_FLOCK_HEIGHT) {
				_flockHeight = MAX_FLOCK_HEIGHT;
			} else if (_flockHeight < MIN_FLOCK_HEIGHT) {
				_flockHeight = MIN_FLOCK_HEIGHT;
			}
		}
	}
}
