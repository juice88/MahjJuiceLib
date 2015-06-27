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
	import flash.utils.setTimeout;

	public class BotPanelViewLogic extends ViewLogic
	{
		private var _settingsBtn:SimpleButton;
		private var _frameMuteBtn:uint = 1;
		private var _lifesPic:MovieClip;
		private var _minuteTf:TextField;
		private var _secondTf:TextField;
		private var _movesHistory:MovieClip;
		private var _icon:String = "icon_";
		
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
			_settingsBtn = botPanel["settingsBtn"];
			_settingsBtn.addEventListener(MouseEvent.CLICK, onSettingsBtnClickHand);
			_lifesPic = botPanel["lifesPic"];
			_lifesPic.gotoAndStop(11);
			_movesHistory = botPanel["movesHistoryIcon"];
			visibleMovesHistoryIcon();
		}
		
		protected function onSettingsBtnClickHand(event:MouseEvent):void
		{
			SoundLib.getInstance().btnClickSound();
			dispatchEvent(new Event(GeneralEventsConst.SHOW_SETTINGS_PANEL));
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
		
		public function visibleMovesHistoryIcon():void
		{
			var i:int = 0;
			while (_movesHistory.hasOwnProperty(_icon+i))
			{
				(_movesHistory[_icon+i] as MovieClip).visible = false;
				i++;
			}
		}
		public function historyMovesUpdated(historyArr:Array):void
		{
			if (historyArr[2] == 0)
			{
				for (var i:int=0; i<historyArr[0]; i++)
				{
					(_movesHistory[_icon+i] as MovieClip).visible = true;
				}
			} else if (historyArr[2] == 1) {
				for (var j:int = 0; j<historyArr.length - 3; j++)
				{
					(_movesHistory[_icon+j] as MovieClip).gotoAndStop(historyArr[3+j]);
				}
			}
			if (historyArr[1])
			{
				setTimeout(cleanMovesHistoryIcon, 500);
			}
		}
		public function cleanMovesHistoryIcon():void
		{
			var i:int = 0;
			while (_movesHistory.hasOwnProperty(_icon+i))
			{
				(_movesHistory[_icon+i] as MovieClip).gotoAndStop(1);
				i++;
			}
		}
	}
}