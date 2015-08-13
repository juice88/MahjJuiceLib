package lobby.preloader.view.mediator
{
	import core.config.GeneralNotifications;
	
	import lobby.preloader.view.components.PreloaderVL;
	
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class PreloaderMediator extends Mediator
	{
		public static const NAME:String = "PreloaderMediator";
		private var _viewLogic:PreloaderVL;
		
		public function PreloaderMediator()
		{
			_viewLogic= new PreloaderVL();
			super(NAME, _viewLogic);
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			sendNotification(GeneralNotifications.ADD_CHILD_TO_ROOT, (viewComponent as PreloaderVL).loading, "upper");
		}
		
		override public function onRemove():void
		{
			_viewLogic.destroy();
			super.onRemove();
		}
	}
}