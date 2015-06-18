package gamePlay.level1.controller.commands
{
	import flash.display.MovieClip;
	
	import gamePlay.level1.model.dto.ElementDto;
	import gamePlay.level1.model.proxy.LevelProxy;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class OpenedElementCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			(facade.retrieveProxy(LevelProxy.NAME) as LevelProxy).openElement(notification.getBody() as ElementDto);
		}
	}
}