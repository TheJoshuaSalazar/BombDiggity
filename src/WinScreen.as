package
{
	import com.greensock.TweenLite;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.extensions.PDParticleSystem;
	import starling.textures.Texture;

	public class WinScreen extends Sprite
	{
		private var bg:Image;
		
		private var BlueUpParticle:PDParticleSystem;
		private var BlueWinningParticle:PDParticleSystem;
		private var RedUpParticle:PDParticleSystem;
		private var RedWinningParticle:PDParticleSystem;
		private var GreenUpParticle:PDParticleSystem;
		private var GreenWinningParticle:PDParticleSystem;
		
		public function WinScreen() 
		{
			addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);		
		}
		
		private function onAddedToStage():void
		{
			drawScreen();
		}
		
		private function drawScreen():void
		{
			bg = new Image(Assets.getTexture("WinScreen"));
			bg.width = 600;
			addChild(bg);	
			
			blueParticles();
			redParticles();
			greenParticles();
		}
		
		private function blueParticles():void
		{
			BlueUpParticle = new PDParticleSystem(XML(new AssetsParticles.BlueUpParticle()),
				Texture.fromBitmap(new AssetsParticles.ParticleTexture()));
			BlueWinningParticle = new PDParticleSystem(XML(new AssetsParticles.BlueWinningParticle()),
				Texture.fromBitmap(new AssetsParticles.ParticleTexture()));
			
			Starling.juggler.add(BlueUpParticle);
			Starling.juggler.add(BlueWinningParticle);
			
			BlueWinningParticle.x = 100;
			BlueWinningParticle.y = 100;
			BlueWinningParticle.start();
			addChild(BlueWinningParticle);
			//TweenLite.to(BlueUpParticle, 1, {x:100, y:100, delay:50});
		}
		
		private function redParticles():void
		{
			RedUpParticle = new PDParticleSystem(XML(new AssetsParticles.RedUpParticle()),
				Texture.fromBitmap(new AssetsParticles.ParticleTexture()));
			RedWinningParticle = new PDParticleSystem(XML(new AssetsParticles.RedWinningParticle()),
				Texture.fromBitmap(new AssetsParticles.ParticleTexture()));
			
			Starling.juggler.add(RedUpParticle);
			Starling.juggler.add(RedWinningParticle);
			
			RedWinningParticle.x = 300;
			RedWinningParticle.y = 200;
			RedWinningParticle.start();
			addChild(RedWinningParticle);
		}
		
		private function greenParticles():void
		{
			GreenUpParticle = new PDParticleSystem(XML(new AssetsParticles.GreenUpParticle()),
				Texture.fromBitmap(new AssetsParticles.ParticleTexture()));
			GreenWinningParticle = new PDParticleSystem(XML(new AssetsParticles.GreenWinningParticle()),
				Texture.fromBitmap(new AssetsParticles.ParticleTexture()));
			
			Starling.juggler.add(GreenUpParticle);
			Starling.juggler.add(GreenWinningParticle);
			
			GreenWinningParticle.x = 500;
			GreenWinningParticle.y = 100;
			GreenWinningParticle.start();
			addChild(GreenWinningParticle);
		}
	}
}