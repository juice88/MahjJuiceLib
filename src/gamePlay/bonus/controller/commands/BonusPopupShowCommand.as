package gamePlay.bonus.controller.commands
{
	import core.config.GeneralNotifications;
	
	import gamePlay.bonus.view.mediator.BonusPopupMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class BonusPopupShowCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			var bonusPop:BonusPopupMediator = new BonusPopupMediator();
			sendNotification(GeneralNotifications.DIALOG_LOAD_TO_QUEUE, bonusPop);
		}
	}
}