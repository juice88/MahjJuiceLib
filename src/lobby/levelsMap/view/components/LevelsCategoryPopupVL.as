package lobby.levelsMap.view.components
{
	import core.config.GameEvent;
	import core.config.GeneralEventsConst;
	import core.utils.SoundLib;
	import core.view.components.DialogViewLogic;
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class LevelsCategoryPopupVL extends DialogViewLogic
	{
		private var _closeBtn:SimpleButton;
		private var _simpleLvlsBtn:SimpleButton;
		private var _middleLvlsBtn:SimpleButton;
		private var _highLvlsBtn:SimpleButton;
		
		public function LevelsCategoryPopupVL()
		{
			super("LvlCategoryPopup");
			loadLvlCategory();
		}
		public function get categoryPopup():MovieClip
		{
			return content as MovieClip;
		}
		private function loadLvlCategory():void
		{
			_closeBtn = categoryPopup["closeBtn"];
			_closeBtn.addEventListener(MouseEvent.CLICK, onCloseBtnClickHand);
			_simpleLvlsBtn = categoryPopup["simpleLvlsBtn"];
			_simpleLvlsBtn.addEventListener(MouseEvent.CLICK, onSimlpeLvlsBtnClickHand);
			_middleLvlsBtn = categoryPopup["middleLvlsBtn"];
			_middleLvlsBtn.addEventListener(MouseEvent.CLICK, onMiddleLvlsBtnClickHand);
			_highLvlsBtn = categoryPopup["highLvlsBtn"];
			_highLvlsBtn.addEventListener(MouseEvent.CLICK, onHighLvlsBtnClick);
		}
		
		protected function onCloseBtnClickHand(event:MouseEvent):void
		{
			SoundLib.getInstance().btnClickSound();
			dispatchEvent(new Event(GeneralEventsConst.LEVELS_CATEGORY_POPUP_CLOSE));
		}
		
		protected function onSimlpeLvlsBtnClickHand(event:MouseEvent):void
		{
			SoundLib.getInstance().btnClickSound();		
			dispatchEvent(new GameEvent(GeneralEventsConst.LEVELS_MAP_SHOW, event.currentTarget.name));
		}
		protected function onMiddleLvlsBtnClickHand(event:MouseEvent):void
		{
			SoundLib.getInstance().btnClickSound();
			dispatchEvent(new GameEvent(GeneralEventsConst.LEVELS_MAP_SHOW, event.currentTarget.name));
		}
		
		protected function onHighLvlsBtnClick(event:MouseEvent):void
		{
			SoundLib.getInstance().btnClickSound();
			dispatchEvent(new GameEvent(GeneralEventsConst.LEVELS_MAP_SHOW, event.currentTarget.name));
		}
	}
}