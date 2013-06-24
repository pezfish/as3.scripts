﻿package net.abp.utils {	//import	import flash.utils.Timer;	import flash.events.TimerEvent;	import flash.text.TextField;	import com.adobe.utils.NumberFormatter;		public class Countdown {		//var		private var _currentTime:int;		private var _countDirection:String;		private var _timer:Timer;		private var _onFinish:Function;		private var _displaying:Boolean;		private var _field:TextField;		private var _leadingZero:Boolean;		private var _pauseTime:int;		public function Countdown(time:int, callback:Function, delay:int = 1000, dir:String = "down") {			//init			_currentTime = time;			_countDirection = dir;			_onFinish = callback;			_timer = new Timer(delay);			_timer.addEventListener(TimerEvent.TIMER, onTimer);			_timer.start();		}				public function displayField(tf:TextField, leadingZero:Boolean = true):void {			_displaying = true;			_leadingZero = true;			_field = tf;			updateText();		}				public function pause():void {			_timer.stop();		}				public function unpause():void {			_timer.start();		}				public function clear():void {			_timer.stop();			_timer.removeEventListener(TimerEvent.TIMER, onTimer);			if(_displaying){				_field.text = ":00";			}		}				public function get running():Boolean {			return (_timer.running) ? (true):(false);		}		private function onTimer(event:TimerEvent):void {			if(_currentTime <= 0) {				clear();				_onFinish();			} else {				(_countDirection == "down") ? (_currentTime--) : (_currentTime++);				if(_displaying){					updateText();				}			}		}				private function updateText():void {			if(_leadingZero) {				_field.text = ":"+NumberFormatter.addLeadingZero(_currentTime);			} else {				_field.text = ":"+String(_currentTime);			}		}				private function destruct():void {			//--- cleanup			_timer = null;			_onFinish = null;			_field = null;			//--- cleanup		}			}}