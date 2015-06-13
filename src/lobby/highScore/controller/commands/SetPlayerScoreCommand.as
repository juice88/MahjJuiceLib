package lobby.highScore.controller.commands
{
	import lobby.highScore.model.proxy.HighScoreProxy;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class SetPlayerScoreCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			(facade.retrieveProxy(HighScoreProxy.NAME) as HighScoreProxy).setUserScore(notification.getBody() as int);
		}
	}
}