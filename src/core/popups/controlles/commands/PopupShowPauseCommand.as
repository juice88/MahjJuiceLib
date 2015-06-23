package core.popups.controlles.commands
{
	import core.config.GeneralNotifications;
	import core.config.PopupNames;
	import core.counters.model.proxy.CountersProxy;
	import core.model.dto.PopupConfDto;
	import core.popups.view.mediator.PopupMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class PopupShowPauseCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			var popupDto:PopupConfDto = new PopupConfDto();
			var totalScore:int = (facade.retrieveProxy(CountersProxy.NAME) as CountersProxy).openPausePopup();
			popupDto.nextBtnShow = true;
			popupDto.titleText = "PAUSE";
			popupDto.totalScore = totalScore;
			var popMed:PopupMediator = new PopupMediator(PopupNames.POPUP_PAUSE, popupDto, GeneralNotifications.PAUSE_CONTINUE_GAME);
			sendNotification(GeneralNotifications.DIALOG_LOAD_TO_QUEUE, popMed);
		}
	}
}