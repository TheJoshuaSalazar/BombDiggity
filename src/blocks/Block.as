package blocks
{
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.extensions.PDParticleSystem;
	import starling.textures.Texture;

	public class Block extends Sprite
	{
		private var _hardness:int;

		private var _positionX:int;
		private var _positionY:int;
		
		private var _rowIndex:int;
		private var _columnIndex:int;
		
		private var _visible:Boolean;
		private var texture:Image;
		private var _textureName:String;
		
		private var _goldProximityParticleType:int;
		
		private var _adjacentGoldRowIndex:int;
		private var _adjacentGoldColumnIndex:int;
		
		private var _goldObtained:Boolean;
		private var _uncovered:Boolean;

		private var goldProximityParticle:PDParticleSystem;
		
		
		public function Block(x:int, y:int, textureType:String)
		{
			positionX = x;
			positionY = y;
			
			textureName = textureType;
			
			switch(textureName)
			{
				case "DirtTexture":
					hardness = 1;
					break;
				
				case "ClayTexture":
					hardness = 1;
					break;
				
				case "RockTexture":
					hardness = 2;
					break;
				
				case "ObsidianTexture1":
					hardness = 5;
					break;
					
				case "WaterTexture":
					hardness = 1;
					break;
				
				case "MagmaTexture":
					hardness = 1;
					break;
				
				case "GoldTexture":
					hardness = 1;
					break;
				
				case "NullTexture":
					break;
			}
			
			goldProximityParticleType = 0;
			
			goldObtained= false;
			 
			uncovered = false;
			
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			addEventListener(TouchEvent.TOUCH, clicked);
		}

		private function onAdded(event:Event):void
		{
			texture = new Image(Assets.getTexture("Ash"));
			
			texture.width = 50;
			texture.height = 50;
			
			texture.x = Math.ceil(-texture.width / 2) + positionX;
			texture.y = Math.ceil(-texture.height / 2) + positionY;
			
			addChild(texture);
		}
		
		public function reveal():void
		{
			removeChild(texture);
			
			texture = new Image(Assets.getTexture(textureName));
			
			texture.width = 50;
			texture.height = 50;
			
			texture.x = Math.ceil(-texture.width / 2) + positionX;
			texture.y = Math.ceil(-texture.height / 2) + positionY;
			
			addChild(texture);
			
			uncovered = true;
		}
		
		public function clicked(event:TouchEvent):void 
		{
			var touch:Touch = event.getTouch(this, TouchPhase.BEGAN);
			
			if(touch && uncovered)
			{	
				dispatchEvent(new Event("Boom", true, this));
			}
		}
		
		public function makeGoldProximityParticle(particleType:Class):void
		{
			goldProximityParticle = new PDParticleSystem(XML(new particleType()),
				Texture.fromBitmap(new AssetsParticles.ParticleTexture()));
			
			Starling.juggler.add(goldProximityParticle);
			
			goldProximityParticle.x = positionX;
			goldProximityParticle.y = positionY;
			goldProximityParticle.scaleX = 0.2
			goldProximityParticle.scaleY = 0.2;
			goldProximityParticle.start(1);
			addChild(goldProximityParticle);
		}
		
		public function explode():void
		{
			if(textureName != "GoldTexture" &&
				textureName != "WaterTexture" &&
				textureName != "MagmaTexture")
			{
				visible = false;
			}
		}
		
		public function getGold():void
		{
			visible = false;
		}
		
		public function shatter():void
		{
			if(textureName == "WaterTexture" || textureName == "MagmaTexture")
			{
				textureName = "NullTexture";
				
				visible = false;
			}
		}

		public function get hardness():int
		{
			return _hardness;
		}

		public function set hardness(value:int):void
		{
			_hardness = value;
		}
		
		public function get rowIndex():int
		{
			return _rowIndex;
		}
		
		public function set rowIndex(value:int):void
		{
			_rowIndex = value;
		}
		
		public function get columnIndex():int
		{
			return _columnIndex;
		}
		
		public function set columnIndex(value:int):void
		{
			_columnIndex = value;
		}
		
		public function get textureName():String
		{
			return _textureName;
		}
		
		public function set textureName(value:String):void
		{
			_textureName = value;
		}

		public function get positionX():int
		{
			return _positionX;
		}

		public function set positionX(value:int):void
		{
			_positionX = value;
		}

		public function get positionY():int
		{
			return _positionY;
		}

		public function set positionY(value:int):void
		{
			_positionY = value;
		}
		
		public function get goldProximityParticleType():int
		{
			return _goldProximityParticleType;
		}
		
		public function set goldProximityParticleType(value:int):void
		{
			_goldProximityParticleType = value;
		}
		
		public function get adjacentGoldColumnIndex():int
		{
			return _adjacentGoldColumnIndex;
		}
		
		public function set adjacentGoldColumnIndex(value:int):void
		{
			_adjacentGoldColumnIndex = value;
		}
		
		public function get adjacentGoldRowIndex():int
		{
			return _adjacentGoldRowIndex;
		}
		
		public function set adjacentGoldRowIndex(value:int):void
		{
			_adjacentGoldRowIndex = value;
		}
		
		public function get goldObtained():Boolean
		{
			return _goldObtained;
		}
		
		public function set goldObtained(value:Boolean):void
		{
			_goldObtained = value;
		}
		
		public function get uncovered():Boolean
		{
			return _uncovered;
		}
		
		public function set uncovered(value:Boolean):void
		{
			_uncovered = value;
		}
	}
}