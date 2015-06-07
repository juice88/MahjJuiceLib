package core.levelsConfig.model.proxy
{
	import core.config.GeneralNotifications;
	import core.levelsConfig.model.dto.ConfigDto;
	import core.levelsConfig.model.dto.LevelConfigDto;
	import core.sharedObject.model.dto.ContinGameConfDto;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class LevelsGameConfigProxy extends Proxy
	{
		public static const NAME:String = "LevelsGameConfigProxy";
		
		public function LevelsGameConfigProxy()
		{
			super(NAME, new ConfigDto());
		}
		
		public function get configDto():ConfigDto
		{
			return getData() as ConfigDto;
		}
		
		public function newGame():void
		{
			configDto.levelNum = 1;
		}
		
		override public function onRegister():void
		{
			loadLevelsConfigFile();
			
		}
		
		public function loadLevelsConfigFile():void
		{
			[Embed(source = "res/ConfigFile.xml", mimeType="application/octet-stream")] var ConfLvl:Class;
			configDto.configXml = new XML(new ConfLvl());
			parseXMLConfFile();
//			configDto.loader = new URLLoader();
//			configDto.request = new URLRequest("res/ConfigFile.xml");
//			configDto.loader.load(configDto.request);
//			configDto.loader.addEventListener(Event.COMPLETE, onLoad);
		}
		
//		protected function onLoad(event:Event):void
//		{
//			var loader:URLLoader = event.target as URLLoader; 
//			if (loader != null) 
//			{ 
//				configDto.configXml = new XML(loader.data); 
//			} 
//			else 
//			{ 
//				trace("loader is not a URLLoader!"); 
//			} 
//		}
		
		private function parseXMLConfFile():void
		{
			configDto.levelConfigList = new Vector.<LevelConfigDto>;
			for (var i:int = 0; i<configDto.configXml.children().length(); i++)
			{
				var levelConfigDto:LevelConfigDto = new LevelConfigDto();
				var xmlObj:XML = configDto.configXml.level[i];
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
				
				configDto.levelConfigList.push(levelConfigDto);
			}
		}
		
		public function setLevelConfig():void
		{
			sendNotification(GeneralNotifications.SET_LEVEL_CONFIG, configDto.levelConfigList[configDto.levelNum-1]);
			if (configDto.levelNum == configDto.configXml.children().length())
			{
				configDto.levelNum = 0;
			}
			sendNotification(GeneralNotifications.SET_NUM_LEVEL, configDto.levelNum, configDto.levelConfigList.length.toString());
			trace("Кількість левелів у грі", configDto.levelConfigList.length);
		}
		
		public function addLevelNum():void
		{
			configDto.levelNum++;
		}
		
		public function setLevelNum(lvlNum:int):void
		{
			configDto.levelNum = lvlNum;
		}
		
	}
}