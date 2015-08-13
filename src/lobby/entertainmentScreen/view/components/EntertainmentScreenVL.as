package lobby.entertainmentScreen.view.components
{
	import core.view.components.ViewLogic;
	
	import flash.display.MovieClip;
	
	public class EntertainmentScreenVL extends ViewLogic
	{
		public function EntertainmentScreenVL()
		{
			super("EntertainmantScreen");
		}
		
		public function get entScreen():MovieClip
		{
			return content as MovieClip;
		}
	}
}