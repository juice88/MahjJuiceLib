package core.popups.model.dto
{
	public class PopupConfDto extends Object
	{
		public var titleText:String;
		public var tf1Text:String;
		public var tf2Text:String;
		public var tf3Text:String;
		public var inputText:String;
		public var totalScore:int;
		public var levelScore:int;
		public var trueMoves:int;
		public var falseMoves:int = -1;
		public var backBtnShow:Boolean;
		public var nextBtnShow:Boolean;
		public var xBtnShow:Boolean;
		public var restartBtnShow:Boolean;
		public var params:String;
		public var sound:String = "PopupSound";
	}
}