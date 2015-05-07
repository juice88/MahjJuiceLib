package gamePlay.level1.controller.commands
{
	
	
	import gamePlay.level1.model.proxy.StartLevelProxy;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class EndTurnCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			(facade.retrieveProxy(StartLevelProxy.NAME) as StartLevelProxy).endTurn();
		}
	}
}