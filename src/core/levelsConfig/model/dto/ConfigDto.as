package core.levelsConfig.model.dto
{
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class ConfigDto extends Object
	{
		public var totalNumOfGames:int;//загальна кількість ігор
		public var gameType:int = 1; //номер поточної гри
		public var currentLvlNum:int;
		public var gameTypeArrDto:Vector.<GameLevelsDtoArrDto>;
	
		// загрузка XML файла
//		public var loader:URLLoader;
//		public var request:URLRequest;
	}
}