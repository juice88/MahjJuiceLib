package core.controller.commands
{
	import lobby.enterName.view.mediator.EnterNameMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class RemoveMediatorCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			facade.removeMediator(notification.getBody() as String);
		}
	}
}