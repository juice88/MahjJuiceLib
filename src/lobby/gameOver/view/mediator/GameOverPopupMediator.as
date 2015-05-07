package lobby.gameOver.view.mediator
{
	import core.config.GeneralEventsConst;
	import core.config.GeneralNotifications;
	import core.view.mediator.DialogMediator;
	
	import flash.events.Event;
	
	import lobby.gameOver.view.components.GameOverPopupVL;

	public class GameOverPopupMediator extends DialogMediator
	{
		public static const NAME:String = "GameOverPopupMediator";
		
		public function GameOverPopupMediator()
		{
			super(NAME, new GameOverPopupVL());
		}
		private function get gameOverPopup():GameOverPopupVL
		{
			return viewLogic as GameOverPopupVL;
		}
		
		override public function onRegisterListeners():void
		{
			gameOverPopup.addEventListener(GeneralEventsConst.RESTART_GAME, onReStartGameHand);
		}
		
		override public function onRemoveListeners():void
		{
			gameOverPopup.removeEventListener(GeneralEventsConst.RESTART_GAME, onReStartGameHand);
		}
		
		protected function onReStartGameHand(event:Event):void
		{
			sendNotification(GeneralNotifications.GAME_OVER_CLOSE_POPUP);
			sendNotification(GeneralNotifications.RESTART_GAME);
		}
	}
}