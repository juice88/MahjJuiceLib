package lobby.tutorial.controller.commands
{
	import lobby.tutorial.view.mediator.TutorialPopupMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class TutorialShowCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			facade.registerMediator(new TutorialPopupMediator());
		}
	}
}