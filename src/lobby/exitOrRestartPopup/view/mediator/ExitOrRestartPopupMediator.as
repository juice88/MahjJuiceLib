package lobby.exitOrRestartPopup.view.mediator
{
	import core.view.mediator.DialogMediator;
	
	import lobby.exitOrRestartPopup.view.components.ExitOrRestartPopupVL;
	
	public class ExitOrRestartPopupMediator extends DialogMediator
	{
		public static const NAME:String ="ExitOrRestartPopupMediator";
		public function ExitOrRestartPopupMediator()
		{
			super(NAME, new ExitOrRestartPopupVL);
		}
		
		private function get exitPop():ExitOrRestartPopupVL
		{
			return viewLogic as ExitOrRestartPopupVL;
		}
	}
}