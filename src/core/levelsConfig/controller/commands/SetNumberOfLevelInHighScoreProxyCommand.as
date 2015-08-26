package core.levelsConfig.controller.commands
{
	import core.config.GeneralNotifications;
	import core.levelsConfig.model.proxy.LevelsGameConfigProxy;
	import core.sharedObject.model.proxy.SharedObjProxy;
	
	import lobby.highScore.model.dto.UserDto;
	import lobby.highScore.model.proxy.HighScoreProxy;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class SetNumberOfLevelInHighScoreProxyCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			(facade.retrieveProxy(HighScoreProxy.NAME) as HighScoreProxy).setNumLevel(notification.getBody() as int, notification.getType() as String);
//			var totalNumOfComplLvls:int = (facade.retrieveProxy(SharedObjProxy.NAME) as SharedObjProxy).getTotalNumOfComplLvls();
//			var totalNumOfLevels:int = (facade.retrieveProxy(LevelsGameConfigProxy.NAME) as LevelsGameConfigProxy).getTotalNumOfLevels();
//			sendNotification(GeneralNotifications.SET_NUMBER_OF_LEVEL_IN_TOP_PANEL, totalNumOfComplLvls, totalNumOfLevels.toString());
		}
	}
}