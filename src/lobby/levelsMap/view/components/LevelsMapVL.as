package lobby.levelsMap.view.components
{
	import core.config.GameEvent;
	import core.config.GeneralEventsConst;
	import core.utils.Warehouse;
	import core.view.components.ViewLogic;
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class LevelsMapVL extends ViewLogic
	{
		private var _btnClickNum:int;
		private var _startLvlNumIcon:int;
		private var _finishedLvlNum:int;
		private var _maxNumOfComplLvl:int;
		private var _currentLvl:int;
		private var _nameCategory:String;
		
		private var _shablon:String = "shablon";
		private var _hide:String = "hide";
		private var _show:String = "show";
		
		private var _backBtn:SimpleButton;
		
		public function LevelsMapVL(btnNum:int, lvlNum:int, lvlMaxNum:int)
		{
			super("LvlsMap");
			_btnClickNum = btnNum;
			_finishedLvlNum = lvlNum;
			_maxNumOfComplLvl = lvlMaxNum;
			loadLvlsMap();
		}
		
		public function get lvlsMap():MovieClip
		{
			return content as MovieClip;
		}
		
		private function loadLvlsMap():void
		{
			if (_btnClickNum == 1)
			{
				_startLvlNumIcon = 1;
				_nameCategory = "SIMPLE LEVELS";
			}
			else if (_btnClickNum == 2)
			{
				_startLvlNumIcon = 29;
				_nameCategory = "MIDDLE LEVELS";
			}
			else if (_btnClickNum == 3)
			{
				_startLvlNumIcon = 59;
				_nameCategory = "HIGH LEVELS";
			}
			_currentLvl+=_startLvlNumIcon;
			lvlsMap.nameCategory.text = _nameCategory;
			_backBtn = lvlsMap["backBtn"];
			_backBtn.addEventListener(MouseEvent.CLICK, onClickBackBtnHand);
			drawMap();
		}
		
		protected function onClickBackBtnHand(event:MouseEvent):void
		{
			_backBtn.removeEventListener(MouseEvent.CLICK, onClickBackBtnHand);
			dispatchEvent(new Event(GeneralEventsConst.LEVELS_MAP_CLOSE));
		}
		private function drawMap():void
		{
			
			var LvlNumIcon:Class = Warehouse.getInstance().getAssetClass("LvlNumIcon");
			var i:int = 0;
			while (lvlsMap.hasOwnProperty(_shablon+i))
			{
				_currentLvl++;
				var lvlNumIcon:MovieClip = new LvlNumIcon();
				if (_currentLvl == _finishedLvlNum+2)
				{
					lvlNumIcon.currentLvl.gotoAndStop(_show);
				}
				if (_currentLvl<_maxNumOfComplLvl+3)
				{
					lvlNumIcon.block.gotoAndStop(_show);
				}
				lvlNumIcon.lvlNum.text = _startLvlNumIcon++.toString();
				((lvlsMap[_shablon+i]) as MovieClip).addChild(lvlNumIcon);
				(lvlNumIcon.overIcon as MovieClip).addEventListener(MouseEvent.MOUSE_OVER, onMouseOverHand);
				(lvlNumIcon.overIcon as MovieClip).addEventListener(MouseEvent.MOUSE_OUT, onMouseOutHand);
				(lvlNumIcon.overIcon as MovieClip).addEventListener(MouseEvent.CLICK, onClickHand);
				i++;
			}
		}
		
		protected function onMouseOverHand(event:MouseEvent):void
		{
			event.target.parent.overIcon.gotoAndStop(_show);
		}
		
		protected function onMouseOutHand(event:MouseEvent):void
		{
			event.target.parent.overIcon.gotoAndStop(_hide);
		}
		
		protected function onClickHand(event:MouseEvent):void
		{
			dispatchEvent(new GameEvent(GeneralEventsConst.LEVELS_MAP_CHOISE, event.target.parent.lvlNum.text));
		}
	}
}