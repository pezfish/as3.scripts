﻿package net.abp.ui {	import flash.display.Stage;	import flash.display.MovieClip;	import flash.events.Event;	import flash.events.MouseEvent;	import flash.geom.Rectangle;		import net.abp.ui.events.ScrollBarEvent;		public class CustomScrollBar extends MovieClip {		private var _dragMC:MovieClip;		private var _trackMC:MovieClip;				private var _rect:Rectangle		private var _range:Number;				public function CustomScrollBar(clip:MovieClip ) {			_dragMC = clip.drag_mc;			_trackMC = clip.track_mc;						_dragMC.buttonMode = true;			_dragMC.mouseChildren = false;			_dragMC.addEventListener(MouseEvent.MOUSE_DOWN, dragMouseDown);						_trackMC.buttonMode = true;			_trackMC.mouseChildren = false;			_trackMC.addEventListener(MouseEvent.CLICK, trackClick);						_range = _trackMC.height - _dragMC.height;						setBounds(_range);		}				private function dragMouseDown(event:MouseEvent):void {			dispatchEvent(new ScrollBarEvent(ScrollBarEvent.SCROLL_START))			_dragMC.stage.addEventListener(MouseEvent.MOUSE_UP, dragMouseUp, false, 0, true);			_dragMC.startDrag(false, _rect);			_dragMC.addEventListener(Event.ENTER_FRAME, onFrame);		}				private function dragMouseUp(event:MouseEvent):void {			dispatchEvent(new ScrollBarEvent(ScrollBarEvent.SCROLL_STOP))			_dragMC.removeEventListener(Event.ENTER_FRAME, onFrame);			_dragMC.stage.removeEventListener(MouseEvent.MOUSE_UP, dragMouseUp);			_dragMC.stopDrag();		}				private function trackClick(event:MouseEvent):void {			forcePosition((event.target.mouseY / event.target.width) / 10);		}				private function setBounds(limit:Number):void {			_rect = new Rectangle(_trackMC.x, _trackMC.y, 0, limit);		}				private function onFrame(event:Event):void {			var amt:Number = (_dragMC.y - _trackMC.y) / _range;			dispatchEvent(new ScrollBarEvent(ScrollBarEvent.UPDATE, amt));		}				public function limitScroll(amt:Number):void {			setBounds(amt*_range);		}				public function forcePosition(amt:Number):void {			_dragMC.y = amt * _range;		}	}}