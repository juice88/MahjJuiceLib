package core.config
{
	public class Settings
	{
	//	public static const OPEN_ELEM_LIMIT:uint = 2; //кількість елементів яка порівнюється
		public static const TIME_DELAY:uint = 500; //1000мс = 1с, затримка відкритого елемента
	//	public static const SHOW_ELEMENTS_DELAY:uint = 2000; // затримка відкритих елементів перед початком гри (для перегляду розташування елементів)
		
		//налаштування режимів гри
		public static const IDLE_STATE:String = "IdleState";//режим (стан) очікування
		public static const OPENING_STATE:String = "OpeningState";//режим (стан) відкриття елемента
		public static const RESULT_STATE:String = "ResultState";//режим (стан) відсилання результату
		
		//налаштування таймера гри
//		public static const TIMER_START_LEVEL_MINUTE:int = 0;
//		public static const TIMER_START_LEVEL_SECOND:int = 40;
//		public static const TIMER_NEXT_LEVEL_MINUTE:int = 0;
//		public static const TIMER_NEXT_LEVEL_SECOND:int = 50;
		
		//налаштування нарахування очків
//		public static const SCORE_ONE_TRUE_SELECT:uint = 10; //кількість очків, яка нараховується при першому та другому правильних ходах
//		public static const SCORE_THREE_TRUE_SELECT:uint = 30; //кількість очків, яка нараховується при третьому підряд правильному ході та всіх наступних (до помилки)
		public static const SCORE_BONUS:uint = 200; ////кількість очків, яка нараховується при виборі бонуса з очками
		
		//налаштування розмірів заднього напівпрозорого фону для попапів
		public static var BACKGROUND_RECT_HEIGHT:int;
		public static var BACKGROUND_RECT_WIDTH:int;
		
	}
}