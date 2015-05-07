package gamePlay.bonus.view.mediator
{
	import core.config.GeneralEventsConst;
	import core.config.GeneralNotifications;
	
	import core.view.mediator.DialogMediator;
	
	import flash.events.Event;
	
	import gamePlay.bonus.view.components.BonusPopupVL;
	
	public class BonusPopupMediator extends DialogMediator
	{
		public static const NAME:String = "BonusPopupMediator";
		
		public function BonusPopupMediator()
		{
			super(NAME, new BonusPopupVL());
		}
		private function get bonusPopupVL():BonusPopupVL
		{
			return viewLogic as BonusPopupVL;
		}
		override public function onRegisterListeners():void
		{
			bonusPopupVL.addEventListener(GeneralEventsConst.BONUS_LEVEL_START, onPopupClickNextBtn);
		}
		
		override public function onRemoveListeners():void
		{
			bonusPopupVL.removeEventListener(GeneralEventsConst.BONUS_LEVEL_START, onPopupClickNextBtn);
		}
		
		protected function onPopupClickNextBtn(event:Event):void
		{
			sendNotification(GeneralNotifications.BONUS_LEVEL_LOAD);
		}
	}
}