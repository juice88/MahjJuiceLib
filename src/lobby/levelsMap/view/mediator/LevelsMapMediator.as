package lobby.levelsMap.view.mediator
{
	import core.config.GameEvent;
	import core.config.GeneralEventsConst;
	import core.config.GeneralNotifications;
	import core.view.mediator.UIMediator;
	
	import flash.events.Event;
	
	import lobby.levelsMap.view.components.LevelsMapVL;
	
	public class LevelsMapMediator extends UIMediator
	{
		public static const NAME:String = "LevelsMapMediator";
		public function LevelsMapMediator(btnNum:int, lvlNum:int, lvlMaxNum:int)
		{
			super(NAME, new LevelsMapVL(btnNum, lvlNum, lvlMaxNum));
		}
		private function get levelsMapVL():LevelsMapVL
		{
			return viewLogic as LevelsMapVL;
		}
		
		override public function onRegisterListeners():void
		{
			levelsMapVL.addEventListener(GeneralEventsConst.LEVELS_MAP_CLOSE, onLevelsMapCloseHand);
			levelsMapVL.addEventListener(GeneralEventsConst.LEVELS_MAP_CHOISE, onLevelsMapChoiseHand);
		}
		
		
		override public function onRemoveListeners():void
		{
			levelsMapVL.removeEventListener(GeneralEventsConst.LEVELS_MAP_CLOSE, onLevelsMapCloseHand);
			levelsMapVL.removeEventListener(GeneralEventsConst.LEVELS_MAP_CHOISE, onLevelsMapChoiseHand);
		}
		
		protected function onLevelsMapCloseHand(event:Event):void
		{
			sendNotification(GeneralNotifications.LEVELS_MAP_CLOSE);
		}
		
		protected function onLevelsMapChoiseHand(event:GameEvent):void
		{
			sendNotification(GeneralNotifications.LEVELS_MAP_CHOISE, event.params);
		}
	}
}