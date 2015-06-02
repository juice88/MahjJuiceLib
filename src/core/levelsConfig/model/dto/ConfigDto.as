package core.levelsConfig.model.dto
{
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class ConfigDto extends Object
	{
		public var configXml:XML;
		public var levelNum:int;
		public var totalLevelNum:int; //загальна кількість левелів
		
		//Для StartLevelProxy
		public var elemNum:int; // кількість елементів на сцені
		public var framesBeginNum:int; //початковий кадр елемента, кадр з якого починаються формуватися кадри елементів напр. з 5 по framesNum
		public var framesNum:int; // кількість кадрів яка формуватиметься починаючи з кадру framesBeginNum
		public var openElemLimit:int; // кількість елементів яка порівнюється
		
		//Для LevelViewLogic
		public var nameOfGameField:String; //лінкейдж ігрового поля в флеш проф, на який кладуться картинки
		public var showElemDelay:int; // затримка відкритих елементів перед початком гри (для перегляду розташування елементів)
		public var elemName:String; //лінкейдж елемента в флеш проф, на який кладуться картинки
		
		//Для ScoreProxy
		public var second:int; //задається кількість секунд для певного рівня
		public var minute:int; //задається кількість хвилин для певного рівня
		public var scoreOneSel:int; //кількість очків, яка нараховується при першому правильному ході
		public var scoreMoreSel:int; //кількість очків, яка нараховується при декількох підряд правильних ходів та всіх наступних (до помилки)
		public var numSelForScoreMoreSel:int; //кількість підряд правильних ходів для нарахування бонусного числа очків
	
		// загрузка XML файла
//		public var loader:URLLoader;
//		public var request:URLRequest;
	}
}