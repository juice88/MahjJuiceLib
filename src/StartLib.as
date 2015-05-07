package 
{
	import core.config.GeneralNotifications;
	import core.controller.commands.StartAppCommand;
	
	import flash.display.Sprite;
	
	import org.puremvc.as3.patterns.facade.Facade;
	
	public class StartLib
	{
		private static var _instance:StartLib;
		
		public static function getInstance():StartLib
		{
			if (_instance==null)
			{
				_instance = new StartLib();
			}
			return _instance;
		}
		
		public function start(sprite:Sprite):void
		{
			Facade.getInstance().registerCommand(GeneralNotifications.START_APP, StartAppCommand);
			Facade.getInstance().sendNotification(GeneralNotifications.START_APP, sprite);
		}
	}
}