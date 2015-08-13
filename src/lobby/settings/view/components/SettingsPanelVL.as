package lobby.settings.view.components
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Back;
	
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
		
		public function SettingsPanelVL()
		{
			super("SettingsPanel");
			loadSettingsPanel();
		}
		
		private function get setPanelVL():MovieClip
		{
			return content as MovieClip;
		}
		
		private function loadSettingsPanel():void
		{
			addSettingsPanelTween();
			_closeBtn = setPanelVL["closeBtn"];
			_closeBtn.addEventListener(MouseEvent.CLICK, onCloseBtnClickHand);
			_muteBtn = setPanelVL["muteBtn"];
			_muteBtn.addEventListener(MouseEvent.CLICK, onMuteBtnClickHand);
			_fullScreenBtn = setPanelVL["fullScreenBtn"];
			_fullScreenBtn.addEventListener(MouseEvent.CLICK, onFullScreenBtnClickHand);
			checkMuteStatus();
		}
		
		protected function addSettingsPanelTween():void
		{
			//setPanelVL.y=-645;
			setPanelVL.x = -1280;
			setPanelVL.scaleX = 0.001;
//			setPanelVL.scaleY = 0.1;
			TweenLite.to(setPanelVL, 0.7, {x:0, y:0, scaleX:1, scaleY:1/*, ease:Back.easeOut*/});
		}
		
		private function checkMuteStatus():void
		{
			var muteStatus:Boolean = SoundLib.getInstance().getMuteStatus();
			if (muteStatus)
			{
				setPanelVL.muteBtn.gotoAndStop(2);
			} else {
				setPanelVL.muteBtn.gotoAndStop(1);
			}
		}
		
		protected function onCloseBtnClickHand(event:MouseEvent):void
		{
			SoundLib.getInstance().btnClickSound();
			dispatchEvent(new Event(GeneralEventsConst.SETTINGS_PANEL_CLOSE));
		}
		
		protected function onMuteBtnClickHand(event:MouseEvent):void
		{
			SoundLib.getInstance().btnClickSound();
			SoundLib.getInstance().muteSound();
			checkMuteStatus();
		}
		
		protected function onFullScreenBtnClickHand(event:MouseEvent):void
		{
			SoundLib.getInstance().btnClickSound();
			dispatchEvent(new Event(GeneralEventsConst.FULL_SCREEN));
		}
	}
}