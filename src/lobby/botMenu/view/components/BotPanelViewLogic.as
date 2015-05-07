package lobby.botMenu.view.components
{
	import core.config.GeneralEventsConst;
	import core.utils.SoundLib;
	import core.view.components.ViewLogic;
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	public class BotPanelViewLogic extends ViewLogic
	{
		private var _muteBtn:MovieClip;
		private var _fullScreenBtn:SimpleButton;
		private var _frameMuteBtn:uint = 1;
		private var _lifesPic:MovieClip;
		private var _minuteTf:TextField;
		private var _secondTf:TextField;
		
		public function BotPanelViewLogic()
		{
			super("BotPanel");
			botPaneLoad();
		}
		
		private function get botPanel():MovieClip
		{
			return content as MovieClip;
		}
		
		private function botPaneLoad():void
		{
			_muteBtn = botPanel["muteBtn"];
			_muteBtn.addEventListener(MouseEvent.CLICK, onMuteBtnClickHand);
			_fullScreenBtn = botPanel["fullScreenBtn"];
			_fullScreenBtn.addEventListener(MouseEvent.CLICK, onFullScreenBtnClickHand);
			_lifesPic = botPanel["lifesPic"];
			_lifesPic.gotoAndStop(11);
		}
		
		protected function onMuteBtnClickHand(event:MouseEvent):void
		{
			SoundLib.getInstance().btnClickSound();
			if (_frameMuteBtn == 1)
			{
				_frameMuteBtn = 2;
			}
			else 
			{
				_frameMuteBtn = 1;
			}
			botPanel.muteBtn.gotoAndStop(_frameMuteBtn);
			dispatchEvent(new Event(GeneralEventsConst.MUTE));
		}
		
		protected function onFullScreenBtnClickHand(event:MouseEvent):void
		{
			SoundLib.getInstance().btnClickSound();
			dispatchEvent(new Event(GeneralEventsConst.FULL_SCREEN));
		}
		public function lifesCounterUpdated(lifesValue:int):void
		{
			_lifesPic.gotoAndStop(lifesValue + 1);
		}
		public function timerUpdated(minSec:Array):void
		{
			(botPanel.stopAnim as MovieClip).visible = (minSec[2] as Boolean);
			_minuteTf = botPanel.minute.valueTf;
			_secondTf = botPanel.second.valueTf;
			if (minSec[1]<=9)
			{
				_secondTf.text = "0" + minSec[1].toString(10);
			}
			else
			{
				_secondTf.text = minSec[1].toString(10);
			}
			if (minSec[0]<=9)
			{
				_minuteTf.text = "0" + minSec[0].toString(10);
			}
			else
			{
				_minuteTf.text = minSec[0].toString(10);
			}
		}
	}
}