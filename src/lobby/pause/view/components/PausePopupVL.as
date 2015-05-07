package lobby.pause.view.components
{
	import core.config.GeneralEventsConst;
	import core.utils.SoundLib;
	import core.view.components.DialogViewLogic;
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	public class PausePopupVL extends DialogViewLogic
	{
		private var _pauseContinueBtn:SimpleButton;
		private var _totalScoreTf:TextField;
		
		public function PausePopupVL()
		{
			super("PausePopup");
			popupLoad();
		}
		private function get pausePopup():MovieClip
		{
			return content as MovieClip;
		}
		public function popupLoad():void
		{
			_pauseContinueBtn = pausePopup["pauseContinueBtn"];
			_pauseContinueBtn.addEventListener(MouseEvent.CLICK, onPauseContinueBtnClickHand);
		}
		
		protected function onPauseContinueBtnClickHand(event:MouseEvent):void
		{
			SoundLib.getInstance().btnClickSound();
			dispatchEvent(new Event(GeneralEventsConst.PAUSE_CONTINUE_GAME));
		}
		public function totalScoreUpdated(tatalScore:int):void
		{
			_totalScoreTf = pausePopup.totalScoreTf.scoreTf;
			_totalScoreTf.text = tatalScore.toString(10);
		}
	}
}