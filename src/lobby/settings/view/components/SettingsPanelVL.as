package lobby.settings.view.components
{
	import core.config.GeneralEventsConst;
	import core.utils.SoundLib;
	import core.view.components.DialogViewLogic;
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class SettingsPanelVL extends DialogViewLogic
	{
		private var _closeBtn:SimpleButton;
		private var _muteBtn:MovieClip;
		private var _fullScreenBtn:SimpleButton;
		private var _frameMuteBtn:uint = 1;
		
		public function SettingsPanelVL()
		{
			super("SettingsPanel");
			loadSettingsPanel();
		}
		
		private function get setPanelVL():MovieClip
		{
			return content as MovieClip;
		}
		
		public function loadSettingsPanel():void
		{
			_closeBtn = setPanelVL["closeBtn"];
			_closeBtn.addEventListener(MouseEvent.CLICK, onCloseBtnClickHand);
			_muteBtn = setPanelVL["muteBtn"];
			_muteBtn.addEventListener(MouseEvent.CLICK, onMuteBtnClickHand);
			_fullScreenBtn = setPanelVL["fullScreenBtn"];
			_fullScreenBtn.addEventListener(MouseEvent.CLICK, onFullScreenBtnClickHand);
		}
		
		protected function onCloseBtnClickHand(event:MouseEvent):void
		{
			SoundLib.getInstance().btnClickSound();
			dispatchEvent(new Event(GeneralEventsConst.SETTINGS_PANEL_CLOSE));
		}
		protected function onMuteBtnClickHand(event:MouseEvent):void
		{
			SoundLib.getInstance().btnClickSound();
			SoundLib.getInstance().mute();
			if (_frameMuteBtn == 1)
			{
				_frameMuteBtn = 2;
			}
			else 
			{
				_frameMuteBtn = 1;
			}
			setPanelVL.muteBtn.gotoAndStop(_frameMuteBtn);
			dispatchEvent(new Event(GeneralEventsConst.MUTE));
		}
		
		protected function onFullScreenBtnClickHand(event:MouseEvent):void
		{
			SoundLib.getInstance().btnClickSound();
			dispatchEvent(new Event(GeneralEventsConst.FULL_SCREEN));
		}
	}
}