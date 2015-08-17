package core.popups.controlles.commands
{
	import core.config.GeneralNotifications;
	import core.config.PopupNames;
	import core.popups.model.dto.PopupConfDto;
	import core.popups.view.mediator.PopupMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class PopupShowGameOverCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			var popupDto:PopupConfDto = new PopupConfDto();
			popupDto.restartBtnShow = true;
			popupDto.titleText = "GAME OVER :-(";
			popupDto.tf1Text = "SORRY, YOU LOST";
			popupDto.tf3Text = "\rtry again";
			var popMed:PopupMediator = new PopupMediator(PopupNames.POPUP_GAME_OVER, popupDto, null, null, null, GeneralNotifications.RESTART_GAME);
			sendNotification(GeneralNotifications.DIALOG_LOAD_TO_QUEUE, popMed);
		}
	}
}