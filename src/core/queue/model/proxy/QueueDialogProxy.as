package core.queue.model.proxy
{
	import core.config.GeneralNotifications;
	import core.queue.model.dto.DialogDto;
	import core.view.mediator.DialogMediator;
	
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class QueueDialogProxy extends Proxy
	{
		public static const NAME:String = "queueDialogProxy";
		
		public function QueueDialogProxy()
		{
			super(NAME, new DialogDto());
		}
		
		public function get dialogDto():DialogDto
		{
			return getData() as DialogDto;
		}
		
		override public function onRegister():void
		{
			dialogDto.dialogList = new Vector.<DialogMediator>;
		}
		
		public function addedDialogToList(dialog:DialogMediator):void
		{
			if (dialogDto.dialogList.length == 0)
			{
				sendNotification(GeneralNotifications.DIALOG_OPEN, dialog);
				dialogDto.dialogList.push(dialog);
			}
			else
			{
				var resultOfSeach:Boolean = resultOfSeachDialogInList(dialog);
				if (resultOfSeach == false)
				{
					dialogDto.dialogList.push(dialog);
				}
					
			}
			trace("Кількість діалогів у черзі -", dialogDto.dialogList.length);
		}
		private function resultOfSeachDialogInList(element:DialogMediator):Boolean
		{
			for (var i:uint=0; i<dialogDto.dialogList.length; i++)
			{
				// за допомогою стандартного метода getMediatorName() отримується ім'я медіатора
				// порівнюються імена медіаторів, якщо такий є в списку, тоді його не додаємо
				if (element.getMediatorName() == dialogDto.dialogList[i].getMediatorName()) 
				{
					return true;
				}
			}
			return false;
		}
		
		public function removeDialogFromList():void
		{
			dialogDto.dialogList.shift();
			openNextDialogFromList();
		}
		
		private function openNextDialogFromList():void
		{
			if (dialogDto.dialogList.length != 0) // перевірка, на випадок, якщо був видалений останній елемент в масиві (тобто черги немає і нічого непотрібно показувати)
			{
				sendNotification(GeneralNotifications.DIALOG_OPEN, dialogDto.dialogList[0]);
			}
		}
	}
}