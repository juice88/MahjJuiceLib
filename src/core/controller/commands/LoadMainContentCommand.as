package core.controller.commands
{
	import core.config.GeneralNotifications;
	import core.counters.model.proxy.CountersProxy;
	import core.levelsConfig.model.proxy.LevelsGameConfigProxy;
	import core.queue.model.proxy.QueueDialogProxy;
	import core.sharedObject.model.proxy.SharedObjProxy;
	
	import lobby.highScore.model.proxy.HighScoreProxy;
	import lobby.highScore.view.mediator.HighScorePanelMediator;
	import lobby.startScreen.view.mediator.StartScreenMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class LoadMainContentCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			facade.registerProxy(new SharedObjProxy());
			facade.registerProxy(new QueueDialogProxy());
			facade.registerProxy(new CountersProxy());
			facade.registerProxy(new HighScoreProxy());
			facade.registerMediator(new StartScreenMediator());
			sendNotification(GeneralNotifications.POPUP_SHOW_ENTER_NAME);
			//facade.registerMediator(new HighScorePanelMediator());
		}
	}
}