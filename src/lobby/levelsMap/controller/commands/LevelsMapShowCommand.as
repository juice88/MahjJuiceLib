package lobby.levelsMap.controller.commands
{
	import core.sharedObject.model.proxy.SharedObjProxy;
	
	import lobby.levelsMap.view.mediator.LevelsCategoryPopupMediator;
	import lobby.levelsMap.view.mediator.LevelsMapMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class LevelsMapShowCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			facade.removeMediator(LevelsCategoryPopupMediator.NAME);
			var lvlNum:int = (facade.retrieveProxy(SharedObjProxy.NAME) as SharedObjProxy).detFinishedLvlNum();
			switch (notification.getBody())
			{
				case "simpleLvlsBtn":
					facade.registerMediator(new LevelsMapMediator(1, lvlNum));
					break;
				case "middleLvlsBtn":
					facade.registerMediator(new LevelsMapMediator(2, lvlNum));
					break;
				case "highLvlsBtn":
					facade.registerMediator(new LevelsMapMediator(3, lvlNum));
				break;
			}
		}
	}
}