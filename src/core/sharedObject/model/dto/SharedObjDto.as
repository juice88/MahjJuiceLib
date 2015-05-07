package core.sharedObject.model.dto
{
	import flash.net.SharedObject;

	public class SharedObjDto extends Object
	{
		public var sharedObject:SharedObject;
		public var apName:String = "Mahjjuice_game";
		public var userName:String;
		public var arrNamesAndScores:Array;
		public var continGameConfDto:ContinGameConfDto;
	}
}