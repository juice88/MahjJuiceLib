package gamePlay.bonus.view.components
{
	import core.config.GeneralEventsConst;
	import core.utils.SoundLib;
	import core.view.components.DialogViewLogic;
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class BonusPopupVL extends DialogViewLogic
	{
		private var _nextBtn:SimpleButton;
		
		public function BonusPopupVL()
		{
			super("BonusPopup");
			bonusPopupLoad();
		}
		private function get bonusPopup():MovieClip
		{
			return content as MovieClip;
		}
		private function bonusPopupLoad():void
		{
			bonusPopup.gotoAndStop(2);
			_nextBtn = bonusPopup["nextBtn"];
			_nextBtn.addEventListener(MouseEvent.CLICK, onClickNextBtnHand);
		}
		
		protected function onClickNextBtnHand(event:MouseEvent):void
		{
			SoundLib.getInstance().btnClickSound();
			dispatchEvent(new Event(GeneralEventsConst.BONUS_LEVEL_START));
		}
	}
}