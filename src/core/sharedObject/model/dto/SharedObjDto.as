package core.sharedObject.model.dto
{
	import flash.net.SharedObject;

	public class SharedObjDto extends Object
	{
		public var sharedObject:SharedObject;
		public var apName:String = "Mahjjuice_game";
		public var userName:String;
		public var arrNamesScoresAndMaxComplLvl:Array;
		public var continGameConfDto:ContinGameConfDto;
		public var gameType:int=0;
		public var userDataDto:UserDataDto;
		public var userDataString:String;
	}
}