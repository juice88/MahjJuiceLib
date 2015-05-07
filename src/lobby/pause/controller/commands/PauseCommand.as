package lobby.pause.controller.commands
{
	import core.config.GeneralNotifications;
	
	import core.counters.model.proxy.CountersProxy;
	import gamePlay.level1.model.proxy.StartLevelProxy;
	
	import lobby.pause.view.mediator.PausePopupMediator;
	import lobby.win.view.mediator.WinPopupMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class PauseCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
//			facade.registerMediator(new PausePopupMediator());
			var pausePop:PausePopupMediator = new PausePopupMediator();
			sendNotification(GeneralNotifications.DIALOG_LOAD_TO_QUEUE, pausePop);
			(facade.retrieveProxy(CountersProxy.NAME) as CountersProxy).openPausePopup();
		}
	}
}