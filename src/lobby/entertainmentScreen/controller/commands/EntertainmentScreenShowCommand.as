package lobby.entertainmentScreen.controller.commands
{
	import lobby.entertainmentScreen.view.mediator.EntertainmentScreenMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class EntertainmentScreenShowCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			facade.registerMediator(new EntertainmentScreenMediator());
		}
	}
}