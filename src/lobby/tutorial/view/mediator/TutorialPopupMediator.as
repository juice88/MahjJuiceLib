package lobby.tutorial.view.mediator
{
	import core.config.GeneralEventsConst;
	import core.config.GeneralNotifications;
	import core.view.mediator.DialogMediator;
	
	import flash.events.Event;
	
	import lobby.tutorial.view.components.TutorialPopupVL;
	
	public class TutorialPopupMediator extends DialogMediator
	{
		public static const NAME:String = "TutorialPopupMediator";
		
		public function TutorialPopupMediator()
		{
			super(NAME, new TutorialPopupVL());
		}
		
		private function get tutorialPop():TutorialPopupVL
		{
			return viewLogic as TutorialPopupVL;
		}
		
		override public function onRegisterListeners():void
		{
			tutorialPop.addEventListener(GeneralEventsConst.TUTORIAL_CLOSE, onTutorialCloseHand);
			tutorialPop.addEventListener(GeneralEventsConst.TUTORIAL_NEXT, onTutorialNextHand);
		}
		
		override public function onRemoveListeners():void
		{
			tutorialPop.removeEventListener(GeneralEventsConst.TUTORIAL_CLOSE, onTutorialCloseHand);
			tutorialPop.addEventListener(GeneralEventsConst.TUTORIAL_NEXT, onTutorialNextHand);
		}
		
		protected function onTutorialNextHand(event:Event):void
		{
			sendNotification(GeneralNotifications.REMOVE_POPUP, NAME);
		}
		
		protected function onTutorialCloseHand(event:Event):void
		{
			sendNotification(GeneralNotifications.REMOVE_POPUP, NAME);
		}
	}
}