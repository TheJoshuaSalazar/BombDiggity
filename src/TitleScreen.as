package
{
	import events.NavigationEvents;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.extensions.PDParticleSystem;
	import starling.textures.Texture;
	
	public class TitleScreen extends Sprite
	{
		private var bg:Image;
		private var instructions:Image;
		private var startButton:Button;
		private var tutorialButton:Button;
		private var creditButton:Button;
		private var bombParticle:PDParticleSystem;
		
		public function TitleScreen()
		{	
			addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage():void
		{
			drawScreen();
		}
		
		private function drawScreen():void
		{
			bg = new Image(Assets.getTexture("StartScreen"));
			bg.scaleX = 1.1;			
			addChild(bg);
			
			instructions = new Image(Assets.getTexture("InstructionText"));
			instructions.x = 25;
			instructions.y = 300;
			instructions.scaleX = .75;
			instructions.scaleY = .8;
			addChild(instructions);
			
			startButton = new Button(Assets.getTexture("StartButton"));
			startButton.x = 135;
			startButton.y = 400;
			startButton.scaleX = 0.65;
			startButton.scaleY = 0.7;
			addChild(startButton);
			
			tutorialButton = new Button(Assets.getTexture("TutorialButton"));
			tutorialButton.x = 50;
			tutorialButton.y = 680;
			tutorialButton.scaleX = 0.25;
			tutorialButton.scaleY = 0.2;
			addChild(tutorialButton);
			
			creditButton = new Button(Assets.getTexture("CreditsButton"));
			creditButton.x = 320;
			creditButton.y = 680;
			creditButton.scaleX = 0.25;
			creditButton.scaleY = 0.2;
			addChild(creditButton);
			
			particleBomb();
			
			addEventListener(Event.TRIGGERED, onStartScreenClick);
		}
		
		private function particleBomb():void
		{
			bombParticle = new PDParticleSystem(XML(new AssetsParticles.ExplosionParticle2()),
				Texture.fromBitmap(new AssetsParticles.ParticleTexture()));
			
			bombParticle.start();
			bombParticle.x = 80;
			bombParticle.y = 45;
			addChild(bombParticle);
			
			Starling.juggler.add(bombParticle);
			
		}
		
		private function onStartScreenClick(event:Event):void
		{
			var buttonClicked:Button = event.target as Button;
			
			if((buttonClicked as Button) == startButton)
			{
				visible = false;
				dispatchEvent(new NavigationEvents(NavigationEvents.CHANGE_SCREEN, {id:"Level 1"}, true));
			}
			if((buttonClicked as Button) == tutorialButton)
			{
				visible = false;
				dispatchEvent(new NavigationEvents(NavigationEvents.CHANGE_SCREEN, {id:"Tutorial"}, true));
			}
			if((buttonClicked as Button) == creditButton)
			{
				visible = false;
				dispatchEvent(new NavigationEvents(NavigationEvents.CHANGE_SCREEN, {id:"Credits"}, true));
			}
		}
	}
}