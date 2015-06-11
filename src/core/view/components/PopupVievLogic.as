package core.view.components
{
	import core.config.GameEvent;
	import core.config.GeneralEventsConst;
	import core.model.dto.PopupConfDto;
	import core.utils.SoundLib;
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	public class PopupVievLogic extends DialogViewLogic
	{
		private var _backBtn:SimpleButton;
		private var _nextBtn:SimpleButton;
		private var _xBtn:SimpleButton;
		private var _restartBtn:SimpleButton;
		private var _title:MovieClip;
		private var _tf1:MovieClip;
		private var _tf2:MovieClip;
		private var _tf3:MovieClip;
		private var _inputTf:MovieClip;
		private var _totalScoreTf:MovieClip;
		private var _levelScoreTf:MovieClip;
		private var _trueMovesTf:MovieClip;
		private var _falseMovesTf:MovieClip;
		
		private var _titleText:TextField;
		private var _tf1Text:TextField;
		private var _tf2Text:TextField;
		private var _tf3Text:TextField;
		private var _inputText:TextField;
		private var _totalScoreText:TextField;
		private var _levelScoreText:TextField;
		private var _trueMovesText:TextField;
		private var _falseMovesText:TextField;
		
		private var _params:String;
		
		public function PopupVievLogic(popupDto:PopupConfDto)
		{
			super("PopupShablon");
			popupLoad(popupDto);
		}
		
		private function get popup():MovieClip
		{
			return content as MovieClip;
		}
		
		private function popupLoad(popupDto:PopupConfDto):void
		{
			init();
			noNeedToRemove(popupDto);
		}
		
		private function init():void
		{
			_backBtn = popup["back_btn"];
			_nextBtn = popup["next_btn"];
			_xBtn = popup["x_btn"];
			_restartBtn = popup["restart_btn"];
			_title = popup["title_field"];
			_tf1 = popup["text_field_1"];
			_tf2 = popup["text_field_2"];
			_tf3 = popup["text_field_3"];
			_inputTf = popup["input_text_field"];
			_totalScoreTf = popup["total_score"];
			_levelScoreTf = popup["level_score"];
			_trueMovesTf = popup["true_moves"];
			_falseMovesTf = popup["false_moves"];
			_titleText = _title.text;
			_tf1Text = _tf1.text;
			_tf2Text = _tf2.text;
			_tf3Text = _tf3.text;
			_inputText = _inputTf.text;
			_totalScoreText = _totalScoreTf.scoreTf.scoreTf;
			_levelScoreText = _levelScoreTf.scoreTf.scoreTf;
			_trueMovesText = _trueMovesTf.movesTf.movesTf;
			_falseMovesText = _falseMovesTf.movesTf.movesTf;
		}
		private function noNeedToRemove(popupDto:PopupConfDto):void
		{
			if (popupDto.backBtnShow){
				_backBtn.addEventListener(MouseEvent.CLICK, onBackBtnClickHand);
			} else {
				popup.removeChild(_backBtn);
			}
			if (popupDto.nextBtnShow){
				_nextBtn.addEventListener(MouseEvent.CLICK, onNextBtnClickHand);
			} else {
				popup.removeChild(_nextBtn);
			}
			if (popupDto.xBtnShow){
				_xBtn.addEventListener(MouseEvent.CLICK, onXBtnClickHand);
			} else {
				popup.removeChild(_xBtn);
			}
			if (popupDto.restartBtnShow){
				_restartBtn.addEventListener(MouseEvent.CLICK, onRestartBtnClickHand);
			} else {
				popup.removeChild(_restartBtn);
			}
			if (popupDto.titleText!=null){
				_titleText.text = popupDto.titleText;
			} else {
				popup.removeChild(_title);
			}
			if (popupDto.tf1Text!=null){
				_tf1Text.text = popupDto.tf1Text;
			} else {
				popup.removeChild(_tf1);
			}
			if (popupDto.tf2Text!=null){
				_tf2Text.text = popupDto.tf2Text;
			} else {
				popup.removeChild(_tf2);
			}
			if (popupDto.tf3Text!=null){
				_tf3Text.text = popupDto.tf3Text;
			} else {
				popup.removeChild(_tf3);
			}
			if (popupDto.inputText!=null){
				_inputText.text = popupDto.inputText;
				_inputText.maxChars = 10;
				_inputTf.addEventListener(KeyboardEvent.KEY_UP, onSetTextHand);
				_inputTf.addEventListener(MouseEvent.MOUSE_DOWN, onMouseClickForText);
				_nextBtn.removeEventListener(MouseEvent.CLICK, onNextBtnClickHand);
			} else {
				popup.removeChild(_inputTf);
			}
			if (popupDto.totalScore!=0){
				_totalScoreText.text = popupDto.totalScore.toString(10);
			} else {
				popup.removeChild(_totalScoreTf);
			}
			if (popupDto.levelScore!=0){
				_levelScoreText.text = popupDto.levelScore.toString(10);
			} else {
				popup.removeChild(_levelScoreTf);
			}
			if (popupDto.trueMoves!=0){
				_trueMovesText.text = popupDto.trueMoves.toString(10);
			} else {
				popup.removeChild(_trueMovesTf);
			}
			if (popupDto.falseMoves!=-1){
				_falseMovesText.text = popupDto.falseMoves.toString(10);
			} else {
				popup.removeChild(_falseMovesTf);
			}
			if (popupDto.params!=null)
			{
				_params = popupDto.params;
			}
		}
		
		protected function onSetTextHand(event:KeyboardEvent):void
		{
			_params = _inputText.text;
			
			if(event.charCode == 13) //якщо натиснуто Enter
			{
				if (_inputText.text.length == 0)
				{
					return;
				} else {
					
					addListenersForNextBtn();
					dispatchEvent(new GameEvent(GeneralEventsConst.POPUP_ENTER_PRESSET, _params));
					_inputTf.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseClickForText);
					_inputTf.removeEventListener(KeyboardEvent.KEY_UP, onSetTextHand);
					removeListeners();
				}
			} else {
				if (_inputText.text.length == 0)
				{
					return;
				} else{
					addListenersForNextBtn();
				}
			}
		}
		
		private function addListenersForNextBtn():void
		{
			_inputTf.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseClickForText);
			_nextBtn.addEventListener(MouseEvent.CLICK, onNextBtnClickHand);
		}
		protected function onMouseClickForText(event:MouseEvent):void
		{
			_inputText.text = "";
		}
		
		
		private function removeListeners():void
		{
			_backBtn.removeEventListener(MouseEvent.CLICK, onBackBtnClickHand);
			_nextBtn.removeEventListener(MouseEvent.CLICK, onNextBtnClickHand);
			_xBtn.removeEventListener(MouseEvent.CLICK, onXBtnClickHand);
			_restartBtn.removeEventListener(MouseEvent.CLICK, onRestartBtnClickHand);
		}
		
		protected function onRestartBtnClickHand(event:MouseEvent):void
		{
			dispatchEvent(new Event(GeneralEventsConst.POPUP_RESTART_BTN_CLICK));
		}
		
		protected function onXBtnClickHand(event:MouseEvent):void
		{
			SoundLib.getInstance().btnClickSound();
			removeListeners();
			dispatchEvent(new Event(GeneralEventsConst.POPUP_X_BTN_CLICK));
		}
		
		protected function onNextBtnClickHand(event:MouseEvent):void
		{
			SoundLib.getInstance().btnClickSound();
			removeListeners();
			dispatchEvent(new GameEvent(GeneralEventsConst.POPUP_NEXT_BTN_CLICK, _params));
		}
		
		protected function onBackBtnClickHand(event:MouseEvent):void
		{
			dispatchEvent(new Event(GeneralEventsConst.POPUP_BACK_BTN_CLICK));
		}
	}
}