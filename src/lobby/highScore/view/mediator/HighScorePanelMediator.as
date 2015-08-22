package lobby.highScore.view.mediator
{
	import core.config.GeneralEventsConst;
	import core.config.GeneralNotifications;
	import core.view.mediator.DialogMediator;
	
	import flash.events.Event;
	
	import lobby.highScore.view.components.HighScorePanelVL;
	
	import org.puremvc.as3.interfaces.INotification;
	
	public class HighScorePanelMediator extends DialogMediator
	{
		public static const NAME:String = "HighScorePanelMediator";
		
		public function HighScorePanelMediator()
		{
			super(NAME, new HighScorePanelVL());
			layer = "upper";
		}
		
		private function get highScoreVL():HighScorePanelVL
		{
			return viewLogic as HighScorePanelVL;
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			sendNotification(GeneralNotifications.HIGH_SCORE_UPDATE);
		}
		
		override public function onRegisterListeners():void
		{
			highScoreVL.addEventListener(GeneralEventsConst.SCORE_BOARD_HIDE, onScoreBoardHideHand);
		}
		
		override public function onRemoveListeners():void
		{
			highScoreVL.removeEventListener(GeneralEventsConst.SCORE_BOARD_HIDE, onScoreBoardHideHand);
		}
		
		protected function onScoreBoardHideHand(event:Event):void
		{
			sendNotification(GeneralNotifications.REMOVE_POPUP, NAME);
		}
		
		override public function listNotificationInterests():Array
		{
			return [GeneralNotifications.HIGH_SCORE_SEND];	
			
		}
		override public function handleNotification(notification:INotification):void
		{
			switch (notification.getName())
			{
				case GeneralNotifications.HIGH_SCORE_SEND:
					highScoreVL.highScoreBoardUpdate(notification.getBody() as Array, notification.getType());
					break;
			}
		}
	}
}