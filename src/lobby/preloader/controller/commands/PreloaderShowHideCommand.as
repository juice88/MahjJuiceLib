package lobby.preloader.controller.commands
{
	import lobby.preloader.view.mediator.PreloaderMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class PreloaderShowHideCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			var is_need_showed:Boolean= notification.getBody()!=null ? notification.getBody() as Boolean : true;
			switch (is_need_showed){
				case true:
					facade.registerMediator(new PreloaderMediator());
					break;
				case false:
					facade.removeMediator(PreloaderMediator.NAME);
					break;
			}
		}	
	}
}