package core.sharedObject.controller.commands
{
	import core.counters.model.proxy.CountersProxy;
	import core.levelsConfig.model.proxy.LevelsGameConfigProxy;
	import core.sharedObject.model.dto.ContinGameConfDto;
	
	import lobby.botMenu.view.mediator.BotPanelMediator;
	import lobby.highScore.view.mediator.HighScorePanelMediator;
	import lobby.startScreen.view.mediator.StartScreenMediator;
	import lobby.topMenu.view.mediator.TopPanelMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class SetConfToContinGameCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			facade.removeMediator(HighScorePanelMediator.NAME);
			facade.removeMediator(StartScreenMediator.NAME);
			facade.registerMediator(new TopPanelMediator());
			facade.registerMediator(new BotPanelMediator());
			(facade.retrieveProxy(CountersProxy.NAME) as CountersProxy).continueGame(notification.getBody() as ContinGameConfDto);
			(facade.retrieveProxy(LevelsGameConfigProxy.NAME) as LevelsGameConfigProxy).setLevelNum(((notification.getBody() as ContinGameConfDto).numLvl+1) as int);
			(facade.retrieveProxy(LevelsGameConfigProxy.NAME) as LevelsGameConfigProxy).continueGame();
		}
	}
}