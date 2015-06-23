package core.config
{
	public class GeneralNotifications
	{
		public static const ADD_CHILD_TO_ROOT:String = "add_child_to_root";
		public static const BACK_TO_MENU:String = "back_to_menu";
		public static const BONUS_LEVEL_LOAD:String = "bonus_level_load";
		public static const BONUS_READE_TO_DRAW:String = "bonus_reade_to_draw"; //нотіф про готовність нарисування елементів бонусів (відсилається з проксі послідовність кадрів)
		public static const BONUS_RESULT_OF_CHOISE:String = "bonus_result_of_choise"; //нотіф з результатом вибору нонуса в скор проксі
		public static const SHOW_LEVELS_CATEGORY_POPUP:String = "show_levels_category_popup";
		public static const CONTINUE_BTN_IS_VISIBLE:String = "continue_btn_is_visible"; //нотіф, про те, щоб зробити видимою кнопку continue game
		public static const CONTINUE_GAME:String = "continue_game";
		public static const DIALOG_CLOSE:String = "dialog_close"; //нотіф про закривання діалога (відсилається з onRemove DialogMediator)
		public static const DIALOG_LOAD_TO_QUEUE:String = "dialog_load_to_queue"; //завантажується медіатор діалога в чергу
		public static const DIALOG_OPEN:String = "dialog_open";
		public static const END_TURN:String = "end_turn"; //Нотіф про закінчення вибору елементів
		public static const FULL_SCREEN:String = "full_screen";
		public static const GAME_OVER:String = "game_over";
		public static const HIGH_SCORE_SEND:String = "high_score_send";
		public static const HIGH_SCORE_UPDATE:String = "high_score_update";
		public static const LEVELS_MAP_CHOISE:String = "levels_map_choise";
		public static const LEVELS_MAP_CLOSE:String = "levels_map_close";
		public static const LEVELS_MAP_SHOW:String = "levels_map_show";
		public static const LIFES_COUNTER_UPDATED:String = "lifes_counter_updated";
		public static const MOVES_COUTNER_UPDATED:String = "moves_coutner_updated"; //нотіф з проксі про те що лічильник обновився... (має нове значення)
		public static const MUTE:String = "mute";
		public static const NEXT_LEVEL:String = "next_level"
		public static const NUMBER_OF_MOVES:String = "number_of_moves"; //передається в ScoreProxy кількість ходів (наперід відома) для правильного вибору елементів (тобто кількість можливих ходів аби виграти левел)
		public static const ON_OPEN_ELEMENT:String = "on_open_element"; //Нотіф про те що елемент ще не відкритий, а ми лише намірені його відкрити цей елемент
		public static const PAUSE:String="pause";
		public static const PAUSE_CONTINUE_GAME:String = "pause_continue_game";
		public static const PERMIT_TO_ADD:String = "permit_to_add"; //Нотіф про дозвіл добавити ще один вибраний елемент
		public static const READY_TO_DRAW:String = "ready_to_draw"; // Нотіф про готовність до розташування елементів
		public static const REMOVE_CHILD_FROM_ROOT:String = "remove_child_from_root";
		public static const REMOVE_POPUP:String = "remove_popup"; //нотіф яким в команду передається ім"я медіатора, котрий потрібно видалити
		public static const REPLAY_LEVEL:String = "replay_level";
		public static const RESTART_GAME:String = "restart_game";
		public static const RESULTS_TURN:String = "result_turn"; //нотіф з результатом ходу (вибору елемента)
		public static const SCORE_COUTNER_UPDATED:String = "score_coutner_updated"; // нотіф з СкорПроксі про обновлення лічильника очків обновився... (має нове значення)
		public static const SCORE_MOVES_ANIMATION:String = "score_moves_animation"; //нотіф з числом очків, які зараховуються при правильному ході
		public static const SELECT_IS_TRUE:String = "select_is_true"; //нотіф про правильне порівняння елементів (для лічильника очків)
		public static const SELECT_IS_FALSE:String = "select_is_false"; //нотіф про неправильне порівняння елементів (для лічильника очків)
		public static const SET_CONF_TO_CONTINUE_GAME:String = "set_conf_to_continue_game"; //нотіф з налаштуваннями левела для продовження гри
		public static const SET_LEVEL_CONFIG:String = "set_level_config";
		public static const SET_NAME_LEVEL_AND_SCORE_IN_SO:String = "set_name_and_score_in_so";
		public static const SET_NUM_LEVEL:String = "set_num_level";
		public static const SET_PLAYER_NAME:String = "set_player_name"; //нотіфом пересилається в highScore проксі введене ім"я гравця
		public static const SET_PLAYER_SCORE:String = "set_player_score"; //нотіфом пересилається в highScore проксі score гравця
		public static const SETTINGS_PANEL_OPEN:String = "settings_panel_open";
		public static const START_NEW_GAME:String = "start_new_game";
		public static const START_TIMER:String = "start_timer";
		public static const START_APP:String = "start_app";
		public static const VALUES_MINUTE_SECOND:String = "values_minute_second"; //нотіф що передає значення хвилин та секунд, для відображення таймера
		
		public static const POPUP_SHOW_ENTER_NAME:String = "popup_show_enter_name";
		public static const POPUP_SHOW_CHECK_USER_NAME_EXIST:String = "POPUP_SHOW_CHECK_USER_NAME_EXIST";
		public static const POPUP_SHOW_PAUSE:String ="popup_show_pause";
		public static const POPUP_SHOW_CONFIRM_TO_RESTART:String = "popup_show_confirm_to_restart";
		public static const POPUP_SHOW_CONFIRM_TO_EXIT:String = "popup_show_confirm_to_exit";
		public static const POPUP_SHOW_BONUS:String = "popup_show_bonus";
		public static const POPUP_SHOW_WIN:String = "popup_show_win";
		public static const POPUP_SHOW_GAME_OVER:String = "popup_show_game_over";
		
		public static const LOAD_URL_REQUEST:String = "load_url_request";
		public static const LOAD_MAIN_CONTENT:String = "load_main_content";
	}
}