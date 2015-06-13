package lobby.levelsMap.controller.commands
{
	import core.config.GeneralNotifications;
	
	import lobby.levelsMap.view.mediator.LevelsCategoryPopupMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class ShowLevelsCategoryPopupCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			var lvlsCategMed:LevelsCategoryPopupMediator = new LevelsCategoryPopupMediator();
			sendNotification(GeneralNotifications.DIALOG_LOAD_TO_QUEUE, lvlsCategMed);
		}
	}
}