package
{
	
	import events.NavigationEvents;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;

	public class CreditScreen extends Sprite
	{
		private var bg:Image;
		private var credits:Image;
		private var backButton:Button;
		
		public function CreditScreen()
		{
			addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage)
		}
		
		private function onAddedToStage():void
		{
			drawScreen();
		}
		
		private function drawScreen():void
		{
			bg = new Image(Assets.getTexture("StartScreen"));
			addChild(bg);
			
			credits = new Image(Assets.getTexture("Credits"));
			credits.x = 50;
			credits.y = 230;
			addChild(credits);
			
			backButton = new Button(Assets.getTexture("BackButton"));
			backButton.x = 200;
			backButton.y = 600;
			backButton.scaleX = 0.5;
			backButton.scaleY = 0.5;
			addChild(backButton);
			
			addEventListener(Event.TRIGGERED, onStartScreenClick);
		}
		
		private function onStartScreenClick(event:Event):void
		{
			var buttonClicked:Button = event.target as Button;
			
			if((buttonClicked as Button) == backButton)
			{
				visible = false;
				dispatchEvent(new NavigationEvents(NavigationEvents.CHANGE_SCREEN, {id:"Title Screen"}, true));
			}
		}
	}
}