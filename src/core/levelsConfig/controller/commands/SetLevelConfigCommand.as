package core.levelsConfig.controller.commands
{
	import core.counters.model.proxy.CountersProxy;
	import core.levelsConfig.model.dto.LevelConfigDto;
	
	import gamePlay.level1.model.proxy.LevelProxy;
	import gamePlay.level1.view.mediator.LevelMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class SetLevelConfigCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			(facade.retrieveProxy(CountersProxy.NAME) as CountersProxy).setLevelConfig(notification.getBody() as LevelConfigDto);
			facade.registerMediator(new LevelMediator(notification.getBody() as LevelConfigDto));
			facade.registerProxy(new LevelProxy(notification.getBody() as LevelConfigDto));
		}
	}
}