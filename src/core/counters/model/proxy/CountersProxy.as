package core.counters.model.proxy
{
	import core.config.GeneralNotifications;
	import core.config.Settings;
	import core.counters.model.dto.CountersDto;
	import core.levelsConfig.model.dto.ConfigDto;
	import core.levelsConfig.model.dto.LevelConfigDto;
	import core.sharedObject.model.dto.ContinGameConfDto;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class CountersProxy extends Proxy
	{
		public static const NAME:String = "MenuProxy";
		
		public function CountersProxy()
		{
			super(NAME, new CountersDto());
			
		}
		override public function onRegister():void
		{
			counters.timer = new Timer(1000, 1);
		}
		
		public function get counters():CountersDto
		{
			return getData() as CountersDto;
		}
		
		public function setLevelConfig(confDto:LevelConfigDto):void
		{
			counters.setLevelConf(confDto);
			timerGameSet();
		}
		
		public function allMovesCounter(value:int):void
		{
			counters.numberOfMoves = value;
		}
		
		public function selectIsTrue():void
		{
			counters.allTrueSelect++;
			counters.allMoves++;
			sendNotification(GeneralNotifications.MOVES_COUTNER_UPDATED, counters.allMoves);
			scoreCounter();
		}
		
		public function selectIsFalse():void
		{
			counters.allFalseSelect++;
			if (counters.lifesIsFrozen == false)
			{
				counters.lifes--;
			}
			else
			{
				counters.lifes = 11; // на 12 кадрі в флашкі нарисовано, що життя заморожені
			}
			counters.allMoves++;
			sendNotification(GeneralNotifications.MOVES_COUTNER_UPDATED, counters.allMoves);
			lifesCounter();
			counters.trueSelect = 0; // при неправильному виборі обнуляємо кількість правильних виборів (тобто все спочатку... на 3-й правильний вибір і всі наступні знову будуть додаватися по 30 очок за правильний вибір)  
		}
		
		private function lifesCounter():void
		{
			if (counters.lifesIsFrozen == true)
			{
				counters.lifes = 11;
			}
			if (counters.lifes < 1)
			{
				timerStop();
				sendNotification(GeneralNotifications.POPUP_SHOW_GAME_OVER);
			}
			sendNotification(GeneralNotifications.LIFES_COUNTER_UPDATED, counters.lifes);
		}
		private function scoreCounter():void
		{
			counters.trueSelect++;
			if (counters.trueSelect < counters.numSelForScoreMoreSel) //якщо кількість правильних ходів менша від 3 тоді добавляємо по 10 очок
			{
				counters.totalScore += counters.scoreOneSel; //Settings.SCORE_ONE_TRUE_SELECT;
				counters.scoreOfSomeLevel += counters.scoreOneSel; //Settings.SCORE_ONE_TRUE_SELECT;
				sendNotification(GeneralNotifications.SCORE_MOVES_ANIMATION, counters.scoreOneSel);
				sendNotification(GeneralNotifications.SCORE_COUTNER_UPDATED, counters.totalScore);
			} else {//інакше добавляємо по 30 очок
				counters.totalScore += counters.scoreMoreSel; //Settings.SCORE_THREE_TRUE_SELECT;
				counters.scoreOfSomeLevel += counters.scoreMoreSel; //Settings.SCORE_THREE_TRUE_SELECT;
				sendNotification(GeneralNotifications.SCORE_MOVES_ANIMATION, counters.scoreMoreSel);
				sendNotification(GeneralNotifications.SCORE_COUTNER_UPDATED, counters.totalScore);
			}
			levelWon();
		}
		
		public function restartLevel():void
		{
			timerStop(); //стопаємо таймер, щоб при рестарті він вмикався не одразу, а лише коли закриються всі елементи
			counters.second = counters.restartSetSecond;
			counters.minute = counters.restartSetMinute;
			timerGameSet();
			counters.trueSelect = 0;
			counters.allTrueSelect = 0;
			counters.allFalseSelect = 0;
			counters.totalScore -= counters.scoreOfSomeLevel;
			counters.scoreOfSomeLevel = 0;
			counters.lifes = 10;
			counters.allMoves = 0;
			sendNotification(GeneralNotifications.SCORE_COUTNER_UPDATED, counters.totalScore);
			sendNotification(GeneralNotifications.LIFES_COUNTER_UPDATED, counters.lifes);
		}
		
		public function openPausePopup():int
		{
			timerStop();
			return counters.totalScore;
		}
		
		public function timerStart():void // перевірка чи таймер не має бути зупинений
		{
			if (counters.timerIsStopped == false)
			{
				counters.timer.start();
			}
		}
		
		public function timerStop():void
		{
			counters.timer.stop();
		}
		
		public function levelWon():void
		{
			if (counters.allTrueSelect == counters.numberOfMoves && counters.allFalseSelect == 0)
			{
				timerStop();
				counters.timerIsStopped = false;
				counters.lifesIsFrozen = false;
				sendNotification(GeneralNotifications.POPUP_SHOW_BONUS);
			}
			else if (counters.allTrueSelect == counters.numberOfMoves)
			{
				timerStop();
				counters.timerIsStopped = false;
				counters.lifesIsFrozen = false;
				sendNotification(GeneralNotifications.POPUP_SHOW_WIN);
				sendNotification(GeneralNotifications.SET_PLAYER_SCORE, counters.totalScore);
			}
		}
		
		public function sendValueScoreTrueFalseMoves():Array
		{
			counters.scoreTrueFalseValue = new Array;
			counters.scoreTrueFalseValue.push(counters.scoreOfSomeLevel, counters.allTrueSelect, counters.allFalseSelect);
			return counters.scoreTrueFalseValue;
		}
		
		public function timerGameSet():void
		{
			counters.minuteSecond = new Array;
			counters.minuteSecond.push(counters.minute, counters.second, counters.timerIsStopped);
			sendNotification(GeneralNotifications.VALUES_MINUTE_SECOND, counters.minuteSecond);
			counters.minuteSecond.length = 0;
		}
		
		public function timerGame():void
		{
			counters.timer.addEventListener(TimerEvent.TIMER, onTick);
			counters.timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
			timerStart();
		}
		
		protected function onTick(event:TimerEvent):void
		{
			counters.second--;
			if (counters.second < 0)
			{
				if (counters.minute != 0)
				{
					counters.minute--;
				}
				counters.second = 59;
			}
			counters.minuteSecond.push(counters.minute, counters.second);
			sendNotification(GeneralNotifications.VALUES_MINUTE_SECOND, counters.minuteSecond, counters.timerIsStopped as String);
			counters.minuteSecond.length = 0;
			trace("таймер", counters.minute, ":", counters.second);
			if (counters.minute == 0 && counters.second == 0)
			{
				timerStop();
				sendNotification(GeneralNotifications.POPUP_SHOW_GAME_OVER);
			}
		}
		
		protected function onTimerComplete(event:TimerEvent):void
		{
			if (counters.minute >= 0)
			{
				counters.timer.start();
				if (counters.minute == 0 && counters.second == 0)
				{
					timerStop();
				}
			}
		}
		
		public function resultOfChoiseBonus(choiseFrame:int):void
		{
			if (choiseFrame == 1)
			{
				counters.totalScore += counters.scoreBonus;
			}
			else if (choiseFrame == 2)
			{
				counters.lifesIsFrozen = true;
			}
			else if (choiseFrame == 3)
			{
				counters.timerIsStopped = true;
			}
			sendValueScoreTrueFalseMoves();
			sendNotification(GeneralNotifications.SET_PLAYER_SCORE, counters.totalScore);
		}
		
		public function getScoreBonus():int
		{
			return counters.scoreBonus;
		}
		
		public function nextLevel():void
		{
			timerStop();
			timerGameSet();
			counters.scoreOfSomeLevel = 0;
			counters.trueSelect = 0;
			counters.lifes = 10;
			counters.allMoves = 0;
			counters.allTrueSelect = 0;
			counters.allFalseSelect = 0;
			sendNotification(GeneralNotifications.MOVES_COUTNER_UPDATED, counters.allMoves);
			sendNotification(GeneralNotifications.SCORE_COUTNER_UPDATED, counters.totalScore);
			sendNotification(GeneralNotifications.LIFES_COUNTER_UPDATED, counters.lifes);
			lifesCounter();
		}
		
		public function backToMenu():void
		{
			timerStop();
			counters.scoreOfSomeLevel = 0;
			counters.totalScore = 0;
			counters.lifes = 10;
			counters.trueSelect = 0;
			counters.allMoves = 0;
			counters.allTrueSelect = 0;
			counters.allFalseSelect = 0;
			counters.lifesIsFrozen = false;
			counters.timerIsStopped = false;
		}
		
		public function continueGame(contGame:ContinGameConfDto):void
		{
			counters.totalScore = contGame.userScore;
			nextLevel();
		}
	}
}