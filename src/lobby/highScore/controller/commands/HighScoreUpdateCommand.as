package lobby.highScore.controller.commands
{
	import core.sharedObject.model.proxy.SharedObjProxy;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class HighScoreUpdateCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			(facade.retrieveProxy(SharedObjProxy.NAME) as SharedObjProxy).highScoreUpdate();
		}
	}
}