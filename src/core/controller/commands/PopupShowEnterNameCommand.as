package core.controller.commands
{
	import core.config.GeneralNotifications;
	import core.config.PopupNames;
	import core.model.dto.PopupConfDto;
	import core.view.mediator.PopupMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class PopupShowEnterNameCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			var popupDto:PopupConfDto = new PopupConfDto();
			popupDto.inputText = "your name";
			popupDto.nextBtnShow = true;
			popupDto.tf1Text = "Enter your name please";
			popupDto.titleText = "HI!";
			popupDto.xBtnShow = true;
			var popMed:PopupMediator = new PopupMediator(PopupNames.POPUP_ENTER_NAME, popupDto, GeneralNotifications.POPUP_SHOW_CHECK_USER_NAME_EXIST, null, GeneralNotifications.SET_PLAYER_NAME);
			sendNotification(GeneralNotifications.DIALOG_LOAD_TO_QUEUE, popMed);
		}
	}
}