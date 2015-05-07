package core.counters.model.dto
{
	import core.levelsConfig.model.dto.ConfigDto;
	
	import flash.utils.Timer;

	public class CountersDto extends Object
	{
		public var scoreOfSomeLevel:int = 0; // кількість очок за рівень
		public var totalScore:int = 0; //загальна кількість очок (за всі рівні)
		public var numberOfMoves:int; //кількість можливих ходів передана з StartGameProxy...
		public var allMoves:int; //кількість ходів за рівень
		public var trueSelect:int = 0; //кількість вірних ходів (для нарахування бонусних очків, при виборі підряд декількох елементів), обнуляється при неправильному ході
		public var allFalseSelect:int = 0;  //загальна кількість неправильних ходів
		public var allTrueSelect:int = 0; //загальна кількість правильних ходів 
		public var lifes:int = 10; //кількість життів
		public var lifesIsFrozen:Boolean = false; // перевірка, чи мають життя бути заморожені (у випадку вибору бонуса)
		public var scoreTrueFalseValue:Array; //додаються до масиву та передаються в WinPopupVL наступні значення: загальна кількість очок, правильні ходи та неправильні ходи
		public var timer:Timer;
		public var timerIsStopped:Boolean = false; //для бонусного рівня, якщо вибрано бонус зупинка таймера - тоді встановлюється true, далі намагані старт таймер відбуваєтсья перевірка цього значення
		public var second:int; //встановлення тривалості гри поточного рівня
		public var minute:int;
		public var restartSetSecond:int; //дублюється тривалість гри для рестарта
		public var restartSetMinute:int;
		public var minuteSecond:Array; //додаються в масив значення хвилин та секунд для таймера та передається в BotPanelViewLogic
		public var scoreOneSel:int; //кількість очків, яка нараховується при першому правильному ході
		public var scoreMoreSel:int; //кількість очків, яка нараховується при декількох підряд правильних ходів та всіх наступних (до помилки)
		public var numSelForScoreMoreSel:int; //кількість підряд правильних ходів для нарахування бонусного числа очків
		
		public function setLevelConf(confDto:ConfigDto):void
		{
			second = confDto.second;
			minute = confDto.minute;
			restartSetSecond = confDto.second;
			restartSetMinute = confDto.minute;
			scoreOneSel = confDto.scoreOneSel;
			scoreMoreSel = confDto.scoreMoreSel;
			numSelForScoreMoreSel = confDto.numSelForScoreMoreSel;
		}
	}
}