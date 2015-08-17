package core.popups.controlles.commands
{
	import core.config.GeneralNotifications;
	import core.config.PopupNames;
	import core.counters.model.proxy.CountersProxy;
	import core.popups.model.dto.PopupConfDto;
	import core.popups.view.mediator.PopupMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class PopupShowWinCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			var popupDto:PopupConfDto = new PopupConfDto();
			popupDto.nextBtnShow = true;
			popupDto.titleText = "PERFECT,";
			popupDto.tf1Text = "YOU WON ;-)";
			var scoreTrueFalseValue:Array = (facade.retrieveProxy(CountersProxy.NAME) as CountersProxy).sendValueScoreTrueFalseMoves();
			popupDto.levelScore = scoreTrueFalseValue[0];
			popupDto.trueMoves = scoreTrueFalseValue[1];
			popupDto.falseMoves = scoreTrueFalseValue[2];
			var popMed:PopupMediator = new PopupMediator(PopupNames.POPUP_WIN, popupDto, GeneralNotifications.NEXT_LEVEL);
			sendNotification(GeneralNotifications.DIALOG_LOAD_TO_QUEUE, popMed);
		}
	}
}