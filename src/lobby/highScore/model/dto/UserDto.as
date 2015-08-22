package lobby.highScore.model.dto
{
	public class UserDto extends Object
	{
		public var userName:String;
		public var userScore:int;
		public var numLevel:int; //левел, який гравець ще не пройшов
		public var currentGameType:int;
	}
}