package
{
	import flash.display.Sprite;
	
	import starling.core.Starling;

	[SWF(frameRate="60", width="600", height="1000", backgroundColor="0x333333")]

	public class BombDiggity extends Sprite
	{
		private var starling:Starling;
		
		public function BombDiggity()
		{
			starling = new Starling(Game, stage);
			starling.antiAliasing = 1;
			starling.start();
		}
	}
}