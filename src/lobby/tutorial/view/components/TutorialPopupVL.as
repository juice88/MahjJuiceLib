package lobby.tutorial.view.components
{
	import com.greensock.TweenLite;
	
	import core.config.GeneralEventsConst;
	import core.utils.SoundLib;
	import core.utils.Warehouse;
	import core.view.components.DialogViewLogic;
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.utils.setTimeout;
	
	public class TutorialPopupVL extends DialogViewLogic
	{
		private var _shablon:String = "shablon";
		private var _hide:String = "hide";
		private var _show:String = "show";
		private var _nextBtn:SimpleButton;
		private var _closeBtn:SimpleButton;
		private var _movesHistory:MovieClip;
		private var _elem:MovieClip;
		private var _mouseHand:MovieClip;
		private var _frameArr:Array;
		private var _elemArr:Array;
		private var _sequenceOfTrueMouseMoves:Array;
		private var _sequenceForOneChoiseArr:Array;
		private var _sequenceOfFalseMouseMoves:Array;
		private var _finalText:TextField;
		private var _popupIsClose:Boolean;
		
		public function TutorialPopupVL()
		{
			super("TutorialPopup");
			tutorialLoad();
		}
		
		private function get tutorialPop():MovieClip
		{
			return content as MovieClip;
		}
		private function tutorialLoad():void
		{
			_nextBtn = tutorialPop["nextBtn"];
			_nextBtn.addEventListener(MouseEvent.CLICK, onNextBtnClickHand);
			_closeBtn = tutorialPop["closeBtn"];
			_closeBtn.addEventListener(MouseEvent.CLICK, onCloseBtnClickHand);
			_movesHistory = tutorialPop["movesHistory"];
			_mouseHand = tutorialPop["mouseHand"];
			(_movesHistory.icon_2 as MovieClip).visible = false;
			(_movesHistory.icon_3 as MovieClip).visible = false;
			_finalText = tutorialPop["finalText"];
			
			positionElement();
		}
		
		protected function onNextBtnClickHand(event:MouseEvent):void
		{
			destroyPopup();
		}
		
		protected function onCloseBtnClickHand(event:MouseEvent):void
		{
			destroyPopup();
		}
		
		private function destroyPopup():void
		{
			removeBackground();
			SoundLib.getInstance().btnClickSound();
			_popupIsClose = true;
			TweenLite.killTweensOf(_mouseHand);
			_nextBtn.removeEventListener(MouseEvent.CLICK, onNextBtnClickHand);
			_closeBtn.removeEventListener(MouseEvent.CLICK, onCloseBtnClickHand);
			dispatchEvent(new Event(GeneralEventsConst.TUTORIAL_NEXT));
		}
		
		private function positionElement():void
		{
			_frameArr = new Array();
			_elemArr = new Array();
			_sequenceOfTrueMouseMoves = new Array();
			_sequenceForOneChoiseArr = new Array();
			_sequenceOfFalseMouseMoves = new Array();
			_frameArr.push(4,4,3,3,1,1); //задається послідовність кадрів
			_finalText.visible = false;
			var Elem:Class = Warehouse.getInstance().getAssetClass("ElementColors");
			var i:int=0;
			while (tutorialPop.hasOwnProperty(_shablon+i))
			{
				_elem = new Elem();
				_elem.gotoAndStop(_frameArr[i]);
				_elemArr.push(_elem);
				_sequenceOfTrueMouseMoves.push(_elem);
				_elem.back.gotoAndStop(_show);
				(tutorialPop[_shablon+i] as MovieClip).addChild(_elem);
				i++;
			}
			setTimeout(hideElements, 2000);
		}
		
		private function hideElements():void
		{
			for (var i:int=0; i<_elemArr.length; i++)
			{
				_elemArr[i].back.gotoAndStop(_hide);
			}
			_sequenceOfFalseMouseMoves.push(_sequenceOfTrueMouseMoves[1], _sequenceOfTrueMouseMoves[3])
			
			falseMouseMove(_sequenceOfFalseMouseMoves[0] as MovieClip);
		}
		
		private function falseMouseMove(elem:MovieClip):void
		{
			if (!_popupIsClose)
			{
				TweenLite.to(_mouseHand, 1, {x:elem.parent.x+50,y:elem.parent.y+50, onComplete:falseClickOnElement, onCompleteParams:[elem]});
			}
		}
		
		private function falseClickOnElement(elem:MovieClip):void
		{
			SoundLib.getInstance().playSound("SelectElemSound", 400);
			_mouseHand.gotoAndPlay(2);
			(elem.back as MovieClip).gotoAndStop(_show);
			if (_sequenceOfFalseMouseMoves[1]!=elem)
			{
				falseMouseMove(_sequenceOfFalseMouseMoves[1] as MovieClip);
				_movesHistory.icon_0.gotoAndStop(2);
				
			} else {
					var FalseBoard:Class = Warehouse.getInstance().getAssetClass("FalseBoard");
				for (var i:int=0; i<_sequenceOfFalseMouseMoves.length; i++)
				{
					var falseBoard:MovieClip = new FalseBoard();
					(_sequenceOfFalseMouseMoves[i] as MovieClip).addChild(falseBoard);
					falseBoard.gotoAndPlay(2);
				}
				_movesHistory.icon_1.gotoAndStop(3);
				SoundLib.getInstance().playSound("FalseSound");
				falseBoard.addEventListener(Event.ENTER_FRAME, onEnterFrameForFalseMoveHand);
			}
		}
		
		protected function onEnterFrameForFalseMoveHand(event:Event):void
		{
			if ((event.target as MovieClip).currentFrame == (event.target as MovieClip).totalFrames)
			{
				(event.target as MovieClip).removeEventListener(Event.ENTER_FRAME, onEnterFrameForFalseMoveHand);
				for (var i:int=0; i<_sequenceOfFalseMouseMoves.length; i++)
				{
					(_sequenceOfFalseMouseMoves[i].back as MovieClip).gotoAndStop(_hide);
				}
				_sequenceForOneChoiseArr.push(_sequenceOfTrueMouseMoves[0], _sequenceOfTrueMouseMoves[1]);
				trueMouseMove(_sequenceForOneChoiseArr[0] as MovieClip);
				_sequenceOfTrueMouseMoves.shift();
				_sequenceOfTrueMouseMoves.shift();
				_movesHistory.icon_0.gotoAndStop(1);
				_movesHistory.icon_1.gotoAndStop(1);
			}
		}
		
		private function trueMouseMove(elem:MovieClip):void
		{
			if (!_popupIsClose)
			{
				TweenLite.to(_mouseHand, 1, {x:elem.parent.x+50,y:elem.parent.y+50, onComplete:trueClickOnElement, onCompleteParams:[elem]});
			}				
		}
		
		private function trueClickOnElement(elem:MovieClip):void
		{
			SoundLib.getInstance().playSound("SelectElemSound", 400);
			_mouseHand.gotoAndPlay(2);
			(elem.back as MovieClip).gotoAndStop(_show);
			if (_sequenceForOneChoiseArr[1]!=elem)
			{
				trueMouseMove(_sequenceForOneChoiseArr[1] as MovieClip);
				_movesHistory.icon_0.gotoAndStop(2);
			} else {
				var TrueBoard:Class = Warehouse.getInstance().getAssetClass("TrueBoard");
				for (var i:int=0; i<_sequenceForOneChoiseArr.length; i++)
				{
					var trueBoard:MovieClip = new TrueBoard();
					(_sequenceForOneChoiseArr[i] as MovieClip).addChild(trueBoard);
					trueBoard.gotoAndPlay(2);
				}
				trueBoard.addEventListener(Event.ENTER_FRAME, onEnterFrameForTrueMoveHand);
				_movesHistory.icon_1.gotoAndStop(2);
				SoundLib.getInstance().playSound("TrueSound");
			}
		}
		
		protected function onEnterFrameForTrueMoveHand(event:Event):void
		{
			if ((event.target as MovieClip).currentFrame == (event.target as MovieClip).totalFrames)
			{
				(event.target as MovieClip).removeEventListener(Event.ENTER_FRAME, onEnterFrameForTrueMoveHand);
				for (var i:int=0; i<_sequenceForOneChoiseArr.length; i++)
				{
					(_sequenceForOneChoiseArr[i] as MovieClip).parent.removeChild(_sequenceForOneChoiseArr[i] as MovieClip);
				}
				_movesHistory.icon_0.gotoAndStop(1);
				_movesHistory.icon_1.gotoAndStop(1);
				_sequenceForOneChoiseArr.shift();
				_sequenceForOneChoiseArr.shift();
				_sequenceForOneChoiseArr.push(_sequenceOfTrueMouseMoves[0], _sequenceOfTrueMouseMoves[1]);
				if (_sequenceForOneChoiseArr[0]!=null) //виконується перевідка для останнього елемента
				{
					trueMouseMove(_sequenceForOneChoiseArr[0] as MovieClip);
				} else {
					showEndTextForTutorial();
				}
				_sequenceOfTrueMouseMoves.shift();
				_sequenceOfTrueMouseMoves.shift();
			}
		}
		private function showEndTextForTutorial():void
		{
			_finalText.visible = true;
			SoundLib.getInstance().playSound("WinSound");
			setTimeout(positionElement, 2000);
		}
	}
}