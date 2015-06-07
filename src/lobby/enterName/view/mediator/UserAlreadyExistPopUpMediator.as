package lobby.enterName.view.mediator
{
	import core.config.GameEvent;
	import core.config.GeneralEventsConst;
	import core.config.GeneralNotifications;
	import core.view.mediator.DialogMediator;
	
	import flash.events.Event;
	
	import lobby.enterName.view.components.UserAlreadyExistPopupVL;
	
	public class UserAlreadyExistPopUpMediator extends DialogMediator
	{
		public static const NAME:String = "UserAlreadyExistPopUpMediator";
		
		public function UserAlreadyExistPopUpMediator(usName:String)
		{
			super(NAME, new UserAlreadyExistPopupVL(usName));
		}
		
		private function get userExistVL():UserAlreadyExistPopupVL
		{
			return viewLogic as UserAlreadyExistPopupVL;
		}
		
		override public function onRegisterListeners():void
		{
			userExistVL.addEventListener(GeneralEventsConst.USER_EXIST_POPUP_CLOSE, onCloseUserExistPopupHand);
			userExistVL.addEventListener(GeneralEventsConst.SET_PLAYER_NAME, onSetPlayerName);
			userExistVL.addEventListener(GeneralEventsConst.USER_EXIST_POPUP_BACK, onBackUserExistPopupHand);
		}
		
		override public function onRemoveListeners():void
		{
			userExistVL.removeEventListener(GeneralEventsConst.USER_EXIST_POPUP_CLOSE, onCloseUserExistPopupHand);
			userExistVL.removeEventListener(GeneralEventsConst.SET_PLAYER_NAME, onSetPlayerName);
			userExistVL.removeEventListener(GeneralEventsConst.USER_EXIST_POPUP_BACK, onBackUserExistPopupHand);
		}
		
		protected function onCloseUserExistPopupHand(event:Event):void
		{
			sendNotification(GeneralNotifications.REMOVE_DIALOG, NAME);
		}
		
		protected function onSetPlayerName(event:GameEvent):void
		{
			sendNotification(GeneralNotifications.REMOVE_DIALOG, NAME);
			sendNotification(GeneralNotifications.SET_PLAYER_NAME, event.params);
		}
		
		protected function onBackUserExistPopupHand(event:Event):void
		{
			sendNotification(GeneralNotifications.REMOVE_DIALOG, NAME);
			sendNotification(GeneralNotifications.SHOW_ENTER_NAME_POPUP);
		}
	}
}