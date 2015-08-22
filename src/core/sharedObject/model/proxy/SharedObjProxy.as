package core.sharedObject.model.proxy
{
	import core.config.GeneralNotifications;
	import core.sharedObject.model.dto.ContinGameConfDto;
	import core.sharedObject.model.dto.SharedObjDto;
	import core.sharedObject.model.dto.UserDataDto;
	
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
			sharedDto.sharedObject = SharedObject.getLocal(sharedDto.apName);
		}
		
		public function setUserNameLevelEndScore(usDto:UserDto, totalNumOfGameType:String):void
		{
			sharedDto.gameType = usDto.currentGameType;
			sharedDto.continGameConfDto.userName = usDto.userName;
			sharedDto.userName = usDto.userName;
			sharedDto.userDataDto = new UserDataDto();
			sharedDto.userDataDto.currentLvlForGameType = new Array();
			sharedDto.userDataDto.maxLvlForGameType = new Array();
			
			if(usDto.userScore == 0)
			{
				sharedDto.userDataDto.name = usDto.userName;
				for (var i:int = 0; i<parseInt(totalNumOfGameType); i++)
				{
					sharedDto.userDataDto.currentLvlForGameType.push(0);
					sharedDto.userDataDto.maxLvlForGameType.push(0);
				}
				sharedDto.userDataString = JSON.stringify(sharedDto.userDataDto);
				if(sharedDto.sharedObject.size == 0)
				{
					sharedDto.sharedObject.data.name = sharedDto.apName;
					sharedDto.sharedObject.data[sharedDto.userName] = new Object();
					sharedDto.sharedObject.data[sharedDto.userName].json = sharedDto.userDataString;
				}
				if (sharedDto.sharedObject.data[sharedDto.userName] == null)
				{
					sharedDto.sharedObject.data[sharedDto.userName] = new Object();
					sharedDto.sharedObject.data[sharedDto.userName].json = sharedDto.userDataString;
				}
				visibleContinueBtn();
			} else {
				if(sharedDto.sharedObject.size == 0)
				{
					sharedDto.sharedObject.data.name = sharedDto.apName;
					sharedDto.sharedObject.data[sharedDto.userName] = new Object();
					for (var j:int = 0; j<parseInt(totalNumOfGameType); j++)
					{
						if (j == usDto.currentGameType)
						{
							sharedDto.userDataDto.currentLvlForGameType.push(usDto.numLevel);
							sharedDto.userDataDto.maxLvlForGameType.push(usDto.numLevel);
						} else {
							sharedDto.userDataDto.currentLvlForGameType.push(0);
							sharedDto.userDataDto.maxLvlForGameType.push(0);
						}
					}
					sharedDto.userDataString = JSON.stringify(sharedDto.userDataDto);
					sharedDto.sharedObject.data[sharedDto.userName].json = sharedDto.userDataString;
				}
				if (sharedDto.sharedObject.data[sharedDto.userName] == null)
				{
					sharedDto.sharedObject.data[sharedDto.userName] = new Object();
					for (var a:int = 0; a<parseInt(totalNumOfGameType); a++)
					{
						if (a == usDto.currentGameType)
						{
							sharedDto.userDataDto.currentLvlForGameType.push(usDto.numLevel);
							sharedDto.userDataDto.maxLvlForGameType.push(usDto.numLevel);
						} else {
							sharedDto.userDataDto.currentLvlForGameType.push(0);
							sharedDto.userDataDto.maxLvlForGameType.push(0);
						}
					}
					sharedDto.userDataString = JSON.stringify(sharedDto.userDataDto);
					sharedDto.sharedObject.data[sharedDto.userName].json = sharedDto.userDataString;
				} else {
					var parsingUserData:UserDataDto = parsingJSONObj();
					sharedDto.userDataDto.name = sharedDto.userName;
					sharedDto.userDataDto.score = usDto.userScore;
					sharedDto.userDataDto.currentLvlForGameType = parsingUserData.currentLvlForGameType;
					sharedDto.userDataDto.currentLvlForGameType[usDto.currentGameType] = usDto.numLevel;
					var checkMaxLvl:Boolean = checkMaxContinueLvl(usDto.numLevel);
					if (checkMaxLvl)
					{
						sharedDto.userDataDto.maxLvlForGameType = parsingUserData.maxLvlForGameType;
						sharedDto.userDataDto.maxLvlForGameType[usDto.currentGameType] = usDto.numLevel;
					} else {
						sharedDto.userDataDto.maxLvlForGameType = parsingUserData.maxLvlForGameType;
					}
					sharedDto.userDataString = JSON.stringify(sharedDto.userDataDto);
					sharedDto.sharedObject.data[sharedDto.userName].json = sharedDto.userDataString;
				}
				visibleContinueBtn();
			}
		}
		
		private function parsingJSONObj():UserDataDto
		{
			var userData:UserDataDto = new UserDataDto();
			userData.currentLvlForGameType = new Array();
			userData.maxLvlForGameType = new Array();
			var	userDataObj:Object = JSON.parse(sharedDto.sharedObject.data[sharedDto.userName].json);
			userData.name = userDataObj.name as String;
			userData.score = userDataObj.score as int;
			userData.currentLvlForGameType = userDataObj.currentLvlForGameType as Array;
			userData.maxLvlForGameType = userDataObj.maxLvlForGameType as Array;
			return userData;
		}
		
		public function setGameType(gameType:int):void
		{
			sharedDto.gameType = gameType;
			visibleContinueBtn();
		}
		
		private function checkMaxContinueLvl(currentLvl:int):Boolean
		{
			var parsingUserData:UserDataDto = parsingJSONObj();
			if (parsingUserData.maxLvlForGameType[sharedDto.gameType] < currentLvl)
			{
				return true;
			}
			return false;
		}
		
		public function visibleContinueBtn():void
		{
			var parsingUserData:UserDataDto = parsingJSONObj();
			if (parsingUserData.maxLvlForGameType[sharedDto.gameType]>=1)
			{
				sendNotification(GeneralNotifications.CONTINUE_BTN_IS_VISIBLE, true);
			} else {
				sendNotification(GeneralNotifications.CONTINUE_BTN_IS_VISIBLE, false);
			}
		}
		
		public function continueGame():void
		{
			setDataForContinueGame();
			sendNotification(GeneralNotifications.SET_CONF_TO_CONTINUE_GAME, sharedDto.continGameConfDto);
		}
		
		private function setDataForContinueGame():void
		{
			var parsingUserData:UserDataDto = parsingJSONObj();
			sharedDto.continGameConfDto.numLvl = parsingUserData.currentLvlForGameType[sharedDto.gameType];
			sharedDto.continGameConfDto.userScore = parsingUserData.score;
		}
		
		private function getUserNameAndScoreList():Array 
		{	
			sharedDto.arrNamesScoresAndMaxComplLvl = new Array();
			var allDataStringArr:Array = new Array();
			for each(var obj:Object in sharedDto.sharedObject.data){
				try {
					var userDataObj:Object = JSON.parse(obj.json);
					allDataStringArr.push(userDataObj);
				}
				catch (err:Error) {
					//нічого не робити - попалось поле sharedDto.sharedObject.data.name
				}	
			}
			for (var i:int = 0; i<allDataStringArr.length; i++)
			{
				parsingArrString(allDataStringArr[i]);
			}
			sharedDto.arrNamesScoresAndMaxComplLvl.sortOn("score", Array.DESCENDING | Array.NUMERIC); //Сортування масиву за спадданням очків
			return sharedDto.arrNamesScoresAndMaxComplLvl;
		}
		
		private function parsingArrString(obj:Object):void
		{
			var totalLvlCopml:int = getTotalComplLvlByArr(obj.maxLvlForGameType as Array);
			sharedDto.arrNamesScoresAndMaxComplLvl.push({name:obj.name as String, score:obj.score as int, lvl:totalLvlCopml as int});
		}
		
		private function getTotalComplLvlByArr(arr:Array):int
		{
			var totalLvlCopml:int;
			for (var i:int = 0; i<arr.length; i++)
			{
				totalLvlCopml += arr[i];
			}
			return totalLvlCopml;
		}
		
		private function getMaxLevelForName(name:String):int
		{
			return sharedDto.sharedObject.data[name+sharedDto.gameType].maxLvl;
		}
		
		public function highScoreUpdate(maxLvlNum:int):void //походу тут лажа...!!!! звернути увагу
		{
			var arrData:Array = getUserNameAndScoreList();
			sendNotification(GeneralNotifications.HIGH_SCORE_SEND, arrData, maxLvlNum.toString(10));
		}
		
		public function getFinishedLvlNum():int
		{
			var parsingUserData:UserDataDto = parsingJSONObj();
			return parsingUserData.currentLvlForGameType[sharedDto.gameType];
		}
		
		public function getMaxNumOfComplLvl():int
		{
			var parsingUserData:UserDataDto = parsingJSONObj();
			return parsingUserData.maxLvlForGameType[sharedDto.gameType];
		}
		
		public function getScoreForChoiseLvl():ContinGameConfDto
		{
			setDataForContinueGame();
			return sharedDto.continGameConfDto;
		}
		
		public function checkExistansUserName(usName:String):Boolean
		{
			if (sharedDto.sharedObject.data[usName] == undefined)
			{
				trace("немає такого імені в ШарОбж");
				return false;
			}
			trace("є таке імя в ШарОбж");
			return true;
		}
	}
}

// сортування вмісту масива
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
