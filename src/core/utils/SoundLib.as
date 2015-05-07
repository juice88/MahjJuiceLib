package core.utils
{
	import flash.display.LoaderInfo;
	import flash.media.Sound;
	import flash.media.SoundTransform;

	public class SoundLib
	{
		private static var _instance:SoundLib;
		
		private var _volumeSet:SoundTransform = new SoundTransform();
		
		public static function getInstance():SoundLib
		{
			if (_instance==null)
			{
				_instance = new SoundLib();
			}
			return _instance;
		}
		
		public function playSound(name:String, timeStart:int=0, loops:int=1/*, volume:int=1*/):Sound
		{
			var NeedSound:Class = Warehouse.getInstance().getAssetClass(name);
			var sound:Sound = new NeedSound();
		//	volumeSet.volume = volume;
			sound.play(timeStart,loops,_volumeSet);
			return sound;
		}
		
		public function mute():void
		{
			if (_volumeSet.volume == 0)
			{
				_volumeSet.volume = 1;
			}
			else
			{
				_volumeSet.volume = 0;
			}
		}
		
		public function btnClickSound():void
		{
			SoundLib.getInstance().playSound("ButtonClick");
		}
	}
}