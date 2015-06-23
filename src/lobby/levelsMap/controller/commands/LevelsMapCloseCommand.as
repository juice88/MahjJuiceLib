package lobby.levelsMap.controller.commands
{
	import lobby.levelsMap.view.mediator.LevelsCategoryPopupMediator;
	import lobby.levelsMap.view.mediator.LevelsMapMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class LevelsMapCloseCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			facade.removeMediator(LevelsMapMediator.NAME);
			facade.registerMediator(new LevelsCategoryPopupMediator());
		}
	}
}