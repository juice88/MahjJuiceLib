package lobby.highScore.model.proxy
{
	import core.config.GeneralNotifications;
	import core.sharedObject.model.proxy.SharedObjProxy;
	
	import lobby.highScore.model.dto.HighScoreDto;
	import lobby.highScore.model.dto.UserDto;
	
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class HighScoreProxy extends Proxy
	{
		public static const NAME:String = "HighScoreProxy";
		
		public function HighScoreProxy()
		{
			super(NAME, new HighScoreDto());
		}
		
		private function get highScoreDto():HighScoreDto
		{
			return getData() as HighScoreDto;
		}
		
		override public function onRegister():void
		{
			highScoreDto.userDtoArr = new Array();
			highScoreDto.userDto = new UserDto();
		}
		
		public function setUserName(usName:String):void
		{
			if (usName == null)
			{
				highScoreDto.userDto.userName = "undefined"; //якщо вікно введеня імені було просто зактрито, тоді замінюємо ім"я на undefined
			}
			else
			{
				highScoreDto.userDto.userName = usName;
			}
			sendNotification(GeneralNotifications.SET_NAME_LEVEL_AND_SCORE_IN_SO, highScoreDto.userDto);
		}
		
		public function setNumLevel(numLevel:int, currentGameType:String):void
		{
			highScoreDto.userDto.numLevel = numLevel;
			highScoreDto.userDto.currentGameType = parseInt(currentGameType);
		}
		
		public function setUserScore(usScore:uint):void
		{
			if (highScoreDto.userDto.userName == null)
			{
				highScoreDto.userDto.userName = "undefined"; //якщо вікно введеня імені було просто зактрито, тоді замінюємо ім"я на undefined
			}
			else
			{
				highScoreDto.userDto.userScore = usScore;
			}
			sendNotification(GeneralNotifications.SET_NAME_LEVEL_AND_SCORE_IN_SO, highScoreDto.userDto);
		}
	}
}