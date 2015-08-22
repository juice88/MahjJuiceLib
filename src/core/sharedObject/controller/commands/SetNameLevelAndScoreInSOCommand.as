package core.sharedObject.controller.commands
{
	import core.levelsConfig.model.proxy.LevelsGameConfigProxy;
	import core.sharedObject.model.dto.UserDataDto;
	import core.sharedObject.model.proxy.SharedObjProxy;
	
	import lobby.highScore.model.dto.UserDto;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class SetNameLevelAndScoreInSOCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			var totalNumOfGames:int = (facade.retrieveProxy(LevelsGameConfigProxy.NAME) as LevelsGameConfigProxy).getTotalNumOfGamesType();
			var currentGameType:int = (facade.retrieveProxy(LevelsGameConfigProxy.NAME) as LevelsGameConfigProxy).getCurrentGameType();
			(notification.getBody() as UserDto).currentGameType = currentGameType;
			(facade.retrieveProxy(SharedObjProxy.NAME) as SharedObjProxy).setUserNameLevelEndScore(notification.getBody() as UserDto, totalNumOfGames.toString());
		}
	}
}