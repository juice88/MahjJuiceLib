package core.popups.controlles.commands
{
	import core.config.GeneralNotifications;
	import core.config.PopupNames;
	import core.popups.model.dto.PopupConfDto;
	import core.sharedObject.model.proxy.SharedObjProxy;
	import core.popups.view.mediator.PopupMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class PopupShowCheckUserNameExistCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			var userIsExists:Boolean = (facade.retrieveProxy(SharedObjProxy.NAME) as SharedObjProxy).checkExistansUserName(notification.getBody() as String);
			if (userIsExists)
			{
				var popupDto:PopupConfDto = new PopupConfDto();
				popupDto.nextBtnShow = true;
				popupDto.xBtnShow = true;
				popupDto.backBtnShow = true;
				popupDto.titleText = "Attention!";
				popupDto.tf3Text = "Player "+ (notification.getBody() as String) +"\ralready exist! Continue?";
				popupDto.params = notification.getBody() as String;
				var popMed:PopupMediator = new PopupMediator(PopupNames.POPUP_CHECK_USER_NAME_EXISTANCE, popupDto, GeneralNotifications.SET_PLAYER_NAME, GeneralNotifications.POPUP_SHOW_ENTER_NAME, GeneralNotifications.SET_PLAYER_NAME);
				sendNotification(GeneralNotifications.DIALOG_LOAD_TO_QUEUE, popMed);
			} else {
				sendNotification(GeneralNotifications.SET_PLAYER_NAME, notification.getBody());
			}
		}
	}
}