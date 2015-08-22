package lobby.highScore.controller.commands
{
	import core.config.GeneralNotifications;
	
	import lobby.highScore.view.mediator.HighScorePanelMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class ScoreBoardShowCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			var highScorePanel:HighScorePanelMediator = new HighScorePanelMediator();
			sendNotification(GeneralNotifications.DIALOG_LOAD_TO_QUEUE, highScorePanel);
		}
	}
}