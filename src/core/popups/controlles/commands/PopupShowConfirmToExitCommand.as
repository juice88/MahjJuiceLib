package core.popups.controlles.commands
{
	import core.config.GeneralNotifications;
	import core.config.PopupNames;
	import core.model.dto.PopupConfDto;
	import core.popups.view.mediator.PopupMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class PopupShowConfirmToExitCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			var popupDto:PopupConfDto = new PopupConfDto();
			popupDto.xBtnShow = true;
			popupDto.nextBtnShow = true;
			popupDto.titleText = "WARNING!";
			popupDto.tf1Text = "Are you sure?";
			popupDto.tf2Text = "All progress will be lost";
			var popMed:PopupMediator = new PopupMediator(PopupNames.POPUP_CONFIRM_TO_EXIT, popupDto, GeneralNotifications.BACK_TO_MENU);
			sendNotification(GeneralNotifications.DIALOG_LOAD_TO_QUEUE, popMed);
		}
	}
}