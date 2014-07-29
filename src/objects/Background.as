package objects
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Background extends Sprite
	{	
		private var image:Image;
		private var backgroundName:String;
		
		public function Background(imageName:String)
		{
			super();
			
			backgroundName = imageName;
			
			addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			
			image = new Image(Assets.getTexture(backgroundName));
			
			image.x = 0;
			image.y = 0;
			addChild(image);
		}		
	}
}