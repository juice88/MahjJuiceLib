package core.controller.commands
{
	import core.config.GeneralNotifications;
	import core.config.Settings;
	import core.counters.controller.commands.NumberOfMovesSendCommand;
	import core.counters.controller.commands.SetPlayerScoreCommand;
	import core.levelsConfig.controller.commands.SetLevelConfigCommand;
	import core.levelsConfig.controller.commands.SetNumLevelCommand;
	import core.queue.controller.commands.DialogCloseCommand;
	import core.queue.controller.commands.DialogLoadToQueueCommand;
	import core.queue.controller.commands.DialogOpenCommand;
	import core.sharedObject.controller.commands.SetConfToContinGameCommand;
	import core.view.mediator.RootMediator;
	
	import flash.display.Sprite;
	
	import gamePlay.bonus.controller.commands.BonusLevelLoadCommand;
	import gamePlay.bonus.controller.commands.BonusPopupShowCommand;
	import gamePlay.bonus.controller.commands.BonusResultOfChoiseCommand;
	import gamePlay.level1.controller.commands.EndTurnCommand;
	import gamePlay.level1.controller.commands.OpenedElementCommand;
	import gamePlay.level1.controller.commands.SelectIsFalseCommand;
	import gamePlay.level1.controller.commands.SelectIsTrueCommand;
	
	import lobby.enterName.controller.commands.SetPlayerNameCommand;
	import lobby.gameOver.controller.commands.GameOverClosePopupCommand;
	import lobby.gameOver.controller.commands.GameOverCommand;
	import lobby.highScore.controller.commands.HighScoreUpdateCommand;
	import lobby.highScore.controller.commands.SetNameLevelAndScoreInSOCommand;
	import lobby.levelsMap.controller.commands.LevelsMapChoiseCommand;
	import lobby.levelsMap.controller.commands.LevelsMapCloseCommand;
	import lobby.levelsMap.controller.commands.LevelsMapShowCommand;
	import lobby.pause.controller.commands.PauseCommand;
	import lobby.pause.controller.commands.PauseContinueGameCommand;
	import lobby.pause.controller.commands.StartTimerCommand;
	import lobby.settings.controller.commands.SettingsPanelOpenCommand;
	import lobby.startScreen.controller.commands.ChoiseOfLevelCommand;
	import lobby.startScreen.controller.commands.ContinueGameCommand;
	import lobby.startScreen.controller.commands.StartGameCommand;
	import lobby.topMenu.controller.commands.BackToMenuCommand;
	import lobby.topMenu.controller.commands.RestartCommand;
	import lobby.win.controller.commands.WinCommand;
	
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
			sendNotification(GeneralNotifications.LOAD_URL_REQUEST);
		}
		
		private function registerCommand():void
		{
			facade.registerCommand(GeneralNotifications.BACK_TO_MENU, BackToMenuCommand);
			facade.registerCommand(GeneralNotifications.BONUS_LEVEL_LOAD, BonusLevelLoadCommand);
			facade.registerCommand(GeneralNotifications.BONUS_RESULT_OF_CHOISE, BonusResultOfChoiseCommand);
			facade.registerCommand(GeneralNotifications.BONUS_POPUP_SHOW, BonusPopupShowCommand);
			facade.registerCommand(GeneralNotifications.CHOISE_OF_LEVEL, ChoiseOfLevelCommand);
			facade.registerCommand(GeneralNotifications.CONTINUE_GAME, ContinueGameCommand);
			facade.registerCommand(GeneralNotifications.DIALOG_CLOSE, DialogCloseCommand);
			facade.registerCommand(GeneralNotifications.DIALOG_LOAD_TO_QUEUE, DialogLoadToQueueCommand);
			facade.registerCommand(GeneralNotifications.DIALOG_OPEN, DialogOpenCommand);
			facade.registerCommand(GeneralNotifications.END_TURN, EndTurnCommand);
			facade.registerCommand(GeneralNotifications.GAME_OVER, GameOverCommand);
			facade.registerCommand(GeneralNotifications.GAME_OVER_CLOSE_POPUP, GameOverClosePopupCommand);
			facade.registerCommand(GeneralNotifications.HIGH_SCORE_UPDATE, HighScoreUpdateCommand);
			facade.registerCommand(GeneralNotifications.LEVELS_MAP_CHOISE, LevelsMapChoiseCommand);
			facade.registerCommand(GeneralNotifications.LEVELS_MAP_CLOSE, LevelsMapCloseCommand);
			facade.registerCommand(GeneralNotifications.LEVELS_MAP_SHOW, LevelsMapShowCommand);
			facade.registerCommand(GeneralNotifications.LOAD_URL_REQUEST, LoadUrlRequestCommand);
			facade.registerCommand(GeneralNotifications.NEXT_LEVEL, NextLevelCommand);
			facade.registerCommand(GeneralNotifications.NUMBER_OF_MOVES, NumberOfMovesSendCommand);
			facade.registerCommand(GeneralNotifications.ON_OPEN_ELEMENT, OpenedElementCommand);
			facade.registerCommand(GeneralNotifications.PAUSE, PauseCommand);
			facade.registerCommand(GeneralNotifications.PAUSE_CONTINUE_GAME, PauseContinueGameCommand);
			facade.registerCommand(GeneralNotifications.REMOVE_DIALOG, RemoveDialogCommand);
			facade.registerCommand(GeneralNotifications.RESTART_GAME, RestartCommand);
			facade.registerCommand(GeneralNotifications.SELECT_IS_TRUE, SelectIsTrueCommand);
			facade.registerCommand(GeneralNotifications.SELECT_IS_FALSE, SelectIsFalseCommand);
			facade.registerCommand(GeneralNotifications.SET_CONF_TO_CONTINUE_GAME, SetConfToContinGameCommand);
			facade.registerCommand(GeneralNotifications.SET_LEVEL_CONFIG, SetLevelConfigCommand);
			facade.registerCommand(GeneralNotifications.SET_NAME_LEVEL_AND_SCORE_IN_SO, SetNameLevelAndScoreInSOCommand);
			facade.registerCommand(GeneralNotifications.SET_NUM_LEVEL, SetNumLevelCommand);
			facade.registerCommand(GeneralNotifications.SET_PLAYER_NAME, SetPlayerNameCommand);
			facade.registerCommand(GeneralNotifications.SET_PLAYER_SCORE, SetPlayerScoreCommand);
			facade.registerCommand(GeneralNotifications.SETTINGS_PANEL_OPEN, SettingsPanelOpenCommand);
			facade.registerCommand(GeneralNotifications.START_NEW_GAME, StartGameCommand);
			facade.registerCommand(GeneralNotifications.START_TIMER, StartTimerCommand);
			facade.registerCommand(GeneralNotifications.WIN, WinCommand);
		}
	}
}