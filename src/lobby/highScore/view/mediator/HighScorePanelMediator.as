package lobby.highScore.view.mediator
{
	import core.config.GeneralNotifications;
	import core.view.mediator.UIMediator;
	
	import lobby.highScore.view.components.HighScorePanelVL;
	
	import org.puremvc.as3.interfaces.INotification;
	
	public class HighScorePanelMediator extends UIMediator
	{
		public static const NAME:String = "HighScorePanelMediator";
		
		public function HighScorePanelMediator()
		{
			super(NAME, new HighScorePanelVL());
			layer = "lower";
		}
		
		override public function onRegisterListeners():void
		{
			sendNotification(GeneralNotifications.HIGH_SCORE_UPDATE);
		}
		
		private function get highScoreVL():HighScorePanelVL
		{
			return viewLogic as HighScorePanelVL;
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
					highScoreVL.highScoreBoardUpdate(notification.getBody() as Array);
					break;
			}
		}
	}
}