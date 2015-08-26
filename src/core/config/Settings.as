package core.config
{
	public class Settings
	{
		//налаштування режимів гри
		public static const IDLE_STATE:String = "IdleState";//режим (стан) очікування
		public static const OPENING_STATE:String = "OpeningState";//режим (стан) відкриття елемента
		public static const RESULT_STATE:String = "ResultState";//режим (стан) відсилання результату
		
		//налаштування розмірів заднього напівпрозорого фону для попапів
		public static var BACKGROUND_RECT_HEIGHT:int;
		public static var BACKGROUND_RECT_WIDTH:int;
		
		public static var user:String = "noadmin"; //admin
		
	}
}