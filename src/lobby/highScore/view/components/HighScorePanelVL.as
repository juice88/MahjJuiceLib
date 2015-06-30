package lobby.highScore.view.components
{
	import core.utils.SoundLib;
	import core.view.components.ViewLogic;
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	public class HighScorePanelVL extends ViewLogic
	{
		private var _allPlayersBtn:SimpleButton;
		private var _myFriendsBtn:SimpleButton;
		private var _friendsScorePanel:MyFriendsHighScorePanel;
		private var _friendsScorePanelOnScene:Boolean;
		private var _n:String = "n";
		private var _player:String = "player";
		private var _score:String = "score";
		private var _lvl:String = "lvl";
		
		public function HighScorePanelVL()
		{
			super("HighScore");
			highScoreLoad();
		}
		
		public function get highScore():MovieClip
		{
			return content as MovieClip;
		}
		
		private function highScoreLoad():void
		{
			_friendsScorePanel = new MyFriendsHighScorePanel();
			_allPlayersBtn = highScore["allPlayersBtn"];
			_allPlayersBtn.addEventListener(MouseEvent.CLICK, onAllPlayersBtnClickHand);
			_myFriendsBtn = highScore["myFriendsBtn"];
			_myFriendsBtn.addEventListener(MouseEvent.CLICK, onMyFriendsBtnClickHand);
		}
		
		protected function onAllPlayersBtnClickHand(event:MouseEvent):void
		{
			SoundLib.getInstance().btnClickSound();
			if (_friendsScorePanelOnScene == true)
			{
				highScore.removeChild(_friendsScorePanel.friendScore);
				_friendsScorePanelOnScene = false;
			}
		}
		
		protected function onMyFriendsBtnClickHand(event:MouseEvent):void
		{
			SoundLib.getInstance().btnClickSound();
			_friendsScorePanelOnScene = true;
			highScore.addChild(_friendsScorePanel.friendScore);
		}
		
		public function highScoreBoardUpdate(arrUserData:Array, maxLvlNum:String):void
		{
			notVisibleTextOnBoard();
			for (var i:int = 0; i<arrUserData.length && i<=9; i++) // переробити, щоб знати кількість техтфілдів на контенті, вайл контен.хесЧайл(текстякисьтам_і)
			{
				var obj:Object = arrUserData[i];
				var playerName:TextField = highScore.scoreBoard[_player+(i+1)];
					playerName.text = obj.name as String;
					playerName.visible = true;
				var playerScore:TextField = highScore.scoreBoard[_score+(i+1)];
					playerScore.text = obj.score.toString();
					playerScore.visible = true;
				var lvlNum:TextField  = highScore.scoreBoard[_lvl+(i+1)];
					lvlNum.text = obj.lvl.toString()+"/"+maxLvlNum;
					lvlNum.visible = true;
				((highScore.scoreBoard[_n+(i+1)]) as TextField).visible = true;
			}
		}
		private function notVisibleTextOnBoard():void
		{
			for (var i:int = 1; i<11; i++)
			{
				((highScore.scoreBoard[_n+i]) as TextField).visible = false;
				((highScore.scoreBoard[_player+i]) as TextField).visible = false;
				((highScore.scoreBoard[_score+i]) as TextField).visible = false;
				((highScore.scoreBoard[_lvl+i]) as TextField).visible = false;
			}
		}
	}
}