package core.queue.controller.commands
{
	import core.queue.model.proxy.QueueDialogProxy;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class DialogCloseCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			(facade.retrieveProxy(QueueDialogProxy.NAME) as QueueDialogProxy).removeDialogFromList();
		}
	}
}