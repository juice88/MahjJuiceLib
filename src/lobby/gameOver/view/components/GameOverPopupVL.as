package lobby.gameOver.view.components
{
	import core.config.GeneralEventsConst;
	import core.utils.SoundLib;
	import core.view.components.DialogViewLogic;
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.setTimeout;

	public class GameOverPopupVL extends DialogViewLogic
	{
		private var _restartBtn:SimpleButton;
		
		public function GameOverPopupVL()
		{
			super("GameOverPopup");
			setTimeout(popupLoad, 4000); //виставляємо затримку до появи GameOverPopup, щоб можна було переглянути ще не відкриті елементи
			
		}
		private function get gameOverPopup():MovieClip
		{
			return content as MovieClip;
		}
		private function popupLoad():void
		{
			gameOverPopup.gotoAndStop(2);
			_restartBtn = gameOverPopup["restartBtn"];
			_restartBtn.addEventListener(MouseEvent.CLICK, onRestartBtnClick);
		}
		
		protected function onRestartBtnClick(event:MouseEvent):void
		{
			SoundLib.getInstance().btnClickSound();
			dispatchEvent(new Event(GeneralEventsConst.RESTART_GAME));
		}
	}
}