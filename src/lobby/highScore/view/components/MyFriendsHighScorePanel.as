package lobby.highScore.view.components
{
	import core.view.components.DialogViewLogic;
	
	import flash.display.MovieClip;
	
	public class MyFriendsHighScorePanel extends DialogViewLogic
	{
		public function MyFriendsHighScorePanel()
		{
			super("ScoreBoard");
		}
		
		public function get friendScore():MovieClip
		{
			return content as MovieClip;
		}
	}
}