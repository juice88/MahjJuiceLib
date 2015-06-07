package gamePlay.bonus.model.dto
{
	public class BonusDto extends Object
	{
		public var randValue:uint; // змінна для генерування випадкового значення кадру елемента бонуса
		public var bonusElemList:Vector.<ElemBonusDto>; // вектор усіх елементів бонусів
		public var scoreBonus:int; //к-ть очків, що нараховується за вибір бонусу з очками, надходить з CountersProxy
		
		public function BonusDto(score:int):void
		{
			scoreBonus=score;
		}
	}
}