package lobby.gameOver.controller.commands
{
	import lobby.gameOver.view.mediator.GameOverPopupMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class GameOverClosePopupCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			facade.removeMediator(GameOverPopupMediator.NAME);
		}
	}
}