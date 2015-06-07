package gamePlay.bonus.view.components
{
	import core.config.GameEvent;
	import core.config.GeneralEventsConst;
	import core.config.Settings;
	import core.utils.SoundLib;
	import core.utils.Warehouse;
	import core.view.components.ViewLogic;
	
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import gamePlay.bonus.model.dto.ElemBonusDto;

	public class BonusViewLogic extends ViewLogic
	{
		private var _BonusElem:Class = Warehouse.getInstance().getAssetClass("ElementBonus");
		private var _shablonBonus:String = "shablonBonus";
		private var _show:String = "show";
		private var _bonusElemList:Vector.<ElemBonusDto>;
		
		public function BonusViewLogic()
		{
			super("PolleBonus");
		}
	
		private function get bonusVL():MovieClip
		{
			return content as MovieClip;
		}
				
		public function startBonusLevel(elemBonusDto:Vector.<ElemBonusDto>):void
		{
			addBackground();
			_bonusElemList = new Vector.<ElemBonusDto>;
			_bonusElemList = elemBonusDto;
			
			for (var i:int = 0; i<elemBonusDto.length; i++)
			{
				elemBonusDto[i].elemBonus = new _BonusElem();
				elemBonusDto[i].elemBonus.gotoAndStop(elemBonusDto[i].kadr);
				if (elemBonusDto[i].scoreBonus != -1)
				{
					var scoreBonusTf:TextField = elemBonusDto[i].elemBonus["scoreBonusTf"];
					scoreBonusTf.text = "+"+elemBonusDto[i].scoreBonus.toString(10);
				}
				elemBonusDto[i].elemBonus.addEventListener(MouseEvent.CLICK, onClickToBonusElemHald);
				((bonusVL[_shablonBonus+i]) as MovieClip).addChild(elemBonusDto[i].elemBonus);
			}
		}
		
		protected function onClickToBonusElemHald(event:MouseEvent):void
		{
			var bonusClip:MovieClip = (event.currentTarget as MovieClip);
			var neededDto:ElemBonusDto = getDtoByContent(bonusClip);
			removeLisenersElem();
			bonusClip.back.gotoAndStop(_show);
			SoundLib.getInstance().playSound("BonusSelect");
			dispatchEvent(new GameEvent(GeneralEventsConst.BONUS_RESULT_OF_CHOISE, neededDto.kadr as int));
		}
		
		private function removeLisenersElem():void
		{
			for (var i:uint = 0; i<_bonusElemList.length; i++)
			{
				_bonusElemList[i].elemBonus.removeEventListener(MouseEvent.CLICK, onClickToBonusElemHald);
			}
		}
		
		private function getDtoByContent(bonusClip:MovieClip):ElemBonusDto
		{
			for (var i:uint=0; i<_bonusElemList.length; i++)
			{
				if (bonusClip == _bonusElemList[i].elemBonus)
				{
					return  _bonusElemList[i];
				}
			}
			return null;
		}
		
		private function addBackground():void
		{
			var graf:Graphics = bonusVL.graphics;
			graf.beginFill(0x150000, 0.5);
			graf.drawRect(0,0,Settings.BACKGROUND_RECT_WIDTH,Settings.BACKGROUND_RECT_HEIGHT);
			graf.endFill();
		}
	}
}