package 
{
	import flash.display.Bitmap;
	import flash.media.Sound;
	import flash.utils.Dictionary;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class Assets
	{
		[Embed(source="../media/graphics/Background 1.png")]
		public static const Background1:Class;

		[Embed(source="../media/graphics/Ash.jpg")]
		private static const Ash:Class;
		
		[Embed(source="../media/graphics/Dirt.png")]
		private static const DirtTexture:Class;
		
		[Embed(source="../media/graphics/Clay.png")]
		private static const ClayTexture:Class;
		
		[Embed(source="../media/graphics/Rock.png")]
		private static const RockTexture:Class;
		 
		[Embed(source="../media/graphics/Cracked Rock.png")]
		private static const CrackedRockTexture:Class;
		
		[Embed(source="../media/graphics/Obsidian1.png")]
		private static const ObsidianTexture1:Class;
		
		[Embed(source="../media/graphics/Obsidian2.png")]
		private static const ObsidianTexture2:Class;
		
		[Embed(source="../media/graphics/Obsidian3.png")]
		private static const ObsidianTexture3:Class;
		
		[Embed(source="../media/graphics/Obsidian4.png")]
		private static const ObsidianTexture4:Class;
		
		[Embed(source="../media/graphics/Obsidian5.png")]
		private static const ObsidianTexture5:Class;
		
		[Embed(source="../media/graphics/Water.png")]
		private static const WaterTexture:Class;
		
		[Embed(source="../media/graphics/Magma.png")]
		private static const MagmaTexture:Class;
		
		[Embed(source="../media/graphics/Null.png")]
		private static const NullTexture:Class;
	
		[Embed(source="../media/graphics/Gold.png")]
		private static const GoldTexture:Class;
		
		[Embed(source="../media/graphics/store1.jpg")]
		private static const firstStoreScreen:Class;
		
		[Embed(source="../media/graphics/store.jpg")]
		private static const secondStoreScreen:Class;
		
		[Embed(source="../media/graphics/Winner.jpg")]
		private static const WinScreen:Class;
		
		[Embed(source="../media/graphics/BuyButton.png")]
		private static const Buy:Class;
		
		[Embed(source="../media/graphics/RestartButton.png")]
		private static const Restart:Class;
		
		[Embed(source="../media/graphics/BasicBomb.png")]
		private static const BasicBomb:Class;
		
		[Embed(source="../media/graphics/Troll.png")]
		private static const JamieButton1:Class;
		
		[Embed(source="../media/graphics/Me Gusta.png")]
		private static const JamieButton2:Class;
		
		[Embed(source="../media/graphics/ComingSoon.png")]
		private static const ComingSoon:Class;
		
		[Embed(source="../media/graphics/UsingBombButton.png")]
		private static const ActiveButton:Class;
		
		[Embed(source="../media/graphics/UnactiveButton.png")]
		private static const UnactiveButton:Class;
		
		[Embed(source="../media/graphics/ActiveButton.png")]
		private static const DepletedButton:Class;
		
		[Embed(source="../media/graphics/LowBombButton.png")]
		private static const LowButton:Class;
		
		[Embed(source="../media/graphics/BetterBomb.png")]
		private static const BetterBomb:Class;
		
		[Embed(source="../media/graphics/IceBomb.png")]
		private static const FrostBomb:Class;
		
		[Embed(source="../media/graphics/StartScreen.png")]
		private static const StartScreen:Class;
		
		[Embed(source="../media/graphics/StartButton.png")]
		private static const StartButton:Class;
		
		[Embed(source="../media/graphics/BackButton.png")]
		private static const BackButton:Class;
		
		[Embed(source="../media/graphics/InstructionText.png")]
		private static const InstructionText:Class;
		
		[Embed(source="../media/graphics/GoToStore.png")]
		private static const GoToStore:Class;
		
		[Embed(source="../media/graphics/NextLevel.png")]
		private static const NextLevel:Class;
		
		[Embed(source="../media/graphics/Skip.png")]
		private static const SkipButton:Class;
		
		[Embed(source="../media/graphics/RetryLevel.png")]
		private static const RetryLevel:Class;
		
		[Embed(source="../media/graphics/Tutorial.png")]
		private static const TutorialButton:Class
		
		[Embed(source="../media/graphics/Retry.png")]
		private static const RetryIcon:Class;
		
		[Embed(source="../media/graphics/Credits.png")]
		private static const Credits:Class;
		
		[Embed(source="../media/graphics/CreditsButton.png")]
		private static const CreditsButton:Class;
		
		[Embed(source="../media/graphics/OutOfBombs.png")]
		private static const OutOfBombs:Class;
		
		[Embed(source="../media/sound/Basic Explosion.mp3")]
		private static const BasicExplosion:Class;
		
		[Embed(source="../media/sound/Better Explosion.mp3")]
		private static const BetterExplosion:Class;
		
		[Embed(source="../media/sound/Ice Shatter.mp3")]
		private static const IceShatter:Class;
		
		[Embed(source="../media/sound/Gold Collect.mp3")]
		private static const GoldCollect:Class;
		
		[Embed(source="../media/sound/02 Big Money Edit.mp3")]
		private static const BackGroundMusic:Class;
		
		[Embed(source="../media/graphics/Tutorial Hint 1.png")]
		private static const ClickSquare:Class;
		
		[Embed(source="../media/graphics/Tutorial Hint 2.png")]
		private static const ClickRetry:Class;
		
		[Embed(source="../media/graphics/Tutorial Hint 3.png")]
		private static const FindGold:Class;
		
		[Embed(source="../media/graphics/Tutorial Hint 4.png")]
		private static const FoundGold:Class;
		
		[Embed(source="../media/graphics/Tutorial Hint 5.png")]
		private static const ClickDifferentBomb:Class;
		
		[Embed(source="../media/graphics/Tutorial Hint 6.png")]
		private static const ReachTheBottom:Class;
		
		private static var gameTextures:Dictionary = new Dictionary();
		
		private static var gameTextureAtlas:TextureAtlas;
		
		private static var gameSounds:Dictionary = new Dictionary();
		
		private static var explosion:Sound;
		
		public static function getTexture(name:String):Texture
		{
			if(gameTextures[name] == undefined)
			{
				var bitmap:Bitmap = new Assets[name]();
				gameTextures[name] = Texture.fromBitmap(bitmap);
			}
			
			return gameTextures[name];
		}
		
		public static function getAtlas():TextureAtlas
		{
			if(gameTextureAtlas == null)
			{
				var texture:Texture = getTexture("AtlasTextureGame");
//				var xml:XML = XML(new CLASS HERE());
//				gameTextureAtlas = new TextureAtlas(texture, xml);
			}
			
			return gameTextureAtlas;
		}
		
		public static function getSound(name:String):Sound
		{
			if(gameSounds[name] == undefined)
			{
				var sound:Sound = new Assets[name]();
				gameSounds[name] = sound;
			}
			
			return gameSounds[name];
		}
	}
}