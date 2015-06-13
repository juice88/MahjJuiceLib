package core.view.mediator
{
	import core.config.GeneralNotifications;
	import core.view.components.DialogViewLogic;
	
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class DialogMediator extends Mediator
	{
		public var layer:String = "upper";
		
		
		public function DialogMediator(mediatorName:String=null, viewComponent:Object=null)
		{
			super(mediatorName, viewComponent);
		}
		
		override public function onRegister():void{
		
			sendNotification(GeneralNotifications.ADD_CHILD_TO_ROOT, viewLogic.allContent, layer);
			onRegisterListeners();
		}
		
		override public function onRemove():void{
			sendNotification(GeneralNotifications.REMOVE_CHILD_FROM_ROOT, viewLogic.allContent, layer);
			sendNotification(GeneralNotifications.DIALOG_CLOSE);
			onRemoveListeners();
		}
		
		protected function get viewLogic():DialogViewLogic
		{
			return viewComponent as DialogViewLogic;
		}
		
		public function onRegisterListeners():void
		{
			
		}
		
		public function onRemoveListeners():void
		{
			
		}
	}
}