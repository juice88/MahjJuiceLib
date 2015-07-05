package lobby.tutorial.view.components
{
	import com.greensock.TweenLite;
	
	import core.config.GeneralEventsConst;
	import core.utils.Warehouse;
	import core.view.components.DialogViewLogic;
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
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
		private var _sequenceOfFalseMouseMoves:Array;
		
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
			_frameArr = new Array();
			_elemArr = new Array();
			_sequenceOfTrueMouseMoves = new Array();
			_sequenceOfFalseMouseMoves = new Array();
			_frameArr.push(4,4,3,3,1,1);
			_nextBtn = tutorialPop["nextBtn"];
			_nextBtn.addEventListener(MouseEvent.CLICK, onNextBtnClickHand);
			_closeBtn = tutorialPop["closeBtn"];
			_closeBtn.addEventListener(MouseEvent.CLICK, onCloseBtnClickHand);
			_movesHistory = tutorialPop["movesHistory"];
			_mouseHand = tutorialPop["mouseHand"];
			(_movesHistory.icon_2 as MovieClip).visible = false;
			(_movesHistory.icon_3 as MovieClip).visible = false;
			positionElement();
		}
		
		protected function onNextBtnClickHand(event:MouseEvent):void
		{
			_nextBtn.removeEventListener(MouseEvent.CLICK, onNextBtnClickHand);
			_closeBtn.removeEventListener(MouseEvent.CLICK, onCloseBtnClickHand);
			dispatchEvent(new Event(GeneralEventsConst.TUTORIAL_NEXT));
		}
		
		protected function onCloseBtnClickHand(event:MouseEvent):void
		{
			_nextBtn.removeEventListener(MouseEvent.CLICK, onNextBtnClickHand);
			_closeBtn.removeEventListener(MouseEvent.CLICK, onCloseBtnClickHand);
			dispatchEvent(new Event(GeneralEventsConst.TUTORIAL_CLOSE));
		}
		
		private function positionElement():void
		{
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
			setTimeout(hideElements, 1500);
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
			TweenLite.to(_mouseHand, 1, {x:elem.parent.x+50,y:elem.parent.y+50, onComplete:falseClickOnElement, onCompleteParams:[elem]});
		}
		
		private function falseClickOnElement(elem:MovieClip):void
		{
			_mouseHand.gotoAndPlay(2);
			(elem.back as MovieClip).gotoAndStop(_show);
			if (_sequenceOfFalseMouseMoves[1]!=elem)
			{
				falseMouseMove(_sequenceOfFalseMouseMoves[1] as MovieClip);
			} else {
					var FalseBoard:Class = Warehouse.getInstance().getAssetClass("FalseBoard");
				for (var i:int=0; i<_sequenceOfFalseMouseMoves.length; i++)
				{
					var falseBoard:MovieClip = new FalseBoard();
					(_sequenceOfFalseMouseMoves[i] as MovieClip).addChild(falseBoard);
					falseBoard.gotoAndPlay(2);
				}
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
				trueMouseMove(_sequenceOfTrueMouseMoves[0] as MovieClip);
			}
		}
		
		private function trueMouseMove(elem:MovieClip):void
		{
			TweenLite.to(_mouseHand, 1, {x:elem.parent.x+50,y:elem.parent.y+50, onComplete:trueClickOnElement, onCompleteParams:[elem]});
		}
		
		private function trueClickOnElement(elem:MovieClip):void
		{
			_mouseHand.gotoAndPlay(2);
			(elem.back as MovieClip).gotoAndStop(_show);
			if (_sequenceOfTrueMouseMoves.length!=0)
			{
				trueMouseMove(_sequenceOfTrueMouseMoves[1] as MovieClip);
				_sequenceOfTrueMouseMoves.shift();
			//	_sequenceOfTrueMouseMoves.shift();
			}
		}
	}
}