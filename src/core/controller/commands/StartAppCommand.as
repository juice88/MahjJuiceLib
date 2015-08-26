package core.controller.commands
{
	import core.config.GeneralNotifications;
	import core.config.Settings;
	import core.counters.controller.commands.NumberOfMovesSendCommand;
	import core.counters.controller.commands.PauseContinueGameCommand;
	import core.counters.controller.commands.StartTimerCommand;
	import core.levelsConfig.controller.commands.SetLevelConfigCommand;
	import core.levelsConfig.controller.commands.SetNumberOfLevelInHighScoreProxyCommand;
	import core.popups.controlles.commands.PopupShowBonusCommand;
	import core.popups.controlles.commands.PopupShowCheckUserNameExistCommand;
	import core.popups.controlles.commands.PopupShowConfirmToExitCommand;
	import core.popups.controlles.commands.PopupShowConfirmToNewGameCommand;
	import core.popups.controlles.commands.PopupShowConfirmToRestartCommand;
	import core.popups.controlles.commands.PopupShowEnterNameCommand;
	import core.popups.controlles.commands.PopupShowGameOverCommand;
	import core.popups.controlles.commands.PopupShowPauseCommand;
	import core.popups.controlles.commands.PopupShowWinCommand;
	import core.popups.controlles.commands.RemovePopupCommand;
	import core.queue.controller.commands.DialogCloseCommand;
	import core.queue.controller.commands.DialogLoadToQueueCommand;
	import core.queue.controller.commands.DialogOpenCommand;
	import core.sharedObject.controller.commands.ContinueGameCommand;
	import core.sharedObject.controller.commands.HighScoreUpdateCommand;
	import core.sharedObject.controller.commands.SetConfToContinGameCommand;
	import core.sharedObject.controller.commands.SetNameLevelAndScoreInSOCommand;
	import core.view.mediator.RootMediator;
	
	import flash.display.Sprite;
	
	import gamePlay.bonus.controller.commands.BonusLevelLoadCommand;
	import gamePlay.bonus.controller.commands.BonusResultOfChoiseCommand;
	import gamePlay.level1.controller.commands.EndTurnCommand;
	import gamePlay.level1.controller.commands.OpenedElementCommand;
	import gamePlay.level1.controller.commands.SelectIsFalseCommand;
	import gamePlay.level1.controller.commands.SelectIsTrueCommand;
	
	import lobby.entertainmentScreen.controller.commands.EntertainmentScreenShowCommand;
	import lobby.highScore.controller.commands.ScoreBoardShowCommand;
	import lobby.highScore.controller.commands.SetPlayerNameCommand;
	import lobby.highScore.controller.commands.SetPlayerScoreCommand;
	import lobby.levelsMap.controller.commands.LevelsMapCloseCommand;
	import lobby.levelsMap.controller.commands.ShowLevelsCategoryPopupCommand;
	import lobby.preloader.controller.commands.PreloaderShowHideCommand;
	import lobby.settings.controller.commands.SettingsPanelOpenCommand;
	import lobby.tutorial.controller.commands.TutorialShowCommand;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class StartAppCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void{
			var rootSprite:Sprite = notification.getBody() as Sprite;
			Settings.BACKGROUND_RECT_HEIGHT = rootSprite.stage.stageHeight;
			Settings.BACKGROUND_RECT_WIDTH = rootSprite.stage.stageWidth;
			registerCommand();
			facade.registerMediator(new RootMediator(rootSprite));
			sendNotification(GeneralNotifications.PRELOADER_SHOW_HIDE, true);
			var mainConfigPath:String = "res/xml/MainConfig.xml";
			var assetsPath:String = "res/";
			sendNotification(GeneralNotifications.LOAD_URL_REQUEST, assetsPath, mainConfigPath);
		}
		
		private function registerCommand():void
		{
			facade.registerCommand(GeneralNotifications.BACK_TO_MENU, BackToMenuCommand);
			facade.registerCommand(GeneralNotifications.BONUS_LEVEL_LOAD, BonusLevelLoadCommand);
			facade.registerCommand(GeneralNotifications.BONUS_RESULT_OF_CHOISE, BonusResultOfChoiseCommand);
			facade.registerCommand(GeneralNotifications.SHOW_LEVELS_CATEGORY_POPUP, ShowLevelsCategoryPopupCommand);
			facade.registerCommand(GeneralNotifications.CONTINUE_GAME, ContinueGameCommand);
			facade.registerCommand(GeneralNotifications.DIALOG_CLOSE, DialogCloseCommand);
			facade.registerCommand(GeneralNotifications.DIALOG_LOAD_TO_QUEUE, DialogLoadToQueueCommand);
			facade.registerCommand(GeneralNotifications.DIALOG_OPEN, DialogOpenCommand);
			facade.registerCommand(GeneralNotifications.END_TURN, EndTurnCommand);
			facade.registerCommand(GeneralNotifications.ENTERTAINMENT_SCREEN_SHOW, EntertainmentScreenShowCommand);
			facade.registerCommand(GeneralNotifications.GAME_TYPE_SELECTED, GameTypeSelectedCommand);
			facade.registerCommand(GeneralNotifications.HIGH_SCORE_UPDATE, HighScoreUpdateCommand);
			facade.registerCommand(GeneralNotifications.LEVELS_MAP_CHOISE, LevelsMapChoiseCommand);
			facade.registerCommand(GeneralNotifications.LEVELS_MAP_CLOSE, LevelsMapCloseCommand);
			facade.registerCommand(GeneralNotifications.LEVELS_MAP_SHOW, LevelsMapShowCommand);
			facade.registerCommand(GeneralNotifications.LOAD_URL_REQUEST, LoadUrlRequestCommand);
			facade.registerCommand(GeneralNotifications.LOAD_MAIN_CONTENT, LoadMainContentCommand);
			facade.registerCommand(GeneralNotifications.NEXT_LEVEL, NextLevelCommand);
			facade.registerCommand(GeneralNotifications.NUMBER_OF_MOVES, NumberOfMovesSendCommand);
			facade.registerCommand(GeneralNotifications.ON_OPEN_ELEMENT, OpenedElementCommand);
			facade.registerCommand(GeneralNotifications.PAUSE_CONTINUE_GAME, PauseContinueGameCommand);
			facade.registerCommand(GeneralNotifications.PRELOADER_SHOW_HIDE, PreloaderShowHideCommand);
			facade.registerCommand(GeneralNotifications.REMOVE_POPUP, RemovePopupCommand);
			facade.registerCommand(GeneralNotifications.RESTART_GAME, RestartCommand);
			facade.registerCommand(GeneralNotifications.TUTORIAL_SHOW, TutorialShowCommand);
			facade.registerCommand(GeneralNotifications.SCORE_BOARD_SHOW, ScoreBoardShowCommand);
			facade.registerCommand(GeneralNotifications.SELECT_IS_TRUE, SelectIsTrueCommand);
			facade.registerCommand(GeneralNotifications.SELECT_IS_FALSE, SelectIsFalseCommand);
			facade.registerCommand(GeneralNotifications.SET_CONF_TO_CONTINUE_GAME, SetConfToContinGameCommand);
			facade.registerCommand(GeneralNotifications.SET_LEVEL_CONFIG, SetLevelConfigCommand);
			facade.registerCommand(GeneralNotifications.SET_NAME_LEVEL_AND_SCORE_IN_SO, SetNameLevelAndScoreInSOCommand);
			facade.registerCommand(GeneralNotifications.SET_NUMBER_OF_LEVEL_IN_HIGH_SCORE_PROXY, SetNumberOfLevelInHighScoreProxyCommand);
			facade.registerCommand(GeneralNotifications.SET_PLAYER_NAME, SetPlayerNameCommand);
			facade.registerCommand(GeneralNotifications.SET_PLAYER_SCORE, SetPlayerScoreCommand);
			facade.registerCommand(GeneralNotifications.SETTINGS_PANEL_OPEN, SettingsPanelOpenCommand);
			facade.registerCommand(GeneralNotifications.START_NEW_GAME, StartNewGameCommand);
			facade.registerCommand(GeneralNotifications.START_TIMER, StartTimerCommand);
			
			facade.registerCommand(GeneralNotifications.POPUP_SHOW_ENTER_NAME, PopupShowEnterNameCommand);
			facade.registerCommand(GeneralNotifications.POPUP_SHOW_CHECK_USER_NAME_EXIST, PopupShowCheckUserNameExistCommand);
			facade.registerCommand(GeneralNotifications.POPUP_SHOW_PAUSE, PopupShowPauseCommand);
			facade.registerCommand(GeneralNotifications.POPUP_SHOW_CONFIRM_TO_RESTART, PopupShowConfirmToRestartCommand);
			facade.registerCommand(GeneralNotifications.POPUP_SHOW_CONFIRM_TO_EXIT, PopupShowConfirmToExitCommand);
			facade.registerCommand(GeneralNotifications.POPUP_SHOW_CONFIRM_TO_NEW_GAME, PopupShowConfirmToNewGameCommand);
			facade.registerCommand(GeneralNotifications.POPUP_SHOW_BONUS, PopupShowBonusCommand);
			facade.registerCommand(GeneralNotifications.POPUP_SHOW_WIN, PopupShowWinCommand);
			facade.registerCommand(GeneralNotifications.POPUP_SHOW_GAME_OVER, PopupShowGameOverCommand);
			
		}
	}
}