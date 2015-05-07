package core.queue.controller.commands
{
	import core.view.mediator.DialogMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class DialogOpenCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			facade.registerMediator(notification.getBody() as DialogMediator);
		}
	}
}