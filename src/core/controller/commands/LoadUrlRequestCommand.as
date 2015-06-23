package core.controller.commands
{
	import br.com.stimuli.loading.BulkLoader;
	
	import core.config.GeneralNotifications;
	import core.levelsConfig.model.proxy.LevelsGameConfigProxy;
	import core.utils.Warehouse;
	
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.text.TextField;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class LoadUrlRequestCommand extends SimpleCommand
	{
		private var _loader:BulkLoader;
		private var _assetsPath:String;
		private var _mainConfigXML:XML;
		
		override public function execute(notification:INotification):void
		{
			_loader = new BulkLoader();
			var mainConfigPath:String = notification.getType();
			_assetsPath = notification.getBody() as String;
			_loader.add(mainConfigPath, {id:"mainConfig"});
			_loader.addEventListener(BulkLoader.COMPLETE, onMainConfigLoaded);
			_loader.addEventListener(BulkLoader.ERROR, onError);
			_loader.start();
		}
		
		protected function onMainConfigLoaded(event:Event):void
		{
			_loader.removeEventListener(BulkLoader.COMPLETE, onMainConfigLoaded);
			_mainConfigXML=_loader.getContent("mainConfig") as XML;
			for (var i:int=0; i<_mainConfigXML.conf.length(); i++){
				var asset_type:String=_mainConfigXML.conf[i].@TYPE;
				var asset_title:String=_mainConfigXML.conf[i].@TITLE;
				_loader.add(_assetsPath+_mainConfigXML.conf[i].@URL, {id:asset_title}); 
			}
			_loader.addEventListener(BulkLoader.COMPLETE, onLoaderParseComplete);
			_loader.addEventListener(BulkLoader.ERROR, onError);
		}
		
		protected function onLoaderParseComplete(event:Event):void{
			_loader.removeEventListener(BulkLoader.COMPLETE, onLoaderParseComplete);
			for (var i:int=0; i<_mainConfigXML.conf.length();i++){
				var asset_type:String=_mainConfigXML.conf[i].@TYPE;
				var asset_title:String=_mainConfigXML.conf[i].@TITLE;
				switch (asset_type){
					case "MovieClip":
						Warehouse.getInstance().setData(_loader.getContent(asset_title));
						break;
					case "Sounds":
						Warehouse.getInstance().setData(_loader.getContent(asset_title));
						break;
					case "XML":
						facade.registerProxy(new LevelsGameConfigProxy(_loader.getContent("LevelsConfigFile")));
						break;
				}
			}
			sendNotification(GeneralNotifications.LOAD_MAIN_CONTENT);
		}
		
		protected function onError(event:Event):void
		{
			_loader.removeEventListener(BulkLoader.ERROR, onError);
			var text_field:TextField=new TextField;
			text_field.text="error in loading files...";
			sendNotification(GeneralNotifications.ADD_CHILD_TO_ROOT, text_field);
		}
	}
}

//public class LoadMainContentCommand extends SimpleCommand{
//	
//	private var _loader:BulkLoader;
//	private var _assetsPath:String;
//	private var _mainConfigXML:XML;
//	
//	override public function execute(notification:INotification):void{
//		_loader= new BulkLoader;
//		_assetsPath=notification.getBody() as String;
//		var _mainConfigPath:String=notification.getType();
//		
//		_loader.add(_mainConfigPath, {id:"mainConfig"});
//		
//		_loader.addEventListener(BulkLoader.COMPLETE, onMainConfigLoaded);
//		_loader.addEventListener(BulkLoader.ERROR, onError);
//		
//		_loader.start();
//	}
//	public function onMainConfigLoaded(event:Event):void{
//		_loader.removeEventListener(BulkLoader.COMPLETE, onMainConfigLoaded);
//		_mainConfigXML=_loader.getContent("mainConfig") as XML;
//		for (var i:int=0; i<_mainConfigXML.conf.length(); i++){
//			var asset_type:String=_mainConfigXML.conf[i].@TYPE;
//			var asset_title:String=_mainConfigXML.conf[i].@TITLE;
//			_loader.add(_assetsPath+_mainConfigXML.conf[i].@URL, {id:asset_title}); 
//		}
//		_loader.addEventListener(BulkLoader.COMPLETE, onLoaderParseComplete);
//		_loader.addEventListener(BulkLoader.ERROR, onError);
//	}
//	public function onLoaderParseComplete(event:Event):void{
//		_loader.removeEventListener(BulkLoader.COMPLETE, onLoaderParseComplete);
//		for (var i:int=0; i<_mainConfigXML.conf.length();i++){
//			var asset_type:String=_mainConfigXML.conf[i].@TYPE;
//			var asset_title:String=_mainConfigXML.conf[i].@TITLE;
//			switch (asset_type){
//				case "MovieClip":
//					Werehouse.getInstance().setAsset(asset_title, _loader.getContent(asset_title));
//					break;
//				case "Sounds":
//					SoundsWerehouse.getInstance().setAsset(asset_title, _loader.getContent(asset_title));
//					break;
//				case "XML":
//					facade.registerProxy(new GamesConfigProxy(_loader.getContent("GamesConfig")));
//					break;
//			}
//		}
//		sendNotification(GeneralNotifications.MAIN_CONTENT_LOADED);
//	}
//	
//	public function onError(event:Event):void{
//		_loader.removeEventListener(BulkLoader.ERROR, onError);
//		var text_field:TextField=new TextField;
//		text_field.text="error in loading files...";
//		sendNotification(GeneralNotifications.ADD_CHILD_TO_ROOT, text_field);
//	}
