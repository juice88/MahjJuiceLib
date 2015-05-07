package lobby.settings.controller.commands
{
	import core.config.GeneralNotifications;
	
	import lobby.settings.view.mediator.SettingsPanelMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class SettingsPanelOpenCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			var settingsPanel:SettingsPanelMediator = new SettingsPanelMediator();
			sendNotification(GeneralNotifications.DIALOG_LOAD_TO_QUEUE, settingsPanel);
		}
	}
}