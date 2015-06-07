package lobby.enterName.controller.commands
{
	import core.config.GeneralNotifications;
	import core.sharedObject.model.proxy.SharedObjProxy;
	
	import lobby.enterName.view.mediator.UserAlreadyExistPopUpMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class CheckExistUserNameInSOCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			var ifExists:Boolean = (facade.retrieveProxy(SharedObjProxy.NAME) as SharedObjProxy).checkExistansUserName(notification.getBody() as String);
			if (ifExists == true)
			{
				var userExistPop:UserAlreadyExistPopUpMediator = new UserAlreadyExistPopUpMediator(notification.getBody() as String);
				sendNotification(GeneralNotifications.DIALOG_LOAD_TO_QUEUE, userExistPop);
			}
			else
			{
				sendNotification(GeneralNotifications.SET_PLAYER_NAME, notification.getBody());
			}
		}
	}
}