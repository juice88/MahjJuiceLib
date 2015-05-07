package core.levelsConfig.model.proxy
{
	import core.config.GeneralNotifications;
	import core.levelsConfig.model.dto.ConfigDto;
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
		
		public function setLevelConfig():void
		{
			var xmlObj:XML = configDto.configXml.level[configDto.levelNum-1];
			configDto.elemNum = parseInt(xmlObj.elemNum.text(), 10);
			configDto.framesBeginNum = parseInt(xmlObj.framesBeginNum.text(), 10);
			configDto.framesNum = parseInt(xmlObj.framesNum.text(), 10);
			configDto.nameOfGameField = xmlObj.nameOfGameField.text();
			configDto.elemName = xmlObj.elemName.text();
			configDto.openElemLimit = parseInt(xmlObj.openElemLimit.text(), 10);
			configDto.showElemDelay = parseInt(xmlObj.showElemDelay.text(), 10);
			configDto.minute = parseInt(xmlObj.minute.text(), 10);
			configDto.second = parseInt(xmlObj.second.text(), 10);
			configDto.scoreOneSel = parseInt(xmlObj.scoreOneSel.text(), 10);
			configDto.scoreMoreSel = parseInt(xmlObj.scoreMoreSel.text(), 10);
			configDto.numSelForScoreMoreSel = parseInt(xmlObj.numSelForScoreMoreSel.text(), 10);
			sendNotification(GeneralNotifications.SET_LEVEL_CONFIG, configDto);
			sendNotification(GeneralNotifications.SET_NUM_LEVEL, configDto.levelNum);
			if (configDto.levelNum == configDto.configXml.children().length())
			{
				configDto.levelNum = 0;
			}
			trace("Кількість левелів у грі", configDto.configXml.children().length());
		}
		
		public function addLevelNum():void
		{
			configDto.levelNum++;
		}
		
		public function setLevelNum(contGameDto:ContinGameConfDto):void
		{
			configDto.levelNum = contGameDto.numLvl + 1; // додається на 1 левел більше, адже numLevel це поточний левел, який пройшов гравець
		}
	}
}