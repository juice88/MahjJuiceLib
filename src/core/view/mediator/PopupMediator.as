package core.view.mediator
{
	import core.config.GameEvent;
	import core.config.GeneralEventsConst;
	import core.config.GeneralNotifications;
	import core.model.dto.PopupConfDto;
	import core.view.components.PopupVievLogic;
	
	import flash.events.Event;
	
	import org.puremvc.as3.patterns.mediator.Mediator;

	public class PopupMediator extends DialogMediator
	{
		public static const NAME:String = "PopupMediator";
		private var _name:String;
		private var _notifNextBtn:String;
		private var _notifBackBtn:String;
		private var _notifXBtn:String;
		private var _notifRestartBtn:String;
		
		public function PopupMediator(name:String, popupDto:PopupConfDto, notifNextBtn:String, notifBackBtn:String = null, notifXBtn:String = null, notifRestartBtn:String = null)
		{
			super(name, new PopupVievLogic(popupDto));
			_name = name;
			_notifNextBtn = notifNextBtn;
			_notifBackBtn = notifBackBtn;
			_notifXBtn = notifXBtn;
			_notifRestartBtn = notifRestartBtn;
		}
		
		protected function get popupVL():PopupVievLogic
		{
			return viewComponent as PopupVievLogic;
		}
		
		override public function onRegisterListeners():void
		{
			popupVL.addEventListener(GeneralEventsConst.POPUP_BACK_BTN_CLICK, onBackBtnClickHand);
			popupVL.addEventListener(GeneralEventsConst.POPUP_NEXT_BTN_CLICK, onNextBtnClickHand);
			popupVL.addEventListener(GeneralEventsConst.POPUP_RESTART_BTN_CLICK, onRestartBtnClickHand);
			popupVL.addEventListener(GeneralEventsConst.POPUP_X_BTN_CLICK, onXBtnClickHand);
			popupVL.addEventListener(GeneralEventsConst.POPUP_ENTER_PRESSET, onEnterPressetHand);
		}
		
		override public function onRemoveListeners():void
		{
			popupVL.removeEventListener(GeneralEventsConst.POPUP_BACK_BTN_CLICK, onBackBtnClickHand);
			popupVL.removeEventListener(GeneralEventsConst.POPUP_NEXT_BTN_CLICK, onNextBtnClickHand);
			popupVL.removeEventListener(GeneralEventsConst.POPUP_RESTART_BTN_CLICK, onRestartBtnClickHand);
			popupVL.removeEventListener(GeneralEventsConst.POPUP_X_BTN_CLICK, onXBtnClickHand);
			popupVL.removeEventListener(GeneralEventsConst.POPUP_ENTER_PRESSET, onEnterPressetHand);
		}
		
		protected function onBackBtnClickHand(event:Event):void
		{
			sendNotification(GeneralNotifications.REMOVE_DIALOG, _name);
			sendNotification(_notifBackBtn);
		}
		
		protected function onNextBtnClickHand(event:GameEvent):void
		{
			sendNotification(GeneralNotifications.REMOVE_DIALOG, _name);
			sendNotification(_notifNextBtn, event.params);
		}
		
		protected function onRestartBtnClickHand(event:Event):void
		{
			sendNotification(GeneralNotifications.REMOVE_DIALOG, _name);
			sendNotification(_notifRestartBtn);
		}
		
		protected function onXBtnClickHand(event:Event):void
		{
			sendNotification(GeneralNotifications.REMOVE_DIALOG, _name);
			sendNotification(_notifXBtn);
		}
		protected function onEnterPressetHand(event:GameEvent):void
		{
			sendNotification(_notifNextBtn, event.params);			
		}
		
	}
}