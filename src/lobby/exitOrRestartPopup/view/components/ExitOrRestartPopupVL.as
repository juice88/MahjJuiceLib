package lobby.exitOrRestartPopup.view.components
{
	import core.view.components.DialogViewLogic;
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	
	public class ExitOrRestartPopupVL extends DialogViewLogic
	{
		private var _closeBtn:SimpleButton;
		private var _continueBtn:SimpleButton;
		
		public function ExitOrRestartPopupVL()
		{
			super("ExitOrRestartPopup");
			onExitPopLoad();
		}
		
		private function get exitPop():MovieClip
		{
			return content as MovieClip;
		}
		
		private function onExitPopLoad():void
		{
			_closeBtn = exitPop["closeBtn"];
			_continueBtn = exitPop["continueBtn"];
			_closeBtn.addEventListener(MouseEvent.CLICK, onCloseBtnClickHand);
			_continueBtn.addEventListener(MouseEvent.CLICK, onContinueBtnClickHand);
		}
		
		protected function onCloseBtnClickHand(event:MouseEvent):void
		{
			
		}
		
		protected function onContinueBtnClickHand(event:MouseEvent):void
		{
			
		}
	}
}