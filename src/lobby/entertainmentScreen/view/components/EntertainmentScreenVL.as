package lobby.entertainmentScreen.view.components
{
	import core.utils.SoundLib;
	import core.view.components.ViewLogic;
	
	import flash.display.MovieClip;
	
	public class EntertainmentScreenVL extends ViewLogic
	{
		public function EntertainmentScreenVL()
		{
			super("EntertainmantScreen");
			SoundLib.getInstance().playSound("EntertainmentSound", 0, 1, 1);
		}
		
		public function get entScreen():MovieClip
		{
			return content as MovieClip;
		}
	}
}