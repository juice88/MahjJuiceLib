package gamePlay.bonus.controller.commands
{
	import gamePlay.bonus.model.proxy.BonusProxy;
	import gamePlay.bonus.view.mediator.BonusMediator;
	import gamePlay.bonus.view.mediator.BonusPopupMediator;
	import gamePlay.level1.view.mediator.LevelMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class BonusLevelLoadCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			facade.removeMediator(BonusPopupMediator.NAME);
			facade.registerMediator(new BonusMediator());
			facade.registerProxy(new BonusProxy());
			//(facade.retrieveProxy(BonusProxy.NAME) as BonusProxy).sendBonusKadrList();
		//	facade.removeMediator(LevelMediator.NAME);
		}
	}
}