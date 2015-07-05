package lobby.settings.view.mediator
{
	import core.config.GeneralEventsConst;
	import core.config.GeneralNotifications;
	import core.view.mediator.DialogMediator;
	
	import flash.events.Event;
	
	import lobby.settings.view.components.SettingsPanelVL;
	
	public class SettingsPanelMediator extends DialogMediator
	{
		public static const NAME:String = "SettingsPanelMediator";
		
		public function SettingsPanelMediator()
		{
			super(NAME, new SettingsPanelVL());
		}
		
		private function get settingsPanel():SettingsPanelVL
		{
			return viewLogic as SettingsPanelVL;
		}
		override public function onRegisterListeners():void
		{
			settingsPanel.addEventListener(GeneralEventsConst.SETTINGS_PANEL_CLOSE, onCloseSettingPanelHand);
			settingsPanel.addEventListener(GeneralEventsConst.FULL_SCREEN, onFullScreenHand);
		}
		override public function onRemoveListeners():void
		{
			settingsPanel.removeEventListener(GeneralEventsConst.SETTINGS_PANEL_CLOSE, onCloseSettingPanelHand);
			settingsPanel.removeEventListener(GeneralEventsConst.FULL_SCREEN, onFullScreenHand);
		}
		
		protected function onCloseSettingPanelHand(event:Event):void
		{
			sendNotification(GeneralNotifications.REMOVE_POPUP, NAME);
		}
		
		protected function onFullScreenHand(event:Event):void
		{
			sendNotification(GeneralNotifications.FULL_SCREEN);
		}
	}
}