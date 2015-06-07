package lobby.enterName.view.components
{
	import core.config.GameEvent;
	import core.config.GeneralEventsConst;
	import core.utils.SoundLib;
	import core.view.components.DialogViewLogic;
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	public class UserAlreadyExistPopupVL extends DialogViewLogic
	{
		private var _closeBtn:SimpleButton;
		private var _nextBtn:SimpleButton;
		private var _backBtn:SimpleButton;
		private var _userName:String;
		private var _notifTf:TextField;
		
		public function UserAlreadyExistPopupVL(usName:String)
		{
			super("UserAlreadyExistPopUp");
			_userName = usName;
			userExistPopLoad();
		}
		
		private function get userExistPop():MovieClip
		{
			return content as MovieClip;
		}
		
		private function userExistPopLoad():void
		{
			_closeBtn = userExistPop["closeBtn"];
			_nextBtn = userExistPop["nextBtn"];
			_backBtn = userExistPop["backBtn"];
			_notifTf = userExistPop["notifTf"];
			_notifTf.text = "Player "+_userName+" already exist!";
			_closeBtn.addEventListener(MouseEvent.CLICK, onCloseBtnClickHand);
			_nextBtn.addEventListener(MouseEvent.CLICK, onNextBtnClickHand);
			_backBtn.addEventListener(MouseEvent.CLICK, onBackBtnClickHand);
		}
		
		private function removeListeners():void
		{
			_closeBtn.removeEventListener(MouseEvent.CLICK, onCloseBtnClickHand);
			_nextBtn.removeEventListener(MouseEvent.CLICK, onNextBtnClickHand);
			_backBtn.removeEventListener(MouseEvent.CLICK, onBackBtnClickHand);
		}
		
		protected function onCloseBtnClickHand(event:MouseEvent):void
		{
			SoundLib.getInstance().btnClickSound();
			removeListeners();
			dispatchEvent(new Event(GeneralEventsConst.USER_EXIST_POPUP_CLOSE));
		}
		
		protected function onNextBtnClickHand(event:MouseEvent):void
		{
			SoundLib.getInstance().btnClickSound();
			removeListeners();
			_nextBtn.removeEventListener(MouseEvent.CLICK, onNextBtnClickHand);
			dispatchEvent(new GameEvent(GeneralEventsConst.SET_PLAYER_NAME, _userName));
		}
		
		protected function onBackBtnClickHand(event:MouseEvent):void
		{
			SoundLib.getInstance().btnClickSound();
			removeListeners();
			dispatchEvent(new Event(GeneralEventsConst.USER_EXIST_POPUP_BACK));
		}
	}
}