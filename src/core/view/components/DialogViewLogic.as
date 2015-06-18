package core.view.components
{
	import core.config.GeneralEventsConst;
	import core.config.Settings;
	import core.utils.Warehouse;
	
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class DialogViewLogic extends EventDispatcher
	{
		protected var displayObject:DisplayObject;
		private var _background:Sprite;
		public var allContent:Sprite;
		
		public function DialogViewLogic(name:String)
		{
			allContent = new Sprite();
			this.displayObject = Warehouse.getInstance().getAsset(name);
			addBackground();
			allContent.addChild(_background);
			allContent.addChild(content);
		}
		
		public function get content():DisplayObject{
			return displayObject;
		}
		
		private function addBackground():void
		{
			_background = new Sprite();
			var graf:Graphics = _background.graphics;
			graf.beginFill(0x150000, 0.5);
			graf.drawRect(0,0,Settings.BACKGROUND_RECT_WIDTH,Settings.BACKGROUND_RECT_HEIGHT);
			graf.endFill();
		}
		
		public function removeBackground():void
		{
			allContent.removeChild(_background);
		}
		
	}
}