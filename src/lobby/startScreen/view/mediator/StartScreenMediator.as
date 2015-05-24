package lobby.startScreen.view.mediator
{
	
	import core.config.GeneralEventsConst;
	import core.config.GeneralNotifications;
	import core.view.mediator.UIMediator;
	
	import flash.events.Event;
	
	import lobby.startScreen.view.components.StartViewLogic;
	
	import org.puremvc.as3.interfaces.INotification;
	
	public class StartScreenMediator extends UIMediator
	{
		public static const NAME:String = "StartMediator";
		
		public function StartScreenMediator()
		{
			super(NAME, new StartViewLogic());
		}
		
		private function get startScreen():StartViewLogic
		{
			return viewLogic as StartViewLogic;
		}
		
		override public function onRegisterListeners():void
		{
			startScreen.addEventListener(GeneralEventsConst.START_NEW_GAME, onStartGameHand);
			startScreen.addEventListener(GeneralEventsConst.CONTINUE_GAME, onContinueGameHand);
			startScreen.addEventListener(GeneralEventsConst.SHOW_SETTINGS_PANEL, onShowSettingsPanelHand);
			startScreen.addEventListener(GeneralEventsConst.CHOISE_OF_LEVEL, onChoiseOfLevelHand);
		}
		
		override public function onRemoveListeners():void
		{
			startScreen.removeEventListener(GeneralEventsConst.START_NEW_GAME, onStartGameHand);
			startScreen.removeEventListener(GeneralEventsConst.CONTINUE_GAME, onContinueGameHand);
			startScreen.removeEventListener(GeneralEventsConst.SHOW_SETTINGS_PANEL, onShowSettingsPanelHand);
		}
		
		protected function onStartGameHand(event:Event):void
		{
			sendNotification(GeneralNotifications.START_NEW_GAME);
		}
		
		protected function onContinueGameHand(event:Event):void
		{
			sendNotification(GeneralNotifications.CONTINUE_GAME);
		}
		
		protected function onShowSettingsPanelHand(event:Event):void
		{
			sendNotification(GeneralNotifications.SETTINGS_PANEL_OPEN);
		}
		
		protected function onChoiseOfLevelHand(event:Event):void
		{
			sendNotification(GeneralNotifications.CHOISE_OF_LEVEL);			
		}
		
		override public function listNotificationInterests():Array
		{
			return [GeneralNotifications.CONTINUE_BTN_IS_VISIBLE];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch (notification.getName())
			{
				case GeneralNotifications.CONTINUE_BTN_IS_VISIBLE:
					startScreen.continueGameBtnIsVis();
					break;
			}
		}
	}
}