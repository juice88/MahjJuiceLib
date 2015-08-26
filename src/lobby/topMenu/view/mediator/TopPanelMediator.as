package lobby.topMenu.view.mediator
{
	import core.config.GeneralEventsConst;
	import core.config.GeneralNotifications;
	import core.view.mediator.UIMediator;
	
	import flash.events.Event;
	
	import lobby.topMenu.view.components.TopPanelViewLogic;
	
	import org.puremvc.as3.interfaces.INotification;

	public class TopPanelMediator extends UIMediator
	{
		public static const NAME:String="TopPanelMediator";
		
		public function TopPanelMediator()
		{
			super(NAME, new TopPanelViewLogic());
		}
		private function get topPanel():TopPanelViewLogic
		{
			return viewLogic as TopPanelViewLogic;
		}
		override public function onRegisterListeners():void
		{
			topPanel.addEventListener(GeneralEventsConst.GO_TO_MENU, onGoToMenuHand);
			topPanel.addEventListener(GeneralEventsConst.RESTART_GAME, onReStartGameHand);
			topPanel.addEventListener(GeneralEventsConst.PAUSE, onPauseHand);
		}
		
		override public function onRemoveListeners():void
		{
			topPanel.removeEventListener(GeneralEventsConst.GO_TO_MENU, onGoToMenuHand);
			topPanel.removeEventListener(GeneralEventsConst.RESTART_GAME, onReStartGameHand);
			topPanel.removeEventListener(GeneralEventsConst.PAUSE, onPauseHand);
		}
		protected function onGoToMenuHand(event:Event):void
		{
			sendNotification(GeneralNotifications.POPUP_SHOW_CONFIRM_TO_EXIT);
		}
		
		protected function onReStartGameHand(event:Event):void
		{
			sendNotification(GeneralNotifications.POPUP_SHOW_CONFIRM_TO_RESTART);
		}
		
		protected function onPauseHand(event:Event):void
		{
			sendNotification(GeneralNotifications.POPUP_SHOW_PAUSE);
		}
		override public function listNotificationInterests():Array{
			return [GeneralNotifications.MOVES_COUTNER_UPDATED,
					GeneralNotifications.SCORE_COUTNER_UPDATED,
					GeneralNotifications.SET_NUMBER_OF_LEVEL_IN_TOP_PANEL];
		}
		override public function handleNotification(notification:INotification):void
		{
			switch (notification.getName())
			{
				case GeneralNotifications.MOVES_COUTNER_UPDATED:
					topPanel.movesCounterUpdate(notification.getBody() as uint);
					break;
				case GeneralNotifications.SCORE_COUTNER_UPDATED:
					topPanel.scoreCounterUpdate(notification.getBody() as uint);
					break;
				case GeneralNotifications.SET_NUMBER_OF_LEVEL_IN_TOP_PANEL:
					topPanel.lvlsCountUpdate(notification.getBody() as int, notification.getType());
			}
		}
	}
}