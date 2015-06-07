package gamePlay.bonus.controller.commands
{
	import core.counters.model.dto.CountersDto;
	import core.counters.model.proxy.CountersProxy;
	
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
			var scoreBonus:int = (facade.retrieveProxy(CountersProxy.NAME) as CountersProxy).getScoreBonus();
			facade.registerProxy(new BonusProxy(scoreBonus));
			//(facade.retrieveProxy(BonusProxy.NAME) as BonusProxy).sendBonusKadrList();
		//	facade.removeMediator(LevelMediator.NAME);
		}
	}
}