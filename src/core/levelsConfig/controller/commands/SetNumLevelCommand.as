package core.levelsConfig.controller.commands
{
	import core.levelsConfig.model.proxy.LevelsGameConfigProxy;
	
	import lobby.highScore.model.proxy.HighScoreProxy;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class SetNumLevelCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			(facade.retrieveProxy(HighScoreProxy.NAME) as HighScoreProxy).setNumLevel(notification.getBody() as int);
		}
	}
}