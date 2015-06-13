package core.view.mediator
{
	import core.config.GeneralNotifications;
	import core.view.components.DialogViewLogic;
	import core.view.components.ModalModeViewLogic;
	
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class DialogMediator extends Mediator
	{
		public var layer:String = "upper";
	//	private var _modalModeVL:ModalModeViewLogic;
		
		public function DialogMediator(mediatorName:String=null, viewComponent:Object=null)
		{
			super(mediatorName, viewComponent);
		}
		
		override public function onRegister():void{
		//	_modalModeVL = new ModalModeViewLogic();
		//	sendNotification(GeneralNotifications.ADD_CHILD_TO_ROOT, _modalModeVL, layer);
			sendNotification(GeneralNotifications.ADD_CHILD_TO_ROOT, viewLogic.content, layer);
			onRegisterListeners();
		}
		
		override public function onRemove():void{
			sendNotification(GeneralNotifications.REMOVE_CHILD_FROM_ROOT, viewLogic.content, layer);
			sendNotification(GeneralNotifications.DIALOG_CLOSE);
		//	sendNotification(GeneralNotifications.REMOVE_CHILD_FROM_ROOT, _modalModeVL, layer);
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