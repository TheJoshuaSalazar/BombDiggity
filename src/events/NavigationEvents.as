package events
{
	import starling.events.Event;
	
	public class NavigationEvents extends Event
	{
		public static const CHANGE_SCREEN:String = "Change Screen";
		
		public var params:Object;
		
		public function NavigationEvents(type:String, _params:Object = null, bubbles:Boolean=false)
		{
			super(type, bubbles, data);
			this.params = _params;
		}
	}
}