package gamePlay.bonus.view.mediator
{
	import core.config.GameEvent;
	import core.config.GeneralEventsConst;
	import core.config.GeneralNotifications;
	
	import core.view.mediator.UIMediator;
	
	import flash.events.Event;
	import flash.utils.setTimeout;
	
	import gamePlay.bonus.model.dto.ElemBonusDto;
	import gamePlay.bonus.view.components.BonusViewLogic;
	
	import org.puremvc.as3.interfaces.INotification;

	public class BonusMediator extends UIMediator
	{
		public static const NAME:String = "BonusMediator";
		
		public function BonusMediator()
		{
			super(NAME, new BonusViewLogic());
		}
		
		private function get bonusVL():BonusViewLogic
		{
			return viewLogic as BonusViewLogic;
		}
		
		override public function listNotificationInterests():Array
		{
			return [GeneralNotifications.BONUS_READE_TO_DRAW];
		}
		override public function handleNotification(notification:INotification):void
		{
			switch (notification.getName())
			{
				case GeneralNotifications.BONUS_READE_TO_DRAW:
					bonusVL.startBonusLevel(notification.getBody() as Vector.<ElemBonusDto>);
					break;
			}
		}
		override public function onRegisterListeners():void
		{
			bonusVL.addEventListener(GeneralEventsConst.BONUS_RESULT_OF_CHOISE, onResultOfChoiseBonusHand);
		}
		
		override public function onRemoveListeners():void
		{
			bonusVL.removeEventListener(GeneralEventsConst.BONUS_RESULT_OF_CHOISE, onResultOfChoiseBonusHand);
		}
		
		protected function onResultOfChoiseBonusHand(event:GameEvent):void
		{
			setTimeout(sendNotification, 2000, GeneralNotifications.BONUS_RESULT_OF_CHOISE, event.params);
		}
		
	}
}