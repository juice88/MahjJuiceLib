package lobby.levelsMap.controller.commands
{
	import core.counters.model.proxy.CountersProxy;
	import core.levelsConfig.model.proxy.LevelsGameConfigProxy;
	import core.sharedObject.model.dto.ContinGameConfDto;
	import core.sharedObject.model.proxy.SharedObjProxy;
	
	import lobby.botMenu.view.mediator.BotPanelMediator;
	import lobby.highScore.view.mediator.HighScorePanelMediator;
	import lobby.levelsMap.view.mediator.LevelsMapMediator;
	import lobby.startScreen.view.mediator.StartScreenMediator;
	import lobby.topMenu.view.mediator.TopPanelMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class LevelsMapChoiseCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			facade.removeMediator(LevelsMapMediator.NAME);
			facade.removeMediator(HighScorePanelMediator.NAME);
			facade.removeMediator(StartScreenMediator.NAME);
			facade.registerMediator(new TopPanelMediator());
			facade.registerMediator(new BotPanelMediator());
			var contGameDto:ContinGameConfDto = (facade.retrieveProxy(SharedObjProxy.NAME) as SharedObjProxy).getScoreForChoiseLvl();
			(facade.retrieveProxy(CountersProxy.NAME) as CountersProxy).continueGame(contGameDto);
			(facade.retrieveProxy(LevelsGameConfigProxy.NAME) as LevelsGameConfigProxy).setLevelNum(null, notification.getBody() as String);
			(facade.retrieveProxy(LevelsGameConfigProxy.NAME) as LevelsGameConfigProxy).setLevelConfig();
		}
	}
}