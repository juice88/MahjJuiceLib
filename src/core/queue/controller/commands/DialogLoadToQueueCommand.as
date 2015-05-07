package core.queue.controller.commands
{
	import core.queue.model.proxy.QueueDialogProxy;
	import core.view.mediator.DialogMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class DialogLoadToQueueCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			var dialog:DialogMediator = notification.getBody() as DialogMediator;
			(facade.retrieveProxy(QueueDialogProxy.NAME) as QueueDialogProxy).addedDialogToList(dialog);
		}
	}
}