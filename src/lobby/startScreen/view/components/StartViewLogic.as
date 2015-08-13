package lobby.startScreen.view.components
{
	import core.config.GeneralEventsConst;
	import core.utils.SoundLib;
	import core.view.components.ViewLogic;
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class StartViewLogic extends ViewLogic
	{
		private var _btnPanel:MovieClip;
		private var _newGameBtn:SimpleButton;
		private var _continueGameBtn:SimpleButton;
		private var _settingsBtn:SimpleButton;
		private var _choiseLvlBtn:SimpleButton;
		private var _tutorialBtn:SimpleButton;
		private var _scoreBoardBtn:SimpleButton;
		
		public function StartViewLogic()
		{
			super("StartScreen");
			startUpScreenLoad();
		}
		private function get startContent():Sprite{
			return content as Sprite;
		}
		
		private function startUpScreenLoad():void
		{
			_btnPanel = startContent["btnPanel"];
			_newGameBtn = _btnPanel["newGameBtn"];
			_newGameBtn.addEventListener(MouseEvent.CLICK, onNewGameBtnClickHand);
			_continueGameBtn = _btnPanel["continueGameBtn"];
			_continueGameBtn.addEventListener(MouseEvent.CLICK, onContinueGameBtnClicHand);
			_continueGameBtn.visible = false;
			_choiseLvlBtn = _btnPanel["choiseLvlBtn"];
			_choiseLvlBtn.addEventListener(MouseEvent.CLICK, onChoiseLvlBtnClickHand);
			_settingsBtn = startContent["settingsBtn"];
			_settingsBtn.addEventListener(MouseEvent.CLICK, onSettingsBtnClickHand);
			_tutorialBtn = startContent["tutorialBtn"];
			_tutorialBtn.addEventListener(MouseEvent.CLICK, onTutorialaBtnClickHand);
			_scoreBoardBtn = startContent["scoreBoardBtn"];
			_scoreBoardBtn.addEventListener(MouseEvent.CLICK, onScoreBoardBtnClickHand);
		}
		
		protected function onNewGameBtnClickHand(event:MouseEvent):void
		{
			SoundLib.getInstance().btnClickSound();
			dispatchEvent(new Event(GeneralEventsConst.START_NEW_GAME));
		}
		
		protected function onContinueGameBtnClicHand(event:MouseEvent):void
		{
			SoundLib.getInstance().btnClickSound();
			dispatchEvent(new Event(GeneralEventsConst.CONTINUE_GAME));
		}
		
		protected function onSettingsBtnClickHand(event:MouseEvent):void
		{
			SoundLib.getInstance().btnClickSound();
			dispatchEvent(new Event(GeneralEventsConst.SHOW_SETTINGS_PANEL));
		}
		
		protected function onChoiseLvlBtnClickHand(event:MouseEvent):void
		{
			SoundLib.getInstance().btnClickSound();
			dispatchEvent(new Event(GeneralEventsConst.CHOISE_OF_LEVEL));
		}
		
		protected function onTutorialaBtnClickHand(event:MouseEvent):void
		{
			SoundLib.getInstance().btnClickSound();
			dispatchEvent(new Event(GeneralEventsConst.TUTORIAL_SHOW));
		}
		
		protected function onScoreBoardBtnClickHand(event:MouseEvent):void
		{
			SoundLib.getInstance().btnClickSound();
			dispatchEvent(new Event(GeneralEventsConst.SCORE_BOARD_SHOW));
		}
		
		public function continueGameBtnIsVis():void
		{
			_continueGameBtn.visible = true;
		}
	}
}