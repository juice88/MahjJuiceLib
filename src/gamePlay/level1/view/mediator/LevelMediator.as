package gamePlay.level1.view.mediator
{
	import core.config.GameEvent;
	import core.config.GeneralEventsConst;
	import core.config.GeneralNotifications;
	import core.config.Settings;
	import core.levelsConfig.model.dto.ConfigDto;
	import core.levelsConfig.model.dto.LevelConfigDto;
	import core.utils.SoundLib;
	import core.view.mediator.UIMediator;
	
	import flash.events.Event;
	import flash.utils.setTimeout;
	
	import gamePlay.level1.model.dto.ElementDto;
	import gamePlay.level1.view.components.Level1ViewLogic;
	
	import org.puremvc.as3.interfaces.INotification;
	
	public class LevelMediator extends UIMediator
	{
		public static const NAME:String="LevelMediator";
		
		public function LevelMediator(confDto:LevelConfigDto)
		{
			super(NAME, new Level1ViewLogic(confDto));
		}
		
		private function get levelVL():Level1ViewLogic
		{
			return viewLogic as Level1ViewLogic;
		}

		override public function onRegisterListeners():void
		{
			levelVL.addEventListener(GeneralEventsConst.OPENED_ELEMENT, onOpenedElementHand);
			levelVL.addEventListener(GeneralEventsConst.END_TURN, onEndTurnHand);
			levelVL.addEventListener(GeneralEventsConst.SELECT_IS_TRUE, onSelectIsTrueHand);
			levelVL.addEventListener(GeneralEventsConst.SELECT_IS_FALSE, onSelectIsFalseHand);
			levelVL.addEventListener(GeneralEventsConst.START_TIMER, onStartTimerHand);
			
		}
		
		override public function onRemoveListeners():void
		{
			levelVL.removeEventListener(GeneralEventsConst.OPENED_ELEMENT, onOpenedElementHand);
			levelVL.removeEventListener(GeneralEventsConst.END_TURN, onEndTurnHand);
			levelVL.removeEventListener(GeneralEventsConst.SELECT_IS_TRUE, onSelectIsTrueHand);
			levelVL.removeEventListener(GeneralEventsConst.SELECT_IS_FALSE, onSelectIsFalseHand);
			levelVL.removeEventListener(GeneralEventsConst.START_TIMER, onStartTimerHand);
		}
		
		override public function listNotificationInterests():Array{
			return [GeneralNotifications.READY_TO_DRAW, 
					GeneralNotifications.RESULTS_TURN, 
					GeneralNotifications.PERMIT_TO_ADD,
					GeneralNotifications.REPLAY_LEVEL,
					GeneralNotifications.PAUSE,
					GeneralNotifications.PAUSE_CONTINUE_GAME,
					GeneralNotifications.POPUP_SHOW_GAME_OVER,
					GeneralNotifications.POPUP_SHOW_WIN,
					GeneralNotifications.SCORE_MOVES_ANIMATION];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch (notification.getName())
			{
				case GeneralNotifications.READY_TO_DRAW:
					levelVL.readyToDraw(notification.getBody() as Vector.<ElementDto>);
					break;
				case GeneralNotifications.RESULTS_TURN:
					levelVL.resultTurn(notification.getBody() as Boolean);
					//	setTimeout(levelVL.resultTurn, Settings.TIME_DELAY, (notification.getBody() as Boolean)); // встановлюється затримка між показом елементів і їх закриванням перед видаленням
					break;
				case GeneralNotifications.PERMIT_TO_ADD:
					levelVL.permitToAdd(notification.getBody() as int);
					break;
				case GeneralNotifications.REPLAY_LEVEL:
					levelVL.replayLevel();
					break;
				case GeneralNotifications.PAUSE:
					levelVL.removeListener();
					break;
				case GeneralNotifications.PAUSE_CONTINUE_GAME:
					levelVL.addListenerAfterPause();
					break;
				case GeneralNotifications.POPUP_SHOW_GAME_OVER:
					levelVL.gameOver();
					break;
				case GeneralNotifications.POPUP_SHOW_WIN:
					levelVL.win();
					break;
				case GeneralNotifications.SCORE_MOVES_ANIMATION:
					levelVL.setScorAnim(notification.getBody() as int);
					break;
			}
		}
		
		protected function onOpenedElementHand(event:GameEvent):void 
		{
			sendNotification(GeneralNotifications.ON_OPEN_ELEMENT, event.params); // відправляємо Нотіф про те що елемент ще не відкритий, а ми лише намірені відкрити цей елемент
		}
		
		protected function onEndTurnHand(event:Event):void
		{
			sendNotification(GeneralNotifications.END_TURN);
		}
		
		protected function onSelectIsFalseHand(event:Event):void
		{
			sendNotification(GeneralNotifications.SELECT_IS_FALSE);
		}
		
		protected function onSelectIsTrueHand(event:Event):void
		{
			sendNotification(GeneralNotifications.SELECT_IS_TRUE);
		}	
		protected function onStartTimerHand(event:Event):void
		{
			sendNotification(GeneralNotifications.START_TIMER);
		}
	}
}