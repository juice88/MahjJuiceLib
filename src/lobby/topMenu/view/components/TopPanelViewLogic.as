package lobby.topMenu.view.components
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	import com.greensock.plugins.EndArrayPlugin;
	import com.greensock.plugins.TweenPlugin;
	
	import core.config.GeneralEventsConst;
	import core.utils.SoundLib;
	import core.view.components.ViewLogic;
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	

	public class TopPanelViewLogic extends ViewLogic
	{
		private var _menuBtn:SimpleButton;
		private var _restartBtn:SimpleButton;
		private var _pauseBtn:SimpleButton;
		private var _movesTf:TextField;
		private var _scoreTf:TextField;
		private var _scoreArr:Array;
		private var _lvlsTf:TextField;
		
		public function TopPanelViewLogic()
		{
			super("TopPanel");
			topPanelLoad();
		}
		
		private function get topPanel():MovieClip
		{
			return content as MovieClip;
		}
		
		private function topPanelLoad():void
		{
			TweenPlugin.activate([EndArrayPlugin]);
			_scoreTf = topPanel.scoreTf.scoreTf;
			_menuBtn = topPanel["menuBtn"];
			_menuBtn.addEventListener(MouseEvent.CLICK, onMenuBtnClick);
			_restartBtn = topPanel["restartBtn"];
			_restartBtn.addEventListener(MouseEvent.CLICK, onRestartBtnClick);
			_pauseBtn = topPanel["pauseBtn"];
			_pauseBtn.addEventListener(MouseEvent.CLICK, onPauseBtnClick);
		}
		
		protected function onMenuBtnClick(event:MouseEvent):void
		{
			SoundLib.getInstance().btnClickSound();
			dispatchEvent(new Event(GeneralEventsConst.GO_TO_MENU));
		}
		
		protected function onRestartBtnClick(event:MouseEvent):void
		{
			SoundLib.getInstance().btnClickSound();
			dispatchEvent(new Event(GeneralEventsConst.RESTART_GAME));
			resetMouseCounter();
		}
		
		protected function onPauseBtnClick(event:MouseEvent):void
		{
			SoundLib.getInstance().btnClickSound();
			dispatchEvent(new Event(GeneralEventsConst.PAUSE));
		}
		
		public function movesCounterUpdate(moves:uint):void
		{
			_movesTf = topPanel.movesTf.movesTf;
			_movesTf.text = moves.toString(10);
		}
		
		private function resetMouseCounter():void //при рестарті обнуляємо лічильник ходів
		{
			if (_movesTf!=null)
			{
				_movesTf.text = String(0);
			}
		}
		
		public function scoreCounterUpdate(scoreValue:uint):void
		{
			_scoreArr = [parseInt(_scoreTf.text)];
			var diffVal:int;
			if (_scoreArr[0] == 0)
			{
				diffVal = 0;
				_scoreArr = [scoreValue];
			}
			else if (_scoreArr[0] != 0)
			{
				diffVal = scoreValue - _scoreArr[0];
			}
			TweenLite.to(_scoreArr, 2, {endArray:[_scoreArr[0]+diffVal], ease:Linear.easeNone, onUpdate:writeScore});
		}
		
		private function writeScore():void
		{
			_scoreTf.text = String(_scoreArr[0]);
		}
		
		public function lvlsCountUpdate(lvlNum:int, totalLvlsNum:String):void
		{
			_lvlsTf = topPanel.lvlsTf;
			if (lvlNum!=0)
			{
				_lvlsTf.text = String(lvlNum)+"/"+totalLvlsNum;
			}
			else
			{
				_lvlsTf.text = String(totalLvlsNum)+"/"+totalLvlsNum;
			}
		}
	}
}