package lobby.levelsMap.view.mediator
{
	import core.config.GameEvent;
	import core.config.GeneralEventsConst;
	import core.config.GeneralNotifications;
	import core.view.mediator.DialogMediator;
	
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import lobby.levelsMap.view.components.LevelsCategoryPopupVL;
	
	public class LevelsCategoryPopupMediator extends DialogMediator
	{
		public static const NAME:String = "LevelsCategoryPopupMediator";
		
		public function LevelsCategoryPopupMediator()
		{
			super(NAME, new LevelsCategoryPopupVL);
		}
		
		private function get levelsCategory():LevelsCategoryPopupVL
		{
			return viewLogic as LevelsCategoryPopupVL;
		}
		
		override public function onRegisterListeners():void
		{
			levelsCategory.addEventListener(GeneralEventsConst.LEVELS_CATEGORY_POPUP_CLOSE, onCloseEnterNamePopupHand);
			levelsCategory.addEventListener(GeneralEventsConst.LEVELS_MAP_SHOW, onLevelsMapShowHand);
		}
		
		override public function onRemoveListeners():void
		{
			levelsCategory.removeEventListener(GeneralEventsConst.LEVELS_CATEGORY_POPUP_CLOSE, onCloseEnterNamePopupHand);
			levelsCategory.removeEventListener(GeneralEventsConst.LEVELS_MAP_SHOW, onLevelsMapShowHand);
		}
		
		protected function onCloseEnterNamePopupHand(event:Event):void
		{
			sendNotification(GeneralNotifications.REMOVE_POPUP, NAME);
		}
		
		protected function onLevelsMapShowHand(event:GameEvent):void
		{
			sendNotification(GeneralNotifications.LEVELS_MAP_SHOW, event.params as String);
		}
		
	}
}