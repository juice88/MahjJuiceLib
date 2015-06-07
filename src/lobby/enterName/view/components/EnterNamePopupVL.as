package lobby.enterName.view.components
{
	import core.config.GameEvent;
	import core.config.GeneralEventsConst;
	import core.utils.SoundLib;
	import core.view.components.DialogViewLogic;
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	public class EnterNamePopupVL extends DialogViewLogic
	{
		private var _closeBtn:SimpleButton;
		private var _nextBtn:SimpleButton;
		private var _playerName:String;
		private var _setPlayerNameTF:TextField;
		
		public function EnterNamePopupVL()
		{
			super("EnterNamePopup");
			namePopupLoad();
		}
		
		private function get setNamePop():MovieClip
		{
			return content as MovieClip;
		}
		
		private function namePopupLoad():void
		{
			_setPlayerNameTF = setNamePop["enterName"];
			_closeBtn = setNamePop["closeBtn"];
			setNamePop["enterName"].maxChars = 10; //максимальна к-ть вводимих символів
			_closeBtn.addEventListener(MouseEvent.CLICK, onCloseBtnClickHand);
			_setPlayerNameTF.addEventListener(KeyboardEvent.KEY_UP, onSettEnterNamePlayerHand);
			_setPlayerNameTF.addEventListener(MouseEvent.MOUSE_DOWN, onMouseClickForText);
		}
		
		protected function onSettEnterNamePlayerHand(event:KeyboardEvent):void
		{
			_playerName = setNamePop["enterName"].text;
			
			if(event.charCode == 13) //якщо натиснуто Enter
			{
				if (_setPlayerNameTF.text.length == 0)
				{
					return;
				}
				else 
				{
					addListenersForNextBtn();
					dispatchEvent(new GameEvent(GeneralEventsConst.SET_PLAYER_NAME, _playerName));
					removeListeners();
				}
			}
			else
			{
				if (_setPlayerNameTF.text.length == 0)
				{
					return;
				}
				else
				{
					addListenersForNextBtn();
				}
			}
		}
		
		private function addListenersForNextBtn():void
		{
			_setPlayerNameTF.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseClickForText);
			_nextBtn = setNamePop["nextBtn"];
			_nextBtn.addEventListener(MouseEvent.CLICK, onNextBtnClickHand);
		}
		protected function onMouseClickForText(event:MouseEvent):void
		{
			_setPlayerNameTF.text = "";
		}
		
		protected function onCloseBtnClickHand(event:MouseEvent):void
		{
			SoundLib.getInstance().btnClickSound();
			removeListeners();
			dispatchEvent(new Event(GeneralEventsConst.ENTER_NAME_POPUP_CLOSE));
		}
		
		protected function onNextBtnClickHand(event:MouseEvent):void
		{
			SoundLib.getInstance().btnClickSound();
			removeListeners();
			_nextBtn.removeEventListener(MouseEvent.CLICK, onNextBtnClickHand);
			dispatchEvent(new GameEvent(GeneralEventsConst.SET_PLAYER_NAME, _playerName));
		}
		
		private function removeListeners():void
		{
			_closeBtn.removeEventListener(MouseEvent.CLICK, onCloseBtnClickHand);
		
			_setPlayerNameTF.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseClickForText);
			_setPlayerNameTF.removeEventListener(KeyboardEvent.KEY_UP, onSettEnterNamePlayerHand);
		}
	}
}