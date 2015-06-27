package core.controller.commands
{
	import core.counters.model.proxy.CountersProxy;
	import core.levelsConfig.model.proxy.LevelsGameConfigProxy;
	
	import gamePlay.level1.model.proxy.LevelProxy;
	import gamePlay.level1.view.mediator.LevelMediator;
	
	import lobby.botMenu.view.mediator.BotPanelMediator;
	import lobby.highScore.view.mediator.HighScorePanelMediator;
	import lobby.startScreen.view.mediator.StartScreenMediator;
	import lobby.topMenu.view.mediator.TopPanelMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class StartNewGameCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void{
			facade.removeMediator(HighScorePanelMediator.NAME);
			facade.removeMediator(StartScreenMediator.NAME);
			facade.registerMediator(new TopPanelMediator());
			facade.registerMediator(new BotPanelMediator());
			(facade.retrieveProxy(LevelsGameConfigProxy.NAME) as LevelsGameConfigProxy).newGame();
			(facade.retrieveProxy(LevelsGameConfigProxy.NAME) as LevelsGameConfigProxy).setLevelConfig();
		}
	}
}