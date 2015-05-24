package lobby.startScreen.view.components
{
	import core.config.GeneralEventsConst;
	import core.utils.SoundLib;
	import core.view.components.ViewLogic;
	
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class StartViewLogic extends ViewLogic
	{
		private var _newGameBtn:SimpleButton;
		private var _continueGameBtn:SimpleButton;
		private var _settingsBtn:SimpleButton;
		private var _choiseLvlBtn:SimpleButton;
		
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
			_newGameBtn = startContent["newGameBtn"];
			_newGameBtn.addEventListener(MouseEvent.CLICK, onNewGameBtnClickHand);
			_continueGameBtn = startContent["continueGameBtn"];
			_continueGameBtn.addEventListener(MouseEvent.CLICK, onContinueGameBtnClicHand);
			_continueGameBtn.visible = false;
			_settingsBtn = startContent["settingsBtn"];
			_settingsBtn.addEventListener(MouseEvent.CLICK, onSettingsBtnClickHand);
			_choiseLvlBtn = startContent["choiseLvlBtn"];
			_choiseLvlBtn.addEventListener(MouseEvent.CLICK, onChoiseLvlBtnClickHand);
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
		
		public function continueGameBtnIsVis():void
		{
			_continueGameBtn.visible = true;
		}
	}
}