package core.view.components
{
	import core.config.Settings;
	
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class ModalModeViewLogic extends EventDispatcher
	{
		protected var displayObject:DisplayObject;
		
		private var _background:Sprite;
		
		public function ModalModeViewLogic()
		{
			addBackground();
			(content as Sprite).addChild(_background);
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
	}
}