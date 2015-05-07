package core.view.mediator
{
	import core.config.GeneralNotifications;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class RootMediator extends Mediator
	{
		public static const NAME:String = "RootMediator";
		private var _upperLayer:Sprite;
		private var _lowerLayer:Sprite;
		
		public function RootMediator(rootSprite:Sprite)
		{
			super(NAME, rootSprite);
		}
		override public function onRegister():void
		{
			_upperLayer = new Sprite;
			_lowerLayer = new Sprite;
			(viewComponent as Sprite).addChild(_lowerLayer);
			(viewComponent as Sprite).addChild(_upperLayer);
		}
		
		override public function listNotificationInterests():Array{
			return [GeneralNotifications.ADD_CHILD_TO_ROOT, 
					GeneralNotifications.REMOVE_CHILD_FROM_ROOT,
					GeneralNotifications.FULL_SCREEN];
		}
		
		override public function handleNotification(notification:INotification):void{
			var displayObject:DisplayObject = notification.getBody() as DisplayObject;
			switch(notification.getName()){
				case GeneralNotifications.ADD_CHILD_TO_ROOT:
					if (notification.getType() != null)
					{
						if (notification.getType() == "upper")
						{
							_upperLayer.addChild(displayObject);
						}
						else if (notification.getType() == "lower")
						{
							_lowerLayer.addChild(displayObject);
						}
					}
 					//(viewComponent as Sprite).addChild(displayObject);
					break;
				case GeneralNotifications.REMOVE_CHILD_FROM_ROOT:
					if (notification.getType() != null)
					{
						if (notification.getType() == "upper")
						{
							_upperLayer.removeChild(displayObject);
						}
						else if (notification.getType() == "lower")
						{
							_lowerLayer.removeChild(displayObject);
						}
					}
					//(viewComponent as Sprite).removeChild(displayObject);
					break;
				case GeneralNotifications.FULL_SCREEN:
					fullScreen();
					break;
			}
		}
		
		private function fullScreen():void
		{
			if ((viewComponent as Sprite).stage.displayState == StageDisplayState.NORMAL)
			{
				(viewComponent as Sprite).stage.displayState = StageDisplayState.FULL_SCREEN;
			}
			else
			{
				(viewComponent as Sprite).stage.displayState = StageDisplayState.NORMAL;
			}
		}
	}
}