package core.utils
{
	import flash.display.InteractiveObject;
	import flash.display.LoaderInfo;
	

	public class Warehouse
	{
		private static var _instance:Warehouse;
		
		private var _loaderInfo:LoaderInfo;
		
		public static function getInstance():Warehouse
		{
			if (_instance==null)
			{
				_instance = new Warehouse();
			}
			return _instance;
		}
		
		public function setData(loaderInfo:LoaderInfo):void
		{
			this._loaderInfo = loaderInfo;
		}
		
		public function getAsset(name:String):InteractiveObject
		{
			if (_loaderInfo.applicationDomain.hasDefinition(name))
			{
				var AssetClass:Class = _loaderInfo.applicationDomain.getDefinition(name) as Class;
				var mc:InteractiveObject = new AssetClass();
  				return mc;
			}	
			return null;	
		}
		
		public function getAssetClass(name:String):Class
		{
			if (_loaderInfo.applicationDomain.hasDefinition(name))
			{
				var AssetClass:Class = _loaderInfo.applicationDomain.getDefinition(name) as Class;
				return AssetClass;
			}	
			return null;
		}
	}	
}