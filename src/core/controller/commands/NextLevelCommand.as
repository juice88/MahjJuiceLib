package core.controller.commands
{
	import core.config.GeneralNotifications;
	import core.counters.model.proxy.CountersProxy;
	import core.levelsConfig.model.proxy.LevelsGameConfigProxy;
	
	import gamePlay.level1.model.proxy.StartLevelProxy;
	import gamePlay.level1.view.mediator.LevelMediator;
	
	import lobby.win.view.mediator.WinPopupMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class NextLevelCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			facade.removeMediator(WinPopupMediator.NAME);
			facade.removeMediator(LevelMediator.NAME);
			facade.removeProxy(StartLevelProxy.NAME);
//			facade.registerMediator(new LevelMediator);
//			facade.registerProxy(new StartLevelProxy);
			(facade.retrieveProxy(LevelsGameConfigProxy.NAME) as LevelsGameConfigProxy).addLevelNum();
			(facade.retrieveProxy(LevelsGameConfigProxy.NAME) as LevelsGameConfigProxy).setLevelConfig();
			(facade.retrieveProxy(CountersProxy.NAME) as CountersProxy).nextLevel();
		}
	}
}