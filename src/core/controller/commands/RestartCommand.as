package core.controller.commands
{
	import core.counters.model.proxy.CountersProxy;
	
	import gamePlay.level1.model.proxy.LevelProxy;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class RestartCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			(facade.retrieveProxy(CountersProxy.NAME) as CountersProxy).restartLevel();
			(facade.retrieveProxy(LevelProxy.NAME) as LevelProxy).replayLevel();
		}
	}
}