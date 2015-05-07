package lobby.win.view.components
{
	import core.config.GeneralEventsConst;
	import core.utils.SoundLib;
	import core.view.components.DialogViewLogic;
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	public class WinPopupVL extends DialogViewLogic
	{
		private var _scoreOfSomeLvlTf:TextField;
		private var _trueMoves:TextField;
		private var _falseMoves:TextField;
		private var _nextBtn:SimpleButton;
		
		public function WinPopupVL()
		{
			super("WinPopup");
			winPopupLoad();
		}
		
		private function get winPopup():MovieClip
		{
			return content as MovieClip;
		}
		
		private function winPopupLoad():void
		{
			winPopup.visible = false;
			winPopup.gotoAndStop(2);
		}
		
		public function ScoreTrueFalseCounters(value:Array):void
		{
			winPopup.gotoAndStop(2);
			_scoreOfSomeLvlTf = winPopup.scoreOfSomeLvlTf.scoreTf;
			_scoreOfSomeLvlTf.text = value[0].toString(10);
			_trueMoves = winPopup.trueMoves.movesTf;
			_trueMoves.text = value[1].toString(10);
			_falseMoves = winPopup.falseMoves.movesTf;
			_falseMoves.text = value[2].toString(10);
			_nextBtn = winPopup["nextBtn"];
			_nextBtn.addEventListener(MouseEvent.CLICK, onNextBtnClickHand);
			winPopup.visible = true;
		}
		
		protected function onNextBtnClickHand(event:Event):void
		{
			SoundLib.getInstance().btnClickSound();
			dispatchEvent(new Event(GeneralEventsConst.NEXT_LEVEL));
		}
	}
}