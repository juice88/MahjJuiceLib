package lobby.gameOver.controller.commands
{
	import core.config.GeneralNotifications;
	import core.counters.model.dto.CountersDto;
	import core.counters.model.proxy.CountersProxy;
	
	import flash.utils.setTimeout;
	
	import lobby.gameOver.view.mediator.GameOverPopupMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class GameOverCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
	//		facade.removeMediator(GameOverPopupMediator.NAME); //видаляємо медіатор на випадок, якщо він був вже створений (наприклад після програшу було натиснуто меню а потім знову старт гейм, тоді після ще одного програшу ГеймОверПопап не випливає)
	//		facade.registerMediator(new GameOverPopupMediator());
		//	(facade.retrieveProxy(CountersProxy.NAME) as CountersProxy).timerStop();
			var gameOverPop:GameOverPopupMediator = new GameOverPopupMediator();
			sendNotification(GeneralNotifications.DIALOG_LOAD_TO_QUEUE, gameOverPop);
		}
	}
}