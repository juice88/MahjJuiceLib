package core.levelsConfig.model.proxy
{
	import core.config.GeneralNotifications;
	import core.levelsConfig.model.dto.ConfigDto;
	import core.levelsConfig.model.dto.GameLevelsDtoArrDto;
	import core.levelsConfig.model.dto.LevelConfigDto;
	import core.sharedObject.model.dto.ContinGameConfDto;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class LevelsGameConfigProxy extends Proxy
	{
		public static const NAME:String = "LevelsGameConfigProxy";
		
		public function LevelsGameConfigProxy(lvlsConfXML:XML)
		{
			super(NAME, new ConfigDto());
			parseXMLConfFile(lvlsConfXML);
		}
		
		public function get configDto():ConfigDto
		{
			return getData() as ConfigDto;
		}
		
		public function newGame():void
		{
			configDto.currentLvlNum = 1;
		}
		
		private function parseXMLConfFile(lvlsConfXML:XML):void
		{
			trace("кількість ігор - ",lvlsConfXML.*.length());
			configDto.gameTypeArrDto = new Vector.<GameLevelsDtoArrDto>;
			configDto.totalNumOfGames = lvlsConfXML.game.length();
			for (var i:int = 0; i<lvlsConfXML.game.length(); i++)
			{
				var gameLevelsDtoArrDto:GameLevelsDtoArrDto = new GameLevelsDtoArrDto();
				gameLevelsDtoArrDto.levelsConfigDtoArr = new Vector.<LevelConfigDto>;
				gameLevelsDtoArrDto.gameNumber = i;
				gameLevelsDtoArrDto.gameName = lvlsConfXML.game[i].@NAME.toString();
				for (var j:int = 0; j<lvlsConfXML.game[i].level.length(); j++){
					var levelConfigDto:LevelConfigDto = new LevelConfigDto();
					var xmlObj:XML = lvlsConfXML.game[i].level[j];
					levelConfigDto.elemNum = parseInt(xmlObj.elemNum.text(), 10);
					levelConfigDto.framesBeginNum = parseInt(xmlObj.framesBeginNum.text(), 10);
					levelConfigDto.framesNum = parseInt(xmlObj.framesNum.text(), 10);
					levelConfigDto.nameOfGameField = xmlObj.nameOfGameField.text();
					levelConfigDto.elemName = xmlObj.elemName.text();
					levelConfigDto.openElemLimit = parseInt(xmlObj.openElemLimit.text(), 10);
					levelConfigDto.showElemDelay = parseInt(xmlObj.showElemDelay.text(), 10);
					levelConfigDto.minute = parseInt(xmlObj.minute.text(), 10);
					levelConfigDto.second = parseInt(xmlObj.second.text(), 10);
					levelConfigDto.scoreOneSel = parseInt(xmlObj.scoreOneSel.text(), 10);
					levelConfigDto.scoreMoreSel = parseInt(xmlObj.scoreMoreSel.text(), 10);
					levelConfigDto.scoreBonus = parseInt(xmlObj.scoreBonus.text(), 10);
					levelConfigDto.numSelForScoreMoreSel = parseInt(xmlObj.numSelForScoreMoreSel.text(), 10);
					gameLevelsDtoArrDto.levelsConfigDtoArr.push(levelConfigDto);
				}
				configDto.gameTypeArrDto.push(gameLevelsDtoArrDto);
			}
		}
		
		public function getTotalNumOfGamesType():int
		{
			return configDto.totalNumOfGames;
		}
		
		public function getCurrentGameType():int
		{
			return configDto.currentGameType;
		}
		
		public function setTypeOfGame(selectedGame:int):void
		{
			configDto.currentGameType = selectedGame;
		}
		
		public function setLevelConfig():void
		{
			sendNotification(GeneralNotifications.SET_LEVEL_CONFIG, configDto.gameTypeArrDto[configDto.currentGameType].levelsConfigDtoArr[configDto.currentLvlNum-1]);
			if (configDto.currentLvlNum == configDto.gameTypeArrDto[configDto.currentGameType].levelsConfigDtoArr.length)
			{
				configDto.currentLvlNum=0;
				configDto.currentGameType++;
				if (configDto.currentGameType == configDto.totalNumOfGames)
				{
					configDto.currentGameType = 0;
				}
			}
			sendNotification(GeneralNotifications.SET_NUM_LEVEL, configDto.currentLvlNum, getTotalNumOfLevels().toString());
			trace("Кількість левелів у грі", getTotalNumOfLevels());
		}
		
		public function getTotalNumOfLevels():int
		{
			var totalNumbersOfLvl:int;
			for (var i:int = 0; i<configDto.totalNumOfGames; i++)
			{
				totalNumbersOfLvl += configDto.gameTypeArrDto[i].levelsConfigDtoArr.length;
			}
			return totalNumbersOfLvl;
		}
		
		public function addLevelNum():void
		{
			configDto.currentLvlNum++;
		}
		
		public function setLevelNum(lvlNum:int):void
		{
			configDto.currentLvlNum = lvlNum;
		}
	}
}