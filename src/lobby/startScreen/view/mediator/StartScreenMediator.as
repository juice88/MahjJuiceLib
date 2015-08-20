package lobby.startScreen.view.mediator
{
	
	import core.config.GameEvent;
	import core.config.GeneralEventsConst;
	import core.config.GeneralNotifications;
	import core.view.mediator.UIMediator;
	
	import flash.events.Event;
	
	import lobby.startScreen.view.components.StartViewLogic;
	
	import org.puremvc.as3.interfaces.INotification;
	
	public class StartScreenMediator extends UIMediator
	{
		public static const NAME:String = "StartMediator";
		
		public function StartScreenMediator(totalNumOfGames:int)
		{
			super(NAME, new StartViewLogic(totalNumOfGames));
		}
		
		private function get startScreen():StartViewLogic
		{
			return viewLogic as StartViewLogic;
		}
		
		override public function onRegisterListeners():void
		{
			startScreen.addEventListener(GeneralEventsConst.START_NEW_GAME, onStartGameHand);
			startScreen.addEventListener(GeneralEventsConst.CONTINUE_GAME, onContinueGameHand);
			startScreen.addEventListener(GeneralEventsConst.SHOW_SETTINGS_PANEL, onShowSettingsPanelHand);
			startScreen.addEventListener(GeneralEventsConst.CHOISE_OF_LEVEL, onChoiseOfLevelHand);
			startScreen.addEventListener(GeneralEventsConst.TUTORIAL_SHOW, onShowTutorialPopup);
			startScreen.addEventListener(GeneralEventsConst.SCORE_BOARD_SHOW, onScoreBoardShowHand);
			startScreen.addEventListener(GeneralEventsConst.GAME_TYPE_SELECTED, onGameSelectedHand);
		}
		
		override public function onRemoveListeners():void
		{
			startScreen.removeEventListener(GeneralEventsConst.START_NEW_GAME, onStartGameHand);
			startScreen.removeEventListener(GeneralEventsConst.CONTINUE_GAME, onContinueGameHand);
			startScreen.removeEventListener(GeneralEventsConst.SHOW_SETTINGS_PANEL, onShowSettingsPanelHand);
			startScreen.removeEventListener(GeneralEventsConst.CHOISE_OF_LEVEL, onChoiseOfLevelHand);
			startScreen.removeEventListener(GeneralEventsConst.TUTORIAL_SHOW, onShowTutorialPopup);
			startScreen.removeEventListener(GeneralEventsConst.SCORE_BOARD_SHOW, onScoreBoardShowHand);
			startScreen.removeEventListener(GeneralEventsConst.GAME_TYPE_SELECTED, onGameSelectedHand);
		}
		
		protected function onGameSelectedHand(event:GameEvent):void
		{
			sendNotification(GeneralNotifications.GAME_TYPE_SELECTED, event.params as int);
		}
		
		protected function onStartGameHand(event:Event):void
		{
			sendNotification(GeneralNotifications.POPUP_SHOW_CONFIRM_TO_NEW_GAME);
		}
		
		protected function onContinueGameHand(event:Event):void
		{
			sendNotification(GeneralNotifications.CONTINUE_GAME);
		}
		
		protected function onShowSettingsPanelHand(event:Event):void
		{
			sendNotification(GeneralNotifications.SETTINGS_PANEL_OPEN);
		}
		
		protected function onChoiseOfLevelHand(event:Event):void
		{
			sendNotification(GeneralNotifications.SHOW_LEVELS_CATEGORY_POPUP);			
		}
		
		protected function onShowTutorialPopup(event:Event):void
		{
			sendNotification(GeneralNotifications.TUTORIAL_SHOW);
		}
		
		protected function onScoreBoardShowHand(event:Event):void
		{
			sendNotification(GeneralNotifications.SCORE_BOARD_SHOW);
		}
		
		override public function listNotificationInterests():Array
		{
			return [GeneralNotifications.CONTINUE_BTN_IS_VISIBLE];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch (notification.getName())
			{
				case GeneralNotifications.CONTINUE_BTN_IS_VISIBLE:
					startScreen.continueGameBtnIsVis();
					break;
			}
		}
	}
}