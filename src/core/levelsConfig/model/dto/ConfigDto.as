package core.levelsConfig.model.dto
{
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class ConfigDto extends Object
	{
		public var levelNum:int;
		public var levelConfigList:Vector.<LevelConfigDto>;
		
		// загрузка XML файла
//		public var loader:URLLoader;
//		public var request:URLRequest;
	}
}