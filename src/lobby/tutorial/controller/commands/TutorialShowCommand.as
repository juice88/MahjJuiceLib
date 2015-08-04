package lobby.tutorial.controller.commands
{
	import core.config.GeneralNotifications;
	
	import lobby.tutorial.view.mediator.TutorialPopupMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class TutorialShowCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			var tutorialMed:TutorialPopupMediator = new TutorialPopupMediator();
			sendNotification(GeneralNotifications.DIALOG_LOAD_TO_QUEUE, tutorialMed);
		}
	}
}