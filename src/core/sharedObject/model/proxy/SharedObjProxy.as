package core.sharedObject.model.proxy
{
	import core.config.GeneralNotifications;
	import core.sharedObject.model.dto.ContinGameConfDto;
	import core.sharedObject.model.dto.SharedObjDto;
	
	import flash.display.MovieClip;
	import flash.net.SharedObject;
	
	import lobby.highScore.model.dto.UserDto;
	
	import org.puremvc.as3.patterns.proxy.Proxy;

	public class SharedObjProxy extends Proxy
	{
		public static const NAME:String = "SharedObjProxy";
		
		public function SharedObjProxy()
		{
			super(NAME, new SharedObjDto());
		}
		
		private function get sharedDto():SharedObjDto
		{
			return getData() as SharedObjDto;
		}
		
		override public function onRegister():void
		{
			sharedDto.continGameConfDto = new ContinGameConfDto();
		}
		
		public function setUserNameLevelEndScore(usDto:UserDto):void
		{
			sharedDto.continGameConfDto.userName = usDto.userName;
			sharedDto.userName = usDto.userName;
			sharedDto.sharedObject = SharedObject.getLocal(sharedDto.apName);
			if(usDto.userScore == 0)
			{
				if(sharedDto.sharedObject.size == 0)
				{
					sharedDto.sharedObject.data[sharedDto.userName] = new Object();
					sharedDto.sharedObject.data.name = sharedDto.apName;
					sharedDto.sharedObject.data[sharedDto.userName].name = usDto.userName;
					sharedDto.sharedObject.data[sharedDto.userName].score = 0;
					sharedDto.sharedObject.data[sharedDto.userName].numLvl = 0;
				}
				if (sharedDto.sharedObject.data[sharedDto.userName] == null)
				{
					sharedDto.sharedObject.data[sharedDto.userName] = new Object();
					sharedDto.sharedObject.data[sharedDto.userName].name = usDto.userName;
					sharedDto.sharedObject.data[sharedDto.userName].score = 0;
					sharedDto.sharedObject.data[sharedDto.userName].numLvl = 0;
				}
				visibleContinueBtn();
			}
			else
			{
				if(sharedDto.sharedObject.size == 0)
				{
					sharedDto.sharedObject.data[sharedDto.userName] = new Object();
					sharedDto.sharedObject.data.name = sharedDto.apName;
					sharedDto.sharedObject.data[sharedDto.userName].name = usDto.userName;
					sharedDto.sharedObject.data[sharedDto.userName].score = usDto.userScore;
					sharedDto.sharedObject.data[sharedDto.userName].numLvl = usDto.numLevel;
				}
				if (sharedDto.sharedObject.data[sharedDto.userName] == null)
				{
					sharedDto.sharedObject.data[sharedDto.userName] = new Object();
					sharedDto.sharedObject.data[sharedDto.userName].name = usDto.userName;
					sharedDto.sharedObject.data[sharedDto.userName].score = usDto.userScore;
					sharedDto.sharedObject.data[sharedDto.userName].numLvl = usDto.numLevel;
				}
				else 
				{
					sharedDto.sharedObject.data[sharedDto.userName].score = usDto.userScore;
					sharedDto.sharedObject.data[sharedDto.userName].numLvl = usDto.numLevel;
				}
			}
		}
		
		public function visibleContinueBtn():void
		{
			if (sharedDto.sharedObject.data[sharedDto.userName].numLvl >= 1)
			{
				sendNotification(GeneralNotifications.CONTINUE_BTN_IS_VISIBLE);
			}
		}
		
		public function continueGame():void
		{
			sharedDto.continGameConfDto.numLvl = sharedDto.sharedObject.data[sharedDto.continGameConfDto.userName].numLvl;
			sharedDto.continGameConfDto.userScore = sharedDto.sharedObject.data[sharedDto.continGameConfDto.userName].score;
			sendNotification(GeneralNotifications.SET_CONF_TO_CONTINUE_GAME, sharedDto.continGameConfDto);
		}
		
		private function getUserNameAndScoreList():Array 
		{	
			sharedDto.sharedObject = SharedObject.getLocal(sharedDto.apName);
			sharedDto.arrNamesAndScores = new Array();
			for each(var obj:Object in sharedDto.sharedObject.data){
				try {
					sharedDto.arrNamesAndScores.push({name:obj.name as String, score:obj.score as int});
				}
				catch (err:Error) {
					//нічого не робити - попалось поле sharedDto.sharedObject.data.name
				}	
			}
			sharedDto.arrNamesAndScores.sortOn("score", Array.DESCENDING | Array.NUMERIC); //Сортування масиву за спадданням очків
			return sharedDto.arrNamesAndScores;
		}
		
		public function highScoreUpdate():void
		{
			var arrData:Array = getUserNameAndScoreList();
			sendNotification(GeneralNotifications.HIGH_SCORE_SEND, arrData);
		}
		
		public function detFinishedLvlNum():int
		{
			return sharedDto.sharedObject.data[sharedDto.userName].numLvl;
		}
		
		public function getScoreForChoiseLvl():int
		{
			return sharedDto.sharedObject.data[sharedDto.userName].score;
		}
			
	}
}



/*		private function getUsersListByScores():void
		{
			for (var i:int = 0; i<sharedDto.arrNames.length; i++)
			{
				trace("імя графця та скор:", sharedDto.arrNames[i].name, "-", sharedDto.arrNames[i].score);
			}
		}
		*/
	/*	private function getUserList():Array 
		{	
			sharedDto.sharedObject = SharedObject.getLocal(sharedDto.apName);
			var usList:Array = new Array();
			for each(var obj:Object in sharedDto.sharedObject.data){
				try {
					usList.push(obj.name as String);
				}
				catch (err:Error) {
					//нічого не робити - попалось поле sharedDto.sharedObject.data.name
				}	
			}
			return usList;
		}
		private function getScoresList():Array 
		{	
			sharedDto.sharedObject = SharedObject.getLocal(sharedDto.apName);
			sharedDto.arrScores = new Array();
			var scoreList:Array = new Array();
			for each(var obj:Object in sharedDto.sharedObject.data){
				try {
					scoreList.push(obj.score as int);
				}
				catch (err:Error) {
					//нічого не робити - попалось поле sharedDto.sharedObject.data.name
				}	
			}			
			//Сортування масиву по імені
			var temp:int;
			for (var i:Number = 0; i < (scoreList.length - 1); i++)
				for(var j:Number = i; j < scoreList.length; ++j)
					if (scoreList[j] < scoreList[i]) {
						temp = scoreList[i];
						scoreList[i] = scoreList[j];
						scoreList[j] = temp;
					}			
			sharedDto.arrScores = scoreList;
			return scoreList;
		}
		
		public function getUsersNamesEndScoresArray():void
		{
			var scoresArr:Array = getScoresList();
			sharedDto.arrNames = new Array();
			
			for (var i:int = 0; i<scoresArr.length; i++)
			{
				var usersNamesByScore:String = getUsersListByScores(scoresArr[i]);
				sharedDto.arrNames.push(usersNamesByScore);
			}
		}
		
		private function getUsersListByScores(usScore:int):String
		{
			var namesArr:Array = getUserList();
			for (var i:int = 0; i<namesArr.length; i++)
			{
				if (usScore == sharedDto.sharedObject.data[namesArr[i]].score)
				{
					return namesArr[i] as String;
				}
			}
			return null;
		}
		public function getStatisticInfo():void
		{
			getUsersNamesEndScoresArray();
			trace("масив усіх очків наступний:",sharedDto.arrScores.toString());
			trace("масив усіх гравців наступний:",sharedDto.arrNames.toString());
		}*/
