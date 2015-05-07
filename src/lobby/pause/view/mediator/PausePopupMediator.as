package lobby.pause.view.mediator
{
	import core.config.GeneralEventsConst;
	import core.config.GeneralNotifications;
	import core.view.mediator.DialogMediator;
	
	import flash.events.Event;
	
	import lobby.pause.view.components.PausePopupVL;
	
	import org.puremvc.as3.interfaces.INotification;

	public class PausePopupMediator extends DialogMediator
	{
		public static const NAME:String = "PausePopupMediator";
		
		public function PausePopupMediator()
		{
			super(NAME, new PausePopupVL());
		}	
		private function get pausePopup():PausePopupVL
		{
			return viewLogic as PausePopupVL;
		}
		override public function onRegisterListeners():void
		{
			pausePopup.addEventListener(GeneralEventsConst.PAUSE_CONTINUE_GAME, onContinueGameHand);
		}
		override public function onRemoveListeners():void
		{
			pausePopup.removeEventListener(GeneralEventsConst.PAUSE_CONTINUE_GAME, onContinueGameHand);
		}
		
		protected function onContinueGameHand(event:Event):void
		{
			sendNotification(GeneralNotifications.PAUSE_CONTINUE_GAME);			
		}
		
		override public function listNotificationInterests():Array
		{
			return [GeneralNotifications.TOTAL_SCORE_UPDATED];	
		}
		override public function handleNotification(notification:INotification):void
		{
			switch (notification.getName())
			{
				case GeneralNotifications.TOTAL_SCORE_UPDATED:
					pausePopup.totalScoreUpdated(notification.getBody() as int);
					break;
			}
		}
	}
}