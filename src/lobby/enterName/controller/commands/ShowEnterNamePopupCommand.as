package lobby.enterName.controller.commands
{
	import core.config.GeneralNotifications;
	
	import lobby.enterName.view.mediator.EnterNameMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class ShowEnterNamePopupCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			var enterNamePopup:EnterNameMediator = new EnterNameMediator();
			sendNotification(GeneralNotifications.DIALOG_LOAD_TO_QUEUE, enterNamePopup);
		}
	}
}