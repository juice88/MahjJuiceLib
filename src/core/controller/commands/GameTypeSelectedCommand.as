package core.controller.commands
{
	import core.levelsConfig.model.proxy.LevelsGameConfigProxy;
	import core.sharedObject.model.proxy.SharedObjProxy;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class GameTypeSelectedCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			(facade.retrieveProxy(SharedObjProxy.NAME) as SharedObjProxy).setGameType(notification.getBody() as int);
			(facade.retrieveProxy(LevelsGameConfigProxy.NAME) as LevelsGameConfigProxy).setTypeOfGame(notification.getBody() as int);
		}
	}
}