package lobby.startScreen.view.components
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Expo;
	
	import core.config.GameEvent;
	import core.config.GeneralEventsConst;
	import core.utils.MyButton;
	import core.utils.SoundLib;
	import core.utils.Warehouse;
	import core.view.components.ViewLogic;
	
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	public class StartViewLogic extends ViewLogic
	{
		private var _totalNumOfGame:int;
		private var _btnPanel:MovieClip;
		private var _newGameBtn:SimpleButton;
		private var _continueGameBtn:SimpleButton;
		private var _settingsBtn:SimpleButton;
		private var _choiseLvlBtn:SimpleButton;
		private var _tutorialBtn:SimpleButton;
		private var _scoreBoardBtn:SimpleButton;
		private var _scrollBackBtn:SimpleButton;
		private var _scrollNextBtn:SimpleButton;
		private var _gameBtnsBG:Sprite;
		private var _gameBtnsArr:Array;
		
		public function StartViewLogic(totalNumOfGames:int)
		{
			super("StartScreen");
			_totalNumOfGame = totalNumOfGames;
			initStartScreen();
		}
		private function get startContent():Sprite{
			return content as Sprite;
		}
		
		private function initStartScreen():void
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
			_scrollBackBtn = Warehouse.getInstance().getAsset("ScrollBackBtn") as SimpleButton;
			_scrollNextBtn = Warehouse.getInstance().getAsset("ScrollNextBtn") as SimpleButton;
			drawButtonsBackgraund();
			addGamesButtons();
		}
		
		private function drawButtonsBackgraund():void
		{
			_gameBtnsBG = new Sprite();
			var graf:Graphics = _gameBtnsBG.graphics;
			graf.beginFill(0xFF0000, 0);
			if (_totalNumOfGame<=4)
			{
				graf.drawRect(0,150,1280,320);
			} else {
				graf.drawRect(0,150,((250*_totalNumOfGame)+56*(_totalNumOfGame+1)),320);
			}
			graf.endFill();
			startContent.addChild(_gameBtnsBG);
			if (_totalNumOfGame>4) 
			{
				addScrollingBtns();
			}
		}
		
		private function addScrollingBtns():void
		{
			_scrollBackBtn.x = 0;
			_scrollBackBtn.y = 220;
			_scrollNextBtn.x = 1230;
			_scrollNextBtn.y = 220;
			startContent.addChild(_scrollBackBtn);
			_scrollBackBtn.addEventListener(MouseEvent.CLICK, onScrollBackBtnClickHand);
			startContent.addChild(_scrollNextBtn);
			_scrollNextBtn.addEventListener(MouseEvent.CLICK, onScrollNextBtnClickHand);
		}
		
		protected function onScrollBackBtnClickHand(event:MouseEvent):void
		{
			if (_gameBtnsBG.x < 0)
			{
				_scrollBackBtn.removeEventListener(MouseEvent.CLICK, onScrollBackBtnClickHand);
				TweenLite.to(_gameBtnsBG, 0.7, {x:_gameBtnsBG.x + 300, onComplete:moveBackIsComplete});
				TweenLite.to(_btnPanel, 0.7, {x:_btnPanel.x + 300});
			}
		}
		
		protected function onScrollNextBtnClickHand(event:MouseEvent):void
		{
			if (_gameBtnsBG.x >= 0)
			{
				_scrollNextBtn.removeEventListener(MouseEvent.CLICK, onScrollNextBtnClickHand);
				TweenLite.to(_gameBtnsBG, 0.7, {x:_gameBtnsBG.x - 300, onComplete:moveNextIsComplete});
				TweenLite.to(_btnPanel, 0.7, {x:_btnPanel.x - 300});
			}
		}
		
		private function moveBackIsComplete():void
		{
			_scrollBackBtn.addEventListener(MouseEvent.CLICK, onScrollBackBtnClickHand);
		}
		
		private function moveNextIsComplete():void
		{
			_scrollNextBtn.addEventListener(MouseEvent.CLICK, onScrollNextBtnClickHand);
		}
		
		private function addGamesButtons():void
		{
			_gameBtnsArr = new Array();
			for (var i:int = 0; i<_totalNumOfGame; i++)
			{
				var _gameIconMC:MovieClip = Warehouse.getInstance().getAsset("gameBtn_"+i) as MovieClip;
				var _gameBtn:MyButton = new MyButton(_gameIconMC, false);
				_gameIconMC.x = 50+((50+_gameIconMC.width)*i);
				_gameIconMC.y = 200;
				_gameBtnsBG.addChild(_gameIconMC);
				_gameBtn.addEventListener(MouseEvent.CLICK, selectedGameTypeHand);
				_gameBtnsArr.push(_gameBtn);
			}
			positionBtnPanel((_gameBtnsArr[0] as MyButton).content);
	//		(_gameIconMC["text_body"] as TextField).text = "БлаБла";
		}
		
		private function positionBtnPanel(gameBtnIcon:MovieClip):void
		{
			TweenLite.to(_btnPanel, 0.5, {x:gameBtnIcon.x+50 + _gameBtnsBG.x, y:480, ease:Expo.easeOut});
		}
		
		protected function selectedGameTypeHand(event:Event):void
		{
			var gameNum:int= int((event.target as MyButton).buttonText.substr(4))-1;   
			dispatchEvent(new GameEvent(GeneralEventsConst.GAME_TYPE_SELECTED, gameNum));
			positionBtnPanel((event.target as MyButton).content);
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
		
		public function continueGameBtnIsVis(visible:Boolean):void
		{
			_continueGameBtn.visible = visible;
		}
	}
}