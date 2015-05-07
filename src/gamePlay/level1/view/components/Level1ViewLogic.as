package gamePlay.level1.view.components
{
	import core.config.GameEvent;
	import core.config.GeneralEventsConst;
	import core.levelsConfig.model.dto.ConfigDto;
	import core.utils.SoundLib;
	import core.utils.Warehouse;
	import core.view.components.ViewLogic;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.utils.setTimeout;
	
	import gamePlay.level1.model.dto.ElementDto;
	
	
	public class Level1ViewLogic extends ViewLogic
	{
		private var _shablon:String = "shablon";
		private var _hide:String = "hide";
		private var _show:String = "show";
		
		private var _showElemDelay:int;
		private var _elemName:String;
		
		private var _allElemList:Vector.<MovieClip>; //перелік усіх елементів
		private var _openElemList:Vector.<MovieClip>; // елементи які відкриті
		private var _vectorElementDto:Vector.<ElementDto>; //вектор усіх ДТО
		private var _restElement:Vector.<MovieClip>; // вектор елементів які ще є на сцені
		
		private var _ScoreAnim:Class = Warehouse.getInstance().getAssetClass("ScoreAnim");
		
		private var _scoreAnimTf:TextField;
		private var _movesScoreVal:uint;
		
		
		public function Level1ViewLogic(confDto:ConfigDto)
		{
			super(confDto.nameOfGameField);
			_showElemDelay = confDto.showElemDelay;
			_elemName = confDto.elemName;
		}
		
		private function get level1Content():MovieClip
		{
			return content as MovieClip;
		}
		
		public function readyToDraw(value:Vector.<ElementDto>):void
		{
			var _Elem:Class = Warehouse.getInstance().getAssetClass(_elemName);
			_openElemList = new Vector.<MovieClip>; // вектор, що містить список відкритих елементів
			_allElemList = new Vector.<MovieClip>; // вектор усіх елементів
			_restElement = new Vector.<MovieClip>; // вектор елементів, що ще не відкриті та залишаються на сцені
			
			_vectorElementDto = value;
			for (var i:uint = 0; i<value.length; i++)
			{
				value[i].element = new _Elem();
				_allElemList.push(value[i].element); // додаємо до вестора clipsList MovieClip-и витягнуті з вектора ElementDto
				_restElement.push(value[i].element);
				value[i].element.gotoAndStop(value[i].kadr);
				((level1Content[_shablon+i]) as MovieClip).addChild(value[i].element);
			}
			allElementsDrawed();
		}
		
		private function getDtoByContent(element:MovieClip):ElementDto // метод для отримання ДТО по елементу мувікліпа 
		{
			for (var i:uint=0; i<_vectorElementDto.length; i++) // пробігаємося по всьому вектору ЕлементДто 
			{
				if (element == _vectorElementDto[i].element) //якщо провіряючий мовікліп співпадає з елементом в ДТО
				{
					return  _vectorElementDto[i]; // вернути його ДТО
				}
			}
			return null; // інакше нічого не вертати
		}
			
		protected function onClickElement(event:MouseEvent):void
		{
			var element:MovieClip = (event.currentTarget as MovieClip); 
			var neededDto:ElementDto = getDtoByContent(element); // зміній neededDto (необхіднийДТО) присвоюємо ДТО яка визначається в методі getDtoByContent в який передано (зміну element(елемент по якому був клік))
			dispatchEvent(new GameEvent(GeneralEventsConst.OPENED_ELEMENT, neededDto));
		}
		
		public function restElemFun(delElem:MovieClip):void
		{
			var availableElem:int = _allElemList.indexOf(delElem); //знаходимо даний елемент в векторі усіх елементів... визначаємо його індекс
			if (availableElem != -1) //якщо індекс не рівний -1 тоді
			{
				_restElement.splice(availableElem, 1, null); //видаляємо елемент(який було видалено зі сцени) з вектора MovieClip по індексу, 1 - кількість видалених елементів після елемента з індексом, null - ставиться в масив замість видалених елементів... (без налл не видаляються елементи зі сценни в методі replayLevel)
			}
		}
		public function setScorAnim(scoreValue:int):void
		{
			_movesScoreVal = scoreValue;
		}

		public function resultTurn(notif:Boolean):void //перевірка результатів ходу (вибору елементів)
		{
			if(notif as Boolean)
			{
				dispatchEvent(new Event(GeneralEventsConst.SELECT_IS_TRUE));
				//додаємо анімацію нарахування очків за поточний хід
				var scoreAnim:MovieClip = new _ScoreAnim();
				_scoreAnimTf = scoreAnim.scoreMovesTf;
				_scoreAnimTf.text = _movesScoreVal.toString(10);
				
				for (var i:uint = 0; i < _openElemList.length; i++)
				{
					restElemFun(_openElemList[i]);
					_openElemList[i].parent.addChild(scoreAnim); //додаємо анімацію нарахування очків
					scoreAnim.addEventListener(Event.ENTER_FRAME, onEnterFrameScoreAnim); //по закінченю анімації видаляємо її
					_openElemList[i].parent.removeChild(_openElemList[i]);
					SoundLib.getInstance().playSound("TrueSound", 200);
				}
			}
			else
			{
				for ( i = 0; i < _openElemList.length; i++)
				{
					SoundLib.getInstance().playSound("FalseSound");
					_openElemList[i].back.gotoAndStop(_hide);
				}
				dispatchEvent(new Event(GeneralEventsConst.SELECT_IS_FALSE));
			}
			_openElemList = new Vector.<MovieClip>;
			dispatchEvent(new Event(GeneralEventsConst.END_TURN)); //відправляємо евент про закінчення вибору елементів
		}
		
		protected function onEnterFrameScoreAnim(event:Event):void //якщо поточний кадр мувікліпа scoreAnin рівний загальній кількості кадрів (тобто останній) і парент, який на який покладено мувікліп scoreAnin, тоді видаляємо мувікліп scoreAnin (після його програшу) з парента 
		{
			if (event.currentTarget.currentFrame == event.currentTarget.totalFrames && event.target.parent != null)
			{
				event.target.parent.removeChild(event.target);
				event.target.removeEventListener(Event.ENTER_FRAME, onEnterFrameScoreAnim);
			}
		}
		
		public function permitToAdd(elemIndex:int):void 
		{
			var elem:MovieClip = _allElemList[elemIndex];
			_openElemList.push(elem);
			elem.back.gotoAndStop(_show);
			SoundLib.getInstance().playSound("SelectElemSound", 200);
		}
		
		private function allElementsDrawed():void //відкриваємо усі елементи перед початком гри
		{
			for (var i:uint = 0; i < _allElemList.length; i++)
			{
				_vectorElementDto[i].element.back.gotoAndStop(_show);
			}
			setTimeout(allElementsHided, _showElemDelay); //встановлюється затримка відкритих елементів 
		}
		
		private function allElementsHided():void //закриваємо елементи піся перегляду
		{
			for (var i:uint = 0; i < _allElemList.length; i++)
			{
				_vectorElementDto[i].element.back.gotoAndStop(_hide);
				_vectorElementDto[i].element.addEventListener(MouseEvent.CLICK, onClickElement); //добавляємо лісенери на всі елементи, лише коли вони закриються
			}
			dispatchEvent(new Event(GeneralEventsConst.START_TIMER));
		}
		
		public function replayLevel():void
		{
			for (var i:uint = 0; i<_restElement.length; i++)
			{
				if (_restElement[i] != null) //якщо елемент в векторі елементів які залишилися на сцені не нулл
				{
					((level1Content[_shablon+i]) as MovieClip).removeChild(_restElement[i]); //видаляємо усі елементи з сцени
				}
			}
			removeListener();
			
			for (var j:uint = 0; j<_allElemList.length; j++)
			{
				((level1Content[_shablon+j]) as MovieClip).addChild(_allElemList[j]); //додаємо вектор усіх елементів на сцену
			}
				_openElemList = new Vector.<MovieClip>; //обнуляємо вектор відкритих елементів, щоб після рестарта можна було вибирати елементи спочатку
				allElementsDrawed();
		}
		private function gameOverShowRestElements():void //після програшу відкриваємо елементи які залишилися на сцені
		{
			for (var i:uint = 0; i<_vectorElementDto.length; i++)
			{
				_vectorElementDto[i].element.back.gotoAndStop(_show);
			}
		}
		
		public function removeListener():void //метод для видалення лісенерів з елементів при паузі, рестарті та геймОвер
		{
			for (var i:uint=0; i<_vectorElementDto.length; i++)
			{
				_vectorElementDto[i].element.removeEventListener(MouseEvent.CLICK, onClickElement);
			}
		}
		
		public function addListenerForPause():void
		{
			for (var i:uint=0; i<_vectorElementDto.length; i++)
			{
				_vectorElementDto[i].element.addEventListener(MouseEvent.CLICK, onClickElement);
			}
		}
		
		public function gameOver():void
		{
			removeListener();
			setTimeout(SoundLib.getInstance().playSound, 500, "GameOverSound");
			gameOverShowRestElements();
		}
		
		public function win():void
		{
			setTimeout(SoundLib.getInstance().playSound, 500, "WinSound");
		}
	}
}