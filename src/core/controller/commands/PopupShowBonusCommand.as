package core.controller.commands
{
	import core.config.GeneralNotifications;
	import core.config.PopupNames;
	import core.model.dto.PopupConfDto;
	import core.view.mediator.PopupMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class PopupShowBonusCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			var popupDto:PopupConfDto = new PopupConfDto();
			popupDto.nextBtnShow = true;
			popupDto.titleText = "GREAT!!!";
			popupDto.tf1Text = "YOU DIDN'T DO ANY";
			popupDto.tf2Text = "MISTAKES";
			popupDto.tf3Text = "\r\rchoose one of three bonuses";
			popupDto.params = notification.getBody() as String;
			var popMed:PopupMediator = new PopupMediator(PopupNames.POPUP_BONUS, popupDto, GeneralNotifications.BONUS_LEVEL_LOAD);
			sendNotification(GeneralNotifications.DIALOG_LOAD_TO_QUEUE, popMed);
		}
	}
}