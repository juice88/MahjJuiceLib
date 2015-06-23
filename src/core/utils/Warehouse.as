package core.utils
{
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.display.LoaderInfo;
	

	public class Warehouse
	{
		private static var _instance:Warehouse;
		
		private var _loaderInfo:LoaderInfo;
		private var _content:Array = new Array();
		
		public static function getInstance():Warehouse
		{
			if (_instance==null)
			{
				_instance = new Warehouse();
			}
			return _instance;
		}
		
		public function setData(content:DisplayObjectContainer):void
		{
			_content.push(content);
		}
		
		public function getAsset(name:String):InteractiveObject
		{
			for each (var item:DisplayObjectContainer in _content){
				if (item.loaderInfo.applicationDomain.hasDefinition(name)){
					var AssetClass:Class = item.loaderInfo.applicationDomain.getDefinition(name) as Class;
					var mc:InteractiveObject = new AssetClass() as InteractiveObject;
					return mc;
				}
			}
			return null;	
		}
		
		public function getAssetClass(name:String):Class
		{
			for each (var item:DisplayObjectContainer in _content){
				if (item.loaderInfo.applicationDomain.hasDefinition(name)){
					var AssetClass:Class = item.loaderInfo.applicationDomain.getDefinition(name) as Class;
					return AssetClass;
				}
			}
			return null;	
		}
	}	
}