package gamePlay.bonus.model.dto
{
	public class BonusDto extends Object
	{
		public var randValue:uint; // змінна для генерування випадкового значення кадру елемента бонуса
		public var bonusElemList:Vector.<ElemBonusDto>; // вектор усіх елементів бонусів
	}
}