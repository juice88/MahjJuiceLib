package gamePlay.bonus.controller.commands
{
	import core.config.GeneralNotifications;
	
	import core.counters.model.proxy.CountersProxy;
	
	import gamePlay.bonus.view.mediator.BonusMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class BonusResultOfChoiseCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			facade.removeMediator(BonusMediator.NAME);
			sendNotification(GeneralNotifications.POPUP_SHOW_WIN);
			(facade.retrieveProxy(CountersProxy.NAME) as CountersProxy).resultOfChoiseBonus(notification.getBody() as int);
		}
	}
}