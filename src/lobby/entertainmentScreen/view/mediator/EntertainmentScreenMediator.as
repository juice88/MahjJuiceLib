package lobby.entertainmentScreen.view.mediator
{
	import core.config.GeneralNotifications;
	import core.view.mediator.UIMediator;
	
	import flash.utils.setTimeout;
	
	import lobby.entertainmentScreen.view.components.EntertainmentScreenVL;
	
	public class EntertainmentScreenMediator extends UIMediator
	{
		public static const NAME:String = "EntertainmentScreenMediator";
		
		public function EntertainmentScreenMediator()
		{
			super(NAME, new EntertainmentScreenVL());
		}
		
		private function get entScreen():EntertainmentScreenVL
		{
			return viewLogic as EntertainmentScreenVL;
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			setTimeout(removeEntScreen, 8000);
		}
		
		private function removeEntScreen():void
		{
			sendNotification(GeneralNotifications.LOAD_MAIN_CONTENT);
			facade.removeMediator(EntertainmentScreenMediator.NAME);
		}
	}
}