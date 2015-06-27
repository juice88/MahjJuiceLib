package core.popups.controlles.commands
{
	import core.config.GeneralNotifications;
	import core.config.PopupNames;
	import core.model.dto.PopupConfDto;
	import core.popups.view.mediator.PopupMediator;
	import core.sharedObject.model.proxy.SharedObjProxy;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class PopupShowConfirmToNewGameCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			var maxNumLvl:int = (facade.retrieveProxy(SharedObjProxy.NAME) as SharedObjProxy).getMaxNumOfComplLvl();
			if (maxNumLvl>1)
			{
				var popupDto:PopupConfDto = new PopupConfDto();
				popupDto.xBtnShow = true;
				popupDto.nextBtnShow = true;
				popupDto.titleText = "WARNING!";
				popupDto.tf1Text = "Are you sure?"
				popupDto.tf3Text = "\rYou score and all progress\rin game will be lost";
				var popMed:PopupMediator = new PopupMediator(PopupNames.POPUP_CONFIRM_TO_NEW_GAME, popupDto, GeneralNotifications.START_NEW_GAME);
				sendNotification(GeneralNotifications.DIALOG_LOAD_TO_QUEUE, popMed);
			} else {
				sendNotification(GeneralNotifications.START_NEW_GAME);
			}
		}
	}
}