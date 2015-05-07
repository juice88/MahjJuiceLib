package lobby.highScore.view.components
{
	import core.view.components.ViewLogic;
	
	import flash.display.MovieClip;
	
	public class MyFriendsHighScorePanel extends ViewLogic
	{
		public function MyFriendsHighScorePanel()
		{
			super("MyFriendsHighScore");
		}
		
		public function get friendScore():MovieClip
		{
			return content as MovieClip;
		}
	}
}