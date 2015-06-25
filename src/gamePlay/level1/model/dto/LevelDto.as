package gamePlay.level1.model.dto
{
	import core.levelsConfig.model.dto.LevelConfigDto;

	public class LevelDto extends Object
	{
		public var kadrList:Vector.<uint>; // містить значення кадрів елементів(квадратиків) на грі
		public var randElements:uint; // змінна для генерування випадкового значення кадру
		
		public var state:String; // містить данні про вибраний режим, які прописані в Settings
		
		public var ElementListVector:Vector.<ElementDto>; // вектор усіх сформованих елементів
		public var openElementsList:Vector.<ElementDto>; // вектор елементів, які відкрилися при кліку (для їх порівняння)
		
		public var elemNum:int; // кількість елементів на сцені
		public var framesBeginNum:int; //початковий кадр елемента, кадр з якого починаються формуватися кадри елементів напр. з 5 по framesNum
		public var framesNum:int; // кількість кадрів яка формуватиметься починаючи з кадру framesBeginNum
		public var openElemLimit:int; // кількість елементів яка порівнюється
		public var historyArray:Array;
		
		public function LevelDto(confDto:LevelConfigDto):void
		{
			elemNum = confDto.elemNum;
			framesBeginNum = confDto.framesBeginNum;
			framesNum = confDto.framesNum;
			openElemLimit = confDto.openElemLimit;
		}
	
	}
}