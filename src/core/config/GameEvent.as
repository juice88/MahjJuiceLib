package core.config
{
	import flash.events.Event;
	
	public class GameEvent extends Event
	{
		public var params:Object;
		public function GameEvent(type:String, par:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			params = par;
			super(type, bubbles, cancelable);
		}
	}
}