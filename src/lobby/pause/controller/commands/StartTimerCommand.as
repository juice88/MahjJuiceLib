package lobby.pause.controller.commands
{
	import core.counters.model.proxy.CountersProxy;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class StartTimerCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			(facade.retrieveProxy(CountersProxy.NAME) as CountersProxy).timerGame();
		}
	}
}