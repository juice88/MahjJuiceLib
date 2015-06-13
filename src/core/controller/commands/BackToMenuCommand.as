package core.controller.commands
{
	import core.sharedObject.model.proxy.SharedObjProxy;
	import core.counters.model.proxy.CountersProxy;
	
	import gamePlay.level1.model.proxy.LevelProxy;
	import gamePlay.level1.view.mediator.LevelMediator;
	
	import lobby.botMenu.view.mediator.BotPanelMediator;
	import lobby.highScore.view.mediator.HighScorePanelMediator;
	import lobby.startScreen.view.mediator.StartScreenMediator;
	import lobby.topMenu.view.mediator.TopPanelMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class BackToMenuCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void{
			
			facade.removeMediator(LevelMediator.NAME);
			facade.removeMediator(TopPanelMediator.NAME);
			facade.removeMediator(BotPanelMediator.NAME);
			facade.removeProxy(LevelProxy.NAME);
			(facade.retrieveProxy(CountersProxy.NAME) as CountersProxy).backToMenu();
			facade.registerMediator(new StartScreenMediator());
			facade.registerMediator(new HighScorePanelMediator());
			(facade.retrieveProxy(SharedObjProxy.NAME) as SharedObjProxy).visibleContinueBtn();
		}
	}
}