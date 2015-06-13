package core.controller.commands
{
	import core.config.GeneralNotifications;
	import core.counters.model.proxy.CountersProxy;
	import core.levelsConfig.model.proxy.LevelsGameConfigProxy;
	
	import gamePlay.level1.model.proxy.LevelProxy;
	import gamePlay.level1.view.mediator.LevelMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class NextLevelCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			facade.removeMediator(LevelMediator.NAME);
			facade.removeProxy(LevelProxy.NAME);
			(facade.retrieveProxy(LevelsGameConfigProxy.NAME) as LevelsGameConfigProxy).addLevelNum();
			(facade.retrieveProxy(LevelsGameConfigProxy.NAME) as LevelsGameConfigProxy).setLevelConfig();
			(facade.retrieveProxy(CountersProxy.NAME) as CountersProxy).nextLevel();
		}
	}
}