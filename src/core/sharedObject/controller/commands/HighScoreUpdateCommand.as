package core.sharedObject.controller.commands
{
	import core.levelsConfig.model.proxy.LevelsGameConfigProxy;
	import core.sharedObject.model.proxy.SharedObjProxy;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class HighScoreUpdateCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			var maxLvlNum:int = (facade.retrieveProxy(LevelsGameConfigProxy.NAME) as LevelsGameConfigProxy).getTotalNumOfLevels();
			(facade.retrieveProxy(SharedObjProxy.NAME) as SharedObjProxy).highScoreUpdate(maxLvlNum);
		}
	}
}