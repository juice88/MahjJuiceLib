package core.popups.view.mediator
{
	import core.config.GameEvent;
	import core.config.GeneralEventsConst;
	import core.config.GeneralNotifications;
	import core.popups.model.dto.PopupConfDto;
	import core.popups.view.component.PopupVievLogic;
	
	import flash.events.Event;
	
	import org.puremvc.as3.patterns.mediator.Mediator;
	import core.view.mediator.DialogMediator;

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
			popupVL.addEventListener(GeneralEventsConst.POPUP_REMOVE_DIALOG, onRemoveDialog);
		}
		
		override public function onRemoveListeners():void
		{
			popupVL.removeEventListener(GeneralEventsConst.POPUP_BACK_BTN_CLICK, onBackBtnClickHand);
			popupVL.removeEventListener(GeneralEventsConst.POPUP_NEXT_BTN_CLICK, onNextBtnClickHand);
			popupVL.removeEventListener(GeneralEventsConst.POPUP_RESTART_BTN_CLICK, onRestartBtnClickHand);
			popupVL.removeEventListener(GeneralEventsConst.POPUP_X_BTN_CLICK, onXBtnClickHand);
			popupVL.removeEventListener(GeneralEventsConst.POPUP_ENTER_PRESSET, onEnterPressetHand);
			popupVL.removeEventListener(GeneralEventsConst.POPUP_REMOVE_DIALOG, onRemoveDialog);
		}
		
		protected function onBackBtnClickHand(event:Event):void
		{
			popupVL.removePopupTween();
			sendNotification(_notifBackBtn);
		}
		
		protected function onNextBtnClickHand(event:GameEvent):void
		{
			popupVL.removePopupTween();
			sendNotification(_notifNextBtn, event.params);
		}
		
		protected function onRestartBtnClickHand(event:Event):void
		{
			popupVL.removePopupTween();
			sendNotification(_notifRestartBtn);
		}
		
		protected function onXBtnClickHand(event:Event):void
		{
			popupVL.removePopupTween();
			sendNotification(_notifXBtn);
		}
		protected function onEnterPressetHand(event:GameEvent):void
		{
			popupVL.removePopupTween();
			sendNotification(_notifNextBtn, event.params);			
		}
		
		protected function onRemoveDialog(event:Event):void
		{
			sendNotification(GeneralNotifications.REMOVE_POPUP, _name);
		}
	}
}