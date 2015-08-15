package lobby.preloader.view.components
{
	import core.utils.PreloaderComponent;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	public class PreloaderVL extends Sprite
	{
		public var loading:DisplayObjectContainer;
		private var _scene:Sprite=new Sprite;
		
		public function PreloaderVL()
		{
			super();
			loading = new PreloaderComponent(_scene, 640, 360, 200, 25, 100, 10, 0xFFF000, 1) as DisplayObjectContainer;
		}
		public function destroy():void{
			(loading as PreloaderComponent).destroy();
		}
	}
}