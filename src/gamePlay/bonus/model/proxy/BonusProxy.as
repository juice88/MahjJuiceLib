package gamePlay.bonus.model.proxy
{
	import core.config.GeneralNotifications;
	
	import gamePlay.bonus.model.dto.BonusDto;
	import gamePlay.bonus.model.dto.ElemBonusDto;
	
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class BonusProxy extends Proxy
	{
		public static const NAME:String = "BonusProxy";
		
		public function BonusProxy()
		{
			super(NAME, new BonusDto());
		}
		
		public function get bonusDto():BonusDto
		{
			return getData() as BonusDto;
		}
		
		override public function onRegister():void
		{
			init();
		}
		private function init():void
		{
			bonusDto.bonusElemList = new Vector.<ElemBonusDto>;
			sendBonusKadrList();
		}
		
		private function sendBonusKadrList():void
		{
			for (var i:uint = 0; i<3; i++)
			{
				bonusDto.randValue = 1+(int(Math.random()*3));
				var elemBonusDto:ElemBonusDto = new ElemBonusDto();
				elemBonusDto.kadr = bonusDto.randValue;
				bonusDto.bonusElemList.push(elemBonusDto);
			}
		sendNotification(GeneralNotifications.BONUS_READE_TO_DRAW, bonusDto.bonusElemList);
		}
	}
}