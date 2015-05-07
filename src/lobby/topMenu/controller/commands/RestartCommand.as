package lobby.topMenu.controller.commands
{
	import core.config.GeneralNotifications;
	
	import core.counters.model.proxy.CountersProxy;
	import gamePlay.level1.model.proxy.StartLevelProxy;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import lobby.gameOver.view.mediator.GameOverPopupMediator;
	import gamePlay.level1.view.mediator.LevelMediator;
	import lobby.pause.view.mediator.PausePopupMediator;
	import lobby.win.view.mediator.WinPopupMediator;
	
	public class RestartCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
		//	facade.removeMediator(PausePopupMediator.NAME);
		//	facade.removeMediator(GameOverPopupMediator.NAME);
		//	facade.removeMediator(WinPopupMediator.NAME);
			(facade.retrieveProxy(CountersProxy.NAME) as CountersProxy).restartLevel();
			(facade.retrieveProxy(StartLevelProxy.NAME) as StartLevelProxy).replayLevel();
		}
	}
}