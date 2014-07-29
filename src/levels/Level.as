package levels
{
	import com.greensock.TweenLite;
	import com.greensock.data.TweenLiteVars;
	
	import blocks.Block;
	
	import events.NavigationEvents;
	
	import objects.Background;
	
	import starling.animation.DelayedCall;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.extensions.PDParticleSystem;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	
	public class Level extends Sprite
	{
		private const JamieButt:Boolean = false;
		
		private var background:Background;
		private var backgroundName:String = "Background1";
		
		public var bombCount:int;
		public var betterBombCount:int;
		public var frostBombCount:int;
		protected var totalBombs:int;
		
		private var basicBombImage:Image;
		private var betterBombImage:Image;
		private var frostBombImage:Image;
		protected var currentBombImage:Image;
		private var depletedBombs:Image;
		
		private var basicBombWidth:int;
		private var basicBombHeight:int;
		private var betterBombWidth:int;
		private var betterBombHeight:int;
		private var frostBombWidth:int;
		private var frostBombHeight:int;
		
		protected var expandWidthTimer:Number;
		protected var expandHeightTimer:Number;
		
		protected var expandingWidth:Boolean;
		protected var expandingHeight:Boolean;

		private var basicAmount:TextField;
		private var betterAmount:TextField;
		private var frostAmount:TextField;
		
		private var bombType:String;
		
		protected var bombing:Boolean;
		
		private var explosionParticles:PDParticleSystem;
		private var goldRevealParticle:PDParticleSystem;
		private var goldTrailParticle:PDParticleSystem;
		private var goldReceivedParticle:PDParticleSystem;
		private var splashParticle:PDParticleSystem;
		
		public var goldCount:int;
		protected var goldGenerated:int;
		protected var goldGenerationRows:int = 6;
		protected var goldGenerationColumns:int = 9;
		protected var goldGenerationRowOffset:int = 2;
		
		protected var goldAmount:TextField;
		
		protected var goldBlocks:Array;

		protected var button1:Button;
		protected var button2:Button;
		protected var button3:Button;
		
		public var gameOver:Boolean;
		
		private var timePrevious:Number;
		private var timeCurrent:Number;
		private var elapsed:Number;
		
		protected var MAX_LAYERS:int;
		protected var MAX_BLOCKS_PER_LAYER:int;
		
		protected var row1:Array = new Array(10);
		protected var row2:Array = new Array(10);
		protected var row3:Array = new Array(10);
		protected var row4:Array = new Array(10);
		protected var row5:Array = new Array(10);
		protected var row6:Array = new Array(10);
		protected var row7:Array = new Array(10);
		protected var row8:Array = new Array(10);
		protected var row9:Array = new Array(10);
		protected var row10:Array = new Array(10);
		
		protected var map:Array = new Array(10);
		
		private var jamieButton1:Button;
		private var jamieButton2:Button;
		
		private var retryLevelButton:Button;
		private var storeLevelButton:Button;
		
		protected var levelName:String;
		protected var levelComplete:Boolean;
		
		protected var button1Active:Boolean;
		protected var button2Active:Boolean;
		protected var button3Active:Boolean;
		private var hasBombs1:Boolean;
		private var hasBombs2:Boolean;
		private var hasBombs3:Boolean;
		private var bombless:DelayedCall;

		public function Level()
		{
			super();
		}
		
		public function initialize(totalBombs:int, totalGold:int, totalBetter:int, 
								   totalFrost:int, totalGoldGenerated:int, level:String):void
		{
			gameOver = false;
			
			visible = true;
			
			bombType = "Basic";
			bombCount = totalBombs;
			betterBombCount = totalBetter;
			frostBombCount = totalFrost;
			
			basicBombWidth = 40;
			basicBombHeight = 40;
			betterBombWidth = 50;
			betterBombHeight = 40;
			frostBombWidth = 40;
			frostBombHeight = 40;
			
			bombing = false;
			
			expandWidthTimer = 0;
			expandHeightTimer = 0;
			
			goldCount = totalGold;
			goldGenerated = totalGoldGenerated;
			
			goldBlocks = new Array(goldGenerated);
			
			levelName = level;
			
			button1Active = true;
			button2Active = false;
			button3Active = false;
			
			if(bombCount > 0)
				hasBombs1 = true;
			if(betterBombCount > 0)
				hasBombs2 = true;
			else
				hasBombs2 = false;
			if(levelName != "Level 1" && levelName != "Tutorial")
				if(frostBombCount>0)
					hasBombs3 = true;
				else
					hasBombs3 = false;
			
			background = new Background(backgroundName);
			addChild(background);
			
			//First Button - Basic Bomb
			button1 = new Button(Assets.getTexture("ActiveButton"));
			button1.height = 46;
			button1.width = 110;
			button1.x = 5;
			button1.y = 2;
			addChild(button1);
			
			basicBombImage = new Image(Assets.getTexture("BasicBomb"));
			basicBombImage.x = 20;
			basicBombImage.y = 5;
			basicBombImage.width = basicBombWidth;
			basicBombImage.height = basicBombHeight;
			basicBombImage.touchable = false;
			addChild(basicBombImage);
			
			basicAmount = new TextField(50, 25, "X " + bombCount.toString(), "Verdana", 18, 0x000000);
			basicAmount.x = 55;
			basicAmount.y = 15;
			basicAmount.touchable = false;
			addChild(basicAmount);
			
			//Second Button - Better Bomb
			button2 = new Button(Assets.getTexture("UnactiveButton"));
			button2.height = 46;
			button2.width = 110;
			button2.x = 130;
			button2.y = 2;
			addChild(button2);
			
			betterBombImage = new Image(Assets.getTexture("BetterBomb"));
			betterBombImage.x = 140;
			betterBombImage.y = 4;
			betterBombImage.width = betterBombWidth;
			betterBombImage.height = betterBombHeight;
			betterBombImage.touchable = false;
			addChild(betterBombImage);
			
			betterAmount = new TextField(50, 25, "X " + betterBombCount.toString(), "Verdana", 18, 0x000000);
			betterAmount.x = 180;
			betterAmount.y = 15;
			betterAmount.touchable = false;
			addChild(betterAmount);
			
			if(levelName != "Level 1" && levelName != "Tutorial")
			{
				//Third Button - Frost Bomb
				button3 = new Button(Assets.getTexture("UnactiveButton"));
				button3.height = 46;
				button3.width = 110;
				button3.x = 255;
				button3.y = 2;
				addChild(button3);
			
				frostBombImage = new Image(Assets.getTexture("FrostBomb"));
				frostBombImage.x = 270;
				frostBombImage.y = 5;
				frostBombImage.width = frostBombWidth;
				frostBombImage.height = frostBombHeight;
				frostBombImage.touchable = false;
				addChild(frostBombImage);
				
				frostAmount = new TextField(50, 25, "X " + frostBombCount.toString(), "Verdana", 18, 0x000000);
				frostAmount.x = 305;
				frostAmount.y = 15;
				frostAmount.touchable = false;
				addChild(frostAmount);
			}
			
			//Gold Image and Counter
			var gold:Image = new Image(Assets.getTexture("GoldTexture"));
			gold.y = 60;
			gold.width = 60;
			gold.height = 40;
			addChild(gold);
			
			goldAmount = new TextField(40, 30, goldCount.toString(),"Verdana", 18, 0x000000);
			goldAmount.hAlign = HAlign.LEFT;
			goldAmount.vAlign = VAlign.TOP;
			goldAmount.x = 18;
			goldAmount.y = 65;
			addChild(goldAmount);
			
			//Retry Level and Mid-game store button
			retryLevelButton = new Button(Assets.getTexture("RetryIcon"));
			retryLevelButton.y = 60;
			retryLevelButton.x = 65;
			retryLevelButton.width = 50;
			retryLevelButton.height = 50;
			addChild(retryLevelButton);
			
			storeLevelButton= new Button(Assets.getTexture("GoToStore"));
			storeLevelButton.y = 60;
			storeLevelButton.x = 130;
			storeLevelButton.width = 100;
			storeLevelButton.height = 50;
			addChild(storeLevelButton);
			
			if(JamieButt)
			{
				//Debug-Jamie Buttons
				jamieButton1 = new Button(Assets.getTexture("JamieButton1"));
				jamieButton1.width = 80;
				jamieButton1.height = 40;
				jamieButton1.x = 510;
				jamieButton1.y = 0;
				jamieButton1.addEventListener(Event.TRIGGERED, clairvoyance);
				addChild(jamieButton1);
				
				jamieButton2 = new Button(Assets.getTexture("JamieButton2"));
				jamieButton2.width = 100;
				jamieButton2.height = 100;
				jamieButton2.x = 385;
				jamieButton2.y = 40;
				jamieButton2.addEventListener(Event.TRIGGERED, goldenRule);
				addChild(jamieButton2);
			}
			
			makeMap();
			
			closeToGold();
			
			depletedBombs = new Image(Assets.getTexture("OutOfBombs"));
			depletedBombs.x = -116;
			depletedBombs.y = 200;
			depletedBombs.visible = false;
			depletedBombs.touchable = false;

			addEventListener(Event.ENTER_FRAME, onGameTick);
			
			addEventListener("Boom", bombTheBlock);
			
			addEventListener(Event.TRIGGERED, onButtonClick);
		}
		
		public function initializeTutorial(showTutorial1:Boolean, showTutorial2:Boolean, 
										   showTutorial3:Boolean, showTutorial4:Boolean,
										   showTutorial6:Boolean):void
		{}
		
		public function initializeTutorial5():void
		{}
		
		public function initializeTutorial6():void
		{}
		
		protected function makeMap():void
		{
			MAX_LAYERS = 10;
			MAX_BLOCKS_PER_LAYER = 10;
			
			var randomTexture:int;
			
			var randomTextureName:String;
			
			hardCodeLevel();
			
			map[0] = row1;
			map[1] = row2;
			map[2] = row3;
			map[3] = row4;
			map[4] = row5;
			map[5] = row6;
			map[6] = row7;
			map[7] = row8;
			map[8] = row9;
			map[9] = row10;
			
			for( var j:uint = 0; j < MAX_LAYERS; j++ )
			{
				for( var k:uint = 0; k < MAX_BLOCKS_PER_LAYER; k++ )
				{
					map[0][k].reveal();
					
					map[j][k].rowIndex = j;
					map[j][k].columnIndex = k;
					
					addChild(map[j][k]);
				}
			}
			
			insertGold(goldGenerated);
		}
		
		protected function insertGold(numGold:int):void
		{
			for(var i:int; i < numGold; i++)
			{
				var randomRowIndex:int = Math.floor(Math.random() * (goldGenerationRows)) + goldGenerationRowOffset;
				var randomColumnIndex:int = Math.floor(Math.random() * (1 + goldGenerationColumns));
				
				while(map[randomRowIndex][randomColumnIndex].textureName == "GoldTexture")
				{
					randomRowIndex = Math.floor(Math.random() * (goldGenerationRows)) + goldGenerationRowOffset;
					randomColumnIndex = Math.floor(Math.random() * (1 + goldGenerationColumns));
				}
				
				map[randomRowIndex][randomColumnIndex].textureName = "GoldTexture";
				
				goldBlocks[i] = map[randomRowIndex][randomColumnIndex];
			}
		}
		
		private function closeToGold():void
		{
			for(var i:int = 0; i < goldBlocks.length; i++)
			{			
				if(goldBlocks[i].rowIndex - 2 >= 0)
				{
					for(var j:int = goldBlocks[i].columnIndex - 2; j <= goldBlocks[i].columnIndex + 2; j++)
					{
						if(j >= 0 && j < MAX_BLOCKS_PER_LAYER && map[goldBlocks[i].rowIndex - 2][j].goldProximityParticleType == 0)
						{
							map[goldBlocks[i].rowIndex - 2][j].goldProximityParticleType = 2;
							map[goldBlocks[i].rowIndex - 2][j].adjacentGoldRowIndex = goldBlocks[i].rowIndex;
							map[goldBlocks[i].rowIndex - 2][j].adjacentGoldColumnIndex = goldBlocks[i].columnIndex;
						}
					}
				}
				
				if(goldBlocks[i].rowIndex + 2 < MAX_LAYERS)
				{
					for(var k:int = goldBlocks[i].columnIndex - 2; k <= goldBlocks[i].columnIndex + 2; k++)
					{
						if(k >= 0 && k < MAX_BLOCKS_PER_LAYER && map[goldBlocks[i].rowIndex + 2][k].goldProximityParticleType == 0)
						{
							map[goldBlocks[i].rowIndex + 2][k].goldProximityParticleType = 2;
							map[goldBlocks[i].rowIndex + 2][k].adjacentGoldRowIndex = goldBlocks[i].rowIndex;
							map[goldBlocks[i].rowIndex + 2][k].adjacentGoldColumnIndex = goldBlocks[i].columnIndex;
						}
					}
				}
				
				if(goldBlocks[i].columnIndex - 2 >= 0)
				{
					for(var l:int = goldBlocks[i].rowIndex - 2; l <= goldBlocks[i].rowIndex + 2; l++)
					{
						if(l >= 0 && l < MAX_LAYERS && map[l][goldBlocks[i].columnIndex - 2].goldProximityParticleType == 0)
						{
							map[l][goldBlocks[i].columnIndex - 2].goldProximityParticleType = 2;
							map[l][goldBlocks[i].columnIndex - 2].adjacentGoldRowIndex = goldBlocks[i].rowIndex;
							map[l][goldBlocks[i].columnIndex - 2].adjacentGoldColumnIndex = goldBlocks[i].columnIndex;
						}
					}
				}
				
				if(goldBlocks[i].columnIndex + 2 < MAX_BLOCKS_PER_LAYER)
				{
					for(var m:int = goldBlocks[i].rowIndex - 2; m <= goldBlocks[i].rowIndex + 2; m++)
					{
						if(m >= 0 && m < MAX_LAYERS && map[m][goldBlocks[i].columnIndex + 2].goldProximityParticleType == 0)
						{
							map[m][goldBlocks[i].columnIndex + 2].goldProximityParticleType = 2;
							map[m][goldBlocks[i].columnIndex + 2].adjacentGoldRowIndex = goldBlocks[i].rowIndex;
							map[m][goldBlocks[i].columnIndex + 2].adjacentGoldColumnIndex = goldBlocks[i].columnIndex;
						}
					}
				}
				
				if(goldBlocks[i].rowIndex - 1  > 0)
				{
					map[goldBlocks[i].rowIndex - 1][goldBlocks[i].columnIndex].goldProximityParticleType = 1;
					map[goldBlocks[i].rowIndex - 1][goldBlocks[i].columnIndex].adjacentGoldRowIndex = goldBlocks[i].rowIndex;
					map[goldBlocks[i].rowIndex - 1][goldBlocks[i].columnIndex].adjacentGoldColumnIndex = goldBlocks[i].columnIndex;
				}
				
				if(goldBlocks[i].rowIndex + 1 < MAX_LAYERS)
				{
					map[goldBlocks[i].rowIndex + 1][goldBlocks[i].columnIndex].goldProximityParticleType = 1;
					map[goldBlocks[i].rowIndex + 1][goldBlocks[i].columnIndex].adjacentGoldRowIndex = goldBlocks[i].rowIndex;
					map[goldBlocks[i].rowIndex + 1][goldBlocks[i].columnIndex].adjacentGoldColumnIndex = goldBlocks[i].columnIndex;
				}
				
				if(goldBlocks[i].columnIndex - 1 > 0)
				{
					map[goldBlocks[i].rowIndex][goldBlocks[i].columnIndex - 1].goldProximityParticleType = 1;
					map[goldBlocks[i].rowIndex][goldBlocks[i].columnIndex - 1].adjacentGoldRowIndex = goldBlocks[i].rowIndex;
					map[goldBlocks[i].rowIndex][goldBlocks[i].columnIndex - 1].adjacentGoldColumnIndex = goldBlocks[i].columnIndex;
				}
				
				if(goldBlocks[i].columnIndex + 1 < MAX_BLOCKS_PER_LAYER)
				{
					map[goldBlocks[i].rowIndex][goldBlocks[i].columnIndex + 1].goldProximityParticleType = 1;
					map[goldBlocks[i].rowIndex][goldBlocks[i].columnIndex + 1].adjacentGoldRowIndex = goldBlocks[i].rowIndex;
					map[goldBlocks[i].rowIndex][goldBlocks[i].columnIndex + 1].adjacentGoldColumnIndex = goldBlocks[i].columnIndex;
				}
				
				if(goldBlocks[i].rowIndex - 1 > 0 && goldBlocks[i].columnIndex - 1 > 0)
				{
					map[goldBlocks[i].rowIndex - 1][goldBlocks[i].columnIndex - 1].goldProximityParticleType = 1;
					map[goldBlocks[i].rowIndex - 1][goldBlocks[i].columnIndex - 1].adjacentGoldRowIndex = goldBlocks[i].rowIndex;
					map[goldBlocks[i].rowIndex - 1][goldBlocks[i].columnIndex - 1].adjacentGoldColumnIndex = goldBlocks[i].columnIndex;
				}
				
				if(goldBlocks[i].rowIndex + 1 < MAX_LAYERS && goldBlocks[i].columnIndex - 1 > 0)
				{
					map[goldBlocks[i].rowIndex + 1][goldBlocks[i].columnIndex - 1].goldProximityParticleType = 1;
					map[goldBlocks[i].rowIndex + 1][goldBlocks[i].columnIndex - 1].adjacentGoldRowIndex = goldBlocks[i].rowIndex;
					map[goldBlocks[i].rowIndex + 1][goldBlocks[i].columnIndex - 1].adjacentGoldColumnIndex = goldBlocks[i].columnIndex;
				}
				
				if(goldBlocks[i].rowIndex - 1 > 0 && goldBlocks[i].columnIndex + 1 < MAX_BLOCKS_PER_LAYER)
				{
					map[goldBlocks[i].rowIndex - 1][goldBlocks[i].columnIndex + 1].goldProximityParticleType = 1;
					map[goldBlocks[i].rowIndex - 1][goldBlocks[i].columnIndex + 1].adjacentGoldRowIndex = goldBlocks[i].rowIndex;
					map[goldBlocks[i].rowIndex - 1][goldBlocks[i].columnIndex + 1].adjacentGoldColumnIndex = goldBlocks[i].columnIndex;
				}
				
				if(goldBlocks[i].rowIndex + 1 < MAX_LAYERS && goldBlocks[i].columnIndex + 1 < MAX_BLOCKS_PER_LAYER)
				{
					map[goldBlocks[i].rowIndex + 1][goldBlocks[i].columnIndex + 1].goldProximityParticleType = 1;
					map[goldBlocks[i].rowIndex + 1][goldBlocks[i].columnIndex + 1].adjacentGoldRowIndex = goldBlocks[i].rowIndex;
					map[goldBlocks[i].rowIndex + 1][goldBlocks[i].columnIndex + 1].adjacentGoldColumnIndex = goldBlocks[i].columnIndex;
				}
			}
		}
		
		protected function hardCodeLevel():void
		{}
		
		private function bombTheBlock(event:Event):void
		{
			if(levelName != "Level 1" && levelName != "Tutorial")
			{
				if(bombCount == 0 && betterBombCount == 0 && frostBombCount == 0)
				{
					bombless = new DelayedCall(summonBombless, 1.2);
					Starling.juggler.add(bombless);
				}	
			}
			else
			{
				if(bombCount == 0 && betterBombCount == 0)
				{
					bombless = new DelayedCall(summonBombless, 1.2);
					Starling.juggler.add(bombless);
				}
			}
			
			if(!gameOver && !bombing)
			{	
				var block:Block = event.data as Block;
				
				var row:int = block.rowIndex;
				var column:int = block.columnIndex;

				if(map[row][column].textureName != "GoldTexture")
				{
					expandingWidth = true;
					expandingHeight = true;
					
					switch(bombType)
					{
						case "Basic":
							if(bombCount <= 0)
							{
								break;
							}
							
							if(map[row][column].textureName != "WaterTexture" &&
								map[row][column].textureName != "MagmaTexture" &&
								map[row][column].textureName != "NullTexture")
							{
								bombing = true;
								
								cameraShake();
								
								bombCount--;
								if(hasBombs2 == true && bombCount == 0)
									button2Method();
								if(levelName != "Level 1" && levelName != "Tutorial")
									if(hasBombs2 == false && hasBombs3 == true && bombCount == 0)
										button3Method();
								
								basicAmount.text = "X " + bombCount.toString();
								
								currentBombImage = new Image(Assets.getTexture("BasicBomb"));
								currentBombImage.x = 20;
								currentBombImage.y = 5;
								currentBombImage.width = basicBombWidth;
								currentBombImage.height = basicBombHeight;
								addChild(currentBombImage);
								
								TweenLite.to(currentBombImage, 1, new TweenLiteVars({x:map[row][column].positionX -
									15, y:map[row][column].positionY - 25}).onComplete(checkBasicExplosion, [row, column]));
								
								Assets.getSound("BasicExplosion").play();
							}
							
							break;
						
						case "Better":
							if(betterBombCount <= 0)
							{
								break;
							}
							
							if(map[row][column].textureName != "WaterTexture" &&
								map[row][column].textureName != "MagmaTexture" &&
								map[row][column].textureName != "NullTexture")
							{
								bombing = true;
								
								betterBombCount--;
								if(hasBombs1 == true && betterBombCount == 0)
									button1Method();
								if(levelName != "Level 1" && levelName != "Tutorial")
									if(hasBombs1 == false && hasBombs3 == true && betterBombCount == 0)
										button3Method();
								
								betterAmount.text = "X " + betterBombCount.toString();
								
								currentBombImage = new Image(Assets.getTexture("BetterBomb"));
								currentBombImage.x = 140;
								currentBombImage.y = 4;
								currentBombImage.width = betterBombWidth;
								currentBombImage.height = betterBombHeight;
								addChild(currentBombImage);
								
								TweenLite.to(currentBombImage, 1, new TweenLiteVars({x:map[row][column].positionX -
									25, y:map[row][column].positionY - 20}).onComplete(checkBetterExplosion, [row, column]));
								
								Assets.getSound("BetterExplosion").play();
							}
							break;
						
						case "Frost":
							if(frostBombCount <= 0)
							{
								break;
							}
							
							if(map[row][column].textureName == "WaterTexture" || map[row][column].textureName == "MagmaTexture")
							{
								bombing = true;
								
								frostBombCount--;
								if(hasBombs1 == true && frostBombCount == 0)
									button1Method();
								else if(hasBombs2 == true && frostBombCount == 0)
									button2Method();
								
								frostAmount.text = "X " + frostBombCount.toString();
								
								currentBombImage = new Image(Assets.getTexture("FrostBomb"));
								currentBombImage.x = 270;
								currentBombImage.y = 5;
								currentBombImage.width = frostBombWidth;
								currentBombImage.height = frostBombHeight;
								addChild(currentBombImage);
								
								TweenLite.to(currentBombImage, 1, new TweenLiteVars({x:map[row][column].positionX - 20, y:map[row][column].positionY - 20}).onComplete(checkFrostExplosion, [row, column]));
								
								Assets.getSound("IceShatter").play();
							}
							break;
					}
				}
			}
		}
		
		private function checkBasicExplosion(row:int, column:int):void
		{
			map[row][column].hardness--;
			
			makeExplosion(map[row][column].positionX, map[row][column].positionY,
				.6, .6, .4, AssetsParticles.ExplosionParticle1);
			
			if(row > 0)
			{
				map[row - 1][column].hardness--;
				
				makeExplosion(map[row - 1][column].positionX, map[row - 1][column].positionY,
				.6, .6, .4, AssetsParticles.ExplosionParticle1);
			}
			
			if(row < 9)
			{
				map[row + 1][column].hardness--;
				
				makeExplosion(map[row + 1][column].positionX, map[row + 1][column].positionY,
					.6, .6, .4, AssetsParticles.ExplosionParticle1);
			}
			
			if(column > 0)
			{
				map[row][column - 1].hardness--;
				
				makeExplosion(map[row][column - 1].positionX, map[row][column - 1].positionY,
					.6, .6, .4, AssetsParticles.ExplosionParticle1);
			}
			
			if(column < 9)
			{
				map[row][column + 1].hardness--;
				
				makeExplosion(map[row][column + 1].positionX, map[row][column + 1].positionY,
					.6, .6, .4, AssetsParticles.ExplosionParticle1);
			}
			
			if(map[row][column].hardness <= 0)
			{
				map[row][column].explode();
				
				if(row > 0)
				{
					if(map[row - 1][column].hardness <= 0)
					{
						map[row - 1][column].explode();
					}
				}
				
				if(row < 9)
				{
					if(map[row + 1][column].hardness <= 0)
					{
						map[row + 1][column].explode();
					}
				}
				
				if(column > 0)
				{
					if(map[row][column - 1].hardness <= 0)
					{
						map[row][column - 1].explode();
					}
				}
				
				if(column < 9)
				{
					if(map[row][column + 1].hardness <= 0)
					{
						map[row][column + 1].explode();
					}
				}
			}
			
			removeChild(currentBombImage);
			
			bombing = false;
			
			checkMapState();
		}
		
		private function checkBetterExplosion(row:int, column:int):void
		{
			map[row][column].hardness -= 2;
			
			makeExplosion(map[row][column].positionX, map[row][column].positionY,
				1, 1, .4, AssetsParticles.ExplosionParticle1);
			
			if(row > 0)
			{
				map[row - 1][column].hardness--;
				
				makeExplosion(map[row - 1][column].positionX, map[row - 1][column].positionY,
					.6, .6, .4, AssetsParticles.ExplosionParticle1);
			}
			
			if(row < 9)
			{
				map[row + 1][column].hardness--;
				
				makeExplosion(map[row + 1][column].positionX, map[row + 1][column].positionY,
					.6, .6, .4, AssetsParticles.ExplosionParticle1);
			}
			
			if(column > 0)
			{
				map[row][column - 1].hardness--;
				
				makeExplosion(map[row][column - 1].positionX, map[row][column - 1].positionY,
					.6, .6, .4, AssetsParticles.ExplosionParticle1);	
			}
			
			if(column < 9)
			{
				map[row][column + 1].hardness--;
				
				makeExplosion(map[row][column + 1].positionX, map[row][column + 1].positionY,
					.6, .6, .4, AssetsParticles.ExplosionParticle1);
			}
			
			if(row > 0 && column > 0)
			{
				map[row - 1][column - 1].hardness--;
				
				makeExplosion(map[row - 1][column - 1].positionX, map[row - 1][column - 1].positionY,
					.6, .6, .4, AssetsParticles.ExplosionParticle1);
			}
			
			if(row > 0 && column < 9 )
			{
				map[row - 1][column + 1].hardness--;
				
				makeExplosion(map[row - 1][column + 1].positionX, map[row - 1][column + 1].positionY,
					.6, .6, .4, AssetsParticles.ExplosionParticle1);
			}
			
			if(row < 9 && column < 9)
			{
				map[row + 1][column + 1].hardness--;

				makeExplosion(map[row + 1][column + 1].positionX, map[row + 1][column + 1].positionY,
					.6, .6, .4, AssetsParticles.ExplosionParticle1);
			}
			
			if(row < 9 && column > 0)
			{
				map[row + 1][column - 1].hardness--;
				
				makeExplosion(map[row + 1][column - 1].positionX, map[row + 1][column - 1].positionY,
					.6, .6, .4, AssetsParticles.ExplosionParticle1);
			}
			
			if(map[row][column].hardness <= 0)
			{
				map[row][column].explode();
				
				if(row > 0)
				{
					if(map[row - 1][column].hardness <= 0)
					{
						map[row - 1][column].explode();
					}
				}
				
				if(row < 9)
				{
					if(map[row + 1][column].hardness <= 0)
					{
						map[row + 1][column].explode();
					}
				}
				
				if(column > 0)
				{
					if(map[row][column - 1].hardness <= 0)
					{
						map[row][column - 1].explode();
					}
				}
				
				if(column < 9)
				{
					if(map[row][column + 1].hardness <= 0)
					{
						map[row][column + 1].explode();
					}
				}
				
				if(row > 0 && column > 0)
				{
					if(map[row - 1][column - 1].hardness <= 0)
					{
						map[row - 1][column - 1].explode();
					}
				}
				
				if(row > 0 && column < 9 )
				{
					if(map[row - 1][column + 1].hardness <= 0)
					{
						map[row - 1][column + 1].explode();
					}
				}
				
				if(row < 9 && column < 9)
				{
					if(map[row + 1][column + 1].hardness <= 0)
					{
						map[row + 1][column + 1].explode();
					}
				}
				
				if(row < 9 && column > 0)
				{
					if(map[row + 1][column - 1].hardness <= 0)
					{
						map[row + 1][column - 1].explode();
					}
				}
			}
			
			removeChild(currentBombImage);
			
			bombing = false;
			
			checkMapState();
		}
		
		private function checkFrostExplosion(row:int, column:int):void
		{
			if(map[row][column].textureName == "WaterTexture")
			{
				makeExplosion(map[row][column].positionX, map[row][column].positionY,
					.2, .2, .4, AssetsParticles.FrostParticle);
				
				map[row][column].shatter();
				
				if(row > 0)
				{
					if(map[row - 1][column].textureName == "WaterTexture")
					{
						makeExplosion(map[row - 1][column].positionX, map[row - 1][column].positionY,
							.2, .2, .4, AssetsParticles.FrostParticle);
					}
					
					map[row - 1][column].shatter();
				}
				
				if(row < 9)
				{
					if(map[row + 1][column].textureName == "WaterTexture")
					{
						makeExplosion(map[row + 1][column].positionX, map[row + 1][column].positionY,
							.2, .2, .4, AssetsParticles.FrostParticle);
					}
					
					map[row + 1][column].shatter();
				}
				
				if(column > 0)
				{
					if(map[row][column - 1].textureName == "WaterTexture")
					{
						makeExplosion(map[row][column - 1].positionX, map[row][column - 1].positionY,
							.2, .2, .4, AssetsParticles.FrostParticle);
					}
					
					map[row][column - 1].shatter();
				}
				
				if(column < 9)
				{
					if(map[row][column + 1].textureName == "WaterTexture")
					{
						makeExplosion(map[row][column + 1].positionX, map[row][column + 1].positionY,
							.2, .2, .4, AssetsParticles.FrostParticle);
					}
					
					map[row][column + 1].shatter();
				}
			}
			else if(map[row][column].textureName == "MagmaTexture")
			{
				coolLava(row, column);
			}
			
			removeChild(currentBombImage);
			
			bombing = false;
			
			checkMapState();
		}
		
		private function makeExplosion(x:int, y:int, xScale:Number, yScale:Number, duration:Number, particles:Class):void
		{
			explosionParticles = new PDParticleSystem(XML(new particles()), 
				Texture.fromBitmap(new AssetsParticles.ParticleTexture()));
			
			Starling.juggler.add(explosionParticles);
			explosionParticles.x = x;
			explosionParticles.y = y;
			explosionParticles.scaleX = xScale;
			explosionParticles.scaleY = yScale;
			addChild(explosionParticles);
			explosionParticles.start(duration);
		}
		
		private function checkMapState():void
		{
			for(var i:uint = 0; i < MAX_LAYERS; i++)
			{
				for(var j:uint = 0; j < MAX_BLOCKS_PER_LAYER; j++)
				{	
					if(map[i][j].textureName == "RockTexture" && map[i][j].hardness == 1)
					{
						map[i][j].textureName = "CrackedRockTexture";
					}
					
					if(map[i][j].textureName == "ObsidianTexture1" && map[i][j].hardness == 4)
					{
						map[i][j].textureName = "ObsidianTexture2";
					}
					else if(map[i][j].textureName == "ObsidianTexture2" && map[i][j].hardness == 3)
					{
						map[i][j].textureName = "ObsidianTexture3";
					}
					else if(map[i][j].textureName == "ObsidianTexture3" && map[i][j].hardness == 2)
					{
						map[i][j].textureName = "ObsidianTexture4";
					}
					else if(map[i][j].textureName == "ObsidianTexture4" && map[i][j].hardness == 1)
					{
						map[i][j].textureName = "ObsidianTexture5";
					}
					
					if(i > 0)
					{
						if(!map[i - 1][j].visible)
						{
							map[i][j].reveal();
							
							if(map[i][j].textureName == "GoldTexture" && !map[i][j].goldObtained)
							{
								takeGold(i, j);
							}
						}
					}
					
					if(i < 9)
					{
						if(!map[i + 1][j].visible)
						{
							map[i][j].reveal();
							
							if(map[i][j].textureName == "GoldTexture" && !map[i][j].goldObtained)
							{
								takeGold(i, j);
							}
						}
					}
					
					if(j > 0)
					{
						if(!map[i][j - 1].visible)
						{
							map[i][j].reveal();
							
							if(map[i][j].textureName == "GoldTexture" && !map[i][j].goldObtained)
							{
								takeGold(i, j);
							}
						}
					}
					
					if(j < 9)
					{
						if(!map[i][j + 1].visible)
						{
							map[i][j].reveal();
							
							if(map[i][j].textureName == "GoldTexture" && !map[i][j].goldObtained)
							{
								takeGold(i, j);
							}
						}
					}
					
					if(map[i][j].uncovered && map[i][j].goldProximityParticleType != 0 && !map[map[i][j].adjacentGoldRowIndex][map[i][j].adjacentGoldColumnIndex].uncovered)
					{
						switch(map[i][j].goldProximityParticleType)
						{
							case 0:
								map[i][j].makeGoldProximityParticle(AssetsParticles.GoldParticle0);
								break;
							
							case 1:
								map[i][j].makeGoldProximityParticle(AssetsParticles.GoldParticle1);
								break;
							
							case 2:
								map[i][j].makeGoldProximityParticle(AssetsParticles.GoldParticle2);
								break;
						}
					}
				}
				
				for(var k:int = MAX_LAYERS - 1; k >= 0; k--)
				{
					for(var l:int = MAX_BLOCKS_PER_LAYER - 1; l >= 0; l--)
					{						
						if(k < 9)
						{
							if(map[k][l].textureName == "WaterTexture")
							{
								if(!map[k + 1][l].visible)
								{
									flow(k, l, "WaterTexture", AssetsParticles.WaterSplashParticle);
								}
								else if(map[k + 1][l].goldObtained)
								{
									var waterOnGold:DelayedCall = new DelayedCall(flow, 1.0, [k, l, "WaterTexture", AssetsParticles.WaterSplashParticle]);
									Starling.juggler.add(waterOnGold);
								}								
							}
							else if(map[k][l].textureName == "MagmaTexture")
							{
								if(!map[k + 1][l].visible)
								{
									flow(k, l, "MagmaTexture", AssetsParticles.MagmaSplashParticle);
								}
								else if(map[k + 1][l].goldObtained)
								{
									var magmaOnGold:DelayedCall = new DelayedCall(flow, 1.0, [k, l, "MagmaTexture", AssetsParticles.MagmaSplashParticle]);
									Starling.juggler.add(magmaOnGold);
								}
							}
						}
					}
				}
				
				for(var m:int = MAX_LAYERS - 1; m >= 0; m--)
				{
					for(var n:int = MAX_BLOCKS_PER_LAYER - 1; n >= 0; n--)
					{				
						if(map[m][n].textureName == "MagmaTexture")
						{
							if(m > 0)
							{
								if(map[m - 1][n].textureName == "WaterTexture")
								{
									map[m - 1][n].shatter();
									
									coolLava(m, n);
								}
							}
							
							if(m < 9)
							{
								if(map[m + 1][n].textureName == "WaterTexture")
								{
									map[m][n].shatter();
									
									coolLava(m + 1, n);
								}
							}
							
							if(n > 0)
							{
								if(map[m][n - 1].textureName == "WaterTexture")
								{
									map[m][n - 1].shatter();
									
									coolLava(m, n);
								}

							}
							
							if(n < 9)
							{
								if(map[m][n + 1].textureName == "WaterTexture")
								{
									map[m][n + 1].shatter();
									
									coolLava(m, n);
								}
							}
						}
					}
				}
			
				for each(var b:Block in map[MAX_BLOCKS_PER_LAYER - 1])
				{	
					if(!b.visible)
					{
						gameOver = true;
						victory();
					}
				}
			}
		}
		
		private function flow(row:int, column:int, textureName, splashType:Class):void
		{
			splashParticle = new PDParticleSystem(XML(new splashType()), 
				Texture.fromBitmap(new AssetsParticles.ParticleTexture()));
			
			Starling.juggler.add(splashParticle);
			splashParticle.x = map[row][column].positionX;
			splashParticle.y = map[row][column].positionY;
			splashParticle.scaleX = .34;
			splashParticle.scaleY = .34;
			splashParticle.start(1);
			
			addChild(splashParticle);
			
			map[row][column].shatter();
			
			removeChild(map[row + 1][column]);
			
			map[row + 1][column] = new Block( column * 58 + 40, (row + 1) * 55 + 285, textureName);
			map[row + 1][column].rowIndex = row + 1;
			map[row + 1][column].columnIndex = column;
			
			addChild(map[row + 1][column]);
			
			map[row + 1][column].reveal();
			
			if(row + 2 < MAX_BLOCKS_PER_LAYER)
			{
				if((map[row + 2][column].textureName == "GoldTexture" && 
					map[row + 2][column].uncovered) ||
					!map[row + 2][column].visible && 
					(map[row + 1][column].textureName != "WaterTexture" && map[row + 1][column].textureName != "MagmaTexture"))
				{
					var waterOnGold2:DelayedCall = new DelayedCall(flow, .6, [row + 1, column, textureName, splashType]);
					Starling.juggler.add(waterOnGold2);
				}
			}
		}
		
		private function takeGold(row:int, column:int):void
		{
			map[row][column].goldObtained = true;
			
			goldReveal(map[row][column].positionX, map[row][column].positionY);
			
			var goldMoveX:int = 30 - map[row][column].positionX;
			var goldMoveY:int = 80 - map[row][column].positionY;
			
			TweenLite.to(map[row][column], 1, {x:goldMoveX, y:goldMoveY, delay:1});
			
			goldTrail(map[row][column].positionX, map[row][column].positionY);
			TweenLite.to(goldTrailParticle, 2.5, {x:goldMoveX , y:goldMoveY , delay:1});
			
			var delayedGoldDelete:DelayedCall = new DelayedCall(map[row][column].getGold, 2);
			var delayedGoldParticle:DelayedCall = new DelayedCall(goldReceived, 2);
			Starling.juggler.add(delayedGoldDelete);
			Starling.juggler.add(delayedGoldParticle);
			
			if(row > 0)
			{
				map[row - 1][column].reveal();
				
				if(map[row - 1][column].textureName == "GoldTexture" && !map[row - 1][column].goldObtained)
				{
					takeGold(row - 1, column);
				}
			}
			
			if(row < 9)
			{
				map[row + 1][column].reveal();
				
				if(map[row + 1][column].textureName == "GoldTexture" && !map[row + 1][column].goldObtained)
				{
					takeGold(row + 1, column);
				}
			}
			
			if(column > 0)
			{
				map[row][column - 1].reveal();
				
				if(map[row][column - 1].textureName == "GoldTexture" && !map[row][column - 1].goldObtained)
				{
					takeGold(row, column - 1);
				}
			}
			
			if(column < 9)
			{
				map[row][column + 1].reveal();
				
				if(map[row][column + 1].textureName == "GoldTexture" && !map[row][column + 1].goldObtained)
				{
					takeGold(row, column + 1);
				}
			}
		}
		
		private function goldReveal(xPosition:int, yPosition:int):void
		{
			goldRevealParticle = new PDParticleSystem(XML(new AssetsParticles.GoldRevealParticle()),
				Texture.fromBitmap(new AssetsParticles.ParticleTexture()));
			
			Starling.juggler.add(goldRevealParticle);
			goldRevealParticle.x = xPosition;
			goldRevealParticle.y = yPosition;
			goldRevealParticle.scaleX = 0.09;
			goldRevealParticle.scaleY = 0.09;
			
			goldRevealParticle.start(0.5);
			addChild(goldRevealParticle);
		}
		
		private function goldTrail(xPosition:int, yPosition:int):void
		{
			goldTrailParticle = new PDParticleSystem(XML(new AssetsParticles.GoldTrailParticle()),
				Texture.fromBitmap(new AssetsParticles.ParticleTexture()));
			
			Starling.juggler.add(goldTrailParticle);
			goldTrailParticle.x = xPosition;
			goldTrailParticle.y = yPosition;
			goldTrailParticle.scaleX = 0.1;
			goldTrailParticle.scaleY = 0.1;
			
			goldTrailParticle.start(1);
			addChild(goldTrailParticle);
		}
		
		private function goldReceived():void
		{
			goldCount++;
			
			goldReceivedParticle = new PDParticleSystem(XML(new AssetsParticles.GoldReceiveParticle()),
				Texture.fromBitmap(new AssetsParticles.ParticleTexture()));
			
			Starling.juggler.add(goldReceivedParticle);
			goldReceivedParticle.x = 30;
			goldReceivedParticle.y = 80;
			goldReceivedParticle.scaleX = 0.4;
			goldReceivedParticle.scaleY = 0.4;
			
			goldReceivedParticle.start(.5);
			addChild(goldReceivedParticle);
			
			Assets.getSound("GoldCollect").play();
		}
		
		private function coolLava(row:int, column:int):void
		{
			removeChild(map[row][column]);
			
			map[row][column] = new Block((column * 58) + 40, (row * 55) + 285, "RockTexture");
			
			map[row][column].rowIndex = row;
			
			map[row][column].columnIndex = column;
			
			addChild(map[row][column]);
			
			map[row][column].reveal();
			
			var steamParticle:PDParticleSystem = new PDParticleSystem(XML(new AssetsParticles.SteamParticle()), 
				Texture.fromBitmap(new AssetsParticles.ParticleTexture()));
			
			Starling.juggler.add(steamParticle);
			steamParticle.x = map[row][column].positionX;
			steamParticle.y = map[row][column].positionY;
			steamParticle.scaleX = .6;
			steamParticle.scaleY = .6;
			steamParticle.start(.6);
			
			addChild(steamParticle);
		}
		
		protected function onGameTick(event:Event):void
		{
			goldAmount.text = goldCount.toString();

			if(bombCount == 0)
			{
				button1.upState = Assets.getTexture("DepletedButton");
			}
			if(bombCount < 3 && button1Active == true && bombCount > 0)
			{
				button1.upState = Assets.getTexture("LowButton");
			}
			
			if(betterBombCount == 0)
			{
				button2.upState = Assets.getTexture("DepletedButton");
			}
			if(betterBombCount < 2 && button2Active == true && betterBombCount > 0)
			{
				button2.upState = Assets.getTexture("LowButton");
			}
			
			if(levelName != "Tutorial" && levelName != "Level 1")
			{
				if(frostBombCount == 0)
				{
					button3.upState = Assets.getTexture("DepletedButton");
				}
				if(frostBombCount < 3 && button3Active == true && frostBombCount > 0)
				{
					button3.upState = Assets.getTexture("LowButton");	
				}
			}
			
			if(bombing)
			{				
				if(expandingWidth)
				{
					currentBombImage.width += 20;
					
					if(currentBombImage.width >= 200)
					{
						expandingWidth = false;
					}
				}
				else
				{
					if( currentBombImage.width >= 40)
					{
						currentBombImage.width -= 4;
					}
				}
				
				if(expandingHeight)
				{
					currentBombImage.height += 20;
					
					if(currentBombImage.height >= 200)
					{
						expandingHeight = false;
					}
				}
				else
				{
					if( currentBombImage.height >= 40)
					{
						currentBombImage.height -= 4;
					}
				}
			}
		}
		
		protected function victory():void
		{
			levelComplete = true;
			dispatchEvent(new NavigationEvents(NavigationEvents.CHANGE_SCREEN, {id: "Winner"}, true));
		}

		public function takeStoreItems(basic:int, better:int, frost:int, gil:int):void
		{
			bombCount = basic;
			betterBombCount = better;
			frostBombCount = frost;
			goldCount = gil;
			
			updateText();
		}
		
		private function updateText():void
		{
			basicAmount.text = "X " + bombCount.toString();
			betterAmount.text = "X " + betterBombCount.toString();
			
			if(levelName != "Tutorial" && levelName != "Level 1")
			{
				frostAmount.text = "X " + frostBombCount.toString();
				button3Method();
			}
			
			button2Method();
			button1Method();
			
			if(bombCount > 0)
				button1Method();
			else if(betterBombCount > 0)
			{
				button2Method();
			}
			else if(frostBombCount > 0)
				if(levelName != "Tutorial" && levelName != "Level 1")
					button3Method();
			
			goldAmount.text = goldCount.toString();
		}
		
		private function onButtonClick(event:Event):void
		{
			var buttonClicked:Button = event.target as Button;
			
			switch(buttonClicked)
			{
				case button1:
					if(bombCount != 0)
					{
						button1Method();
					}
					break;
				case button2:
					if(betterBombCount != 0)
					{
						button2Method();
					}
					break;
				case button3:
					if(frostBombCount != 0)
					{
						button3Method();
					}
					break;
				case retryLevelButton:
					dispatchEvent(new NavigationEvents(NavigationEvents.CHANGE_SCREEN, {id: "Send Gold"}, true));
					if(levelName == "Level 1")
						dispatchEvent(new NavigationEvents(NavigationEvents.CHANGE_SCREEN, {id: "Level 1"}, true));
					else if(levelName == "Level 2")
						dispatchEvent(new NavigationEvents(NavigationEvents.CHANGE_SCREEN, {id: "Level 2"}, true));
					else if(levelName == "Level 3")
						dispatchEvent(new NavigationEvents(NavigationEvents.CHANGE_SCREEN, {id: "Level 3"}, true));
					else if(levelName == "Level 4")
						dispatchEvent(new NavigationEvents(NavigationEvents.CHANGE_SCREEN, {id: "Level 4"}, true));
					else if(levelName == "Tutorial")
						dispatchEvent(new NavigationEvents(NavigationEvents.CHANGE_SCREEN, {id: "Tutorial"}, true));
					break;
				case storeLevelButton:
					dispatchEvent(new NavigationEvents(NavigationEvents.CHANGE_SCREEN, {id: "Store"}, true));
					break;
			}
		}

		private function button1Method():void
		{
			if(bombCount != 0)
			{
				button1.upState = Assets.getTexture("ActiveButton");
			}
			else
			{
				button1.upState = Assets.getTexture("DepletedButton");
			}
			
			button2.upState = Assets.getTexture("UnactiveButton");
			
			if(levelName != "Tutorial" && levelName != "Level 1")
				button3.upState = Assets.getTexture("UnactiveButton");
			
			bombType = "Basic";
			button1Active = true;
			button2Active = false;
			button3Active = false;
		}
		
		private function button2Method():void
		{
			button1.upState = Assets.getTexture("UnactiveButton");
			
			if(betterBombCount != 0)
			{
				button2.upState = Assets.getTexture("ActiveButton");
			}
			else
			{
				button2.upState = Assets.getTexture("DepletedButton");
			}
			
			button2.downState = Assets.getTexture("ActiveButton");
			
			if(levelName != "Level 1" && levelName != "Tutorial")
				button3.upState = Assets.getTexture("UnactiveButton");
			
			bombType = "Better";
			button1Active = false;
			button2Active = true;
			button3Active = false;
		}
		
		private function button3Method():void
		{
			button1.upState = Assets.getTexture("UnactiveButton");
			button2.upState = Assets.getTexture("UnactiveButton");
			
			if(frostBombCount != 0)
			{
				button3.upState = Assets.getTexture("ActiveButton");
			}
			else
			{
				button3.upState = Assets.getTexture("DepletedButton");
			}
			
			button3.downState = Assets.getTexture("ActiveButton");
			bombType = "Frost";
			button1Active = false;
			button2Active = false;
			button3Active = true;
		}
		
		private function clairvoyance(event:Event):void
		{
			for( var j:uint = 0; j < MAX_LAYERS; j++ )
			{
				for( var k:uint = 0; k < MAX_BLOCKS_PER_LAYER; k++ )
				{
					map[j][k].reveal();
				}
			}
		}
			
		private function goldenRule():void
		{
			goldCount += 99;
		}
		
		private function cameraShake():void
		{
			x = Math.random() *10;
			y = Math.random() *10;
		}

		private function outOfTimer():void
		{
			depletedBombs.visible = false;
			removeChild(depletedBombs);
		}
		
		private function summonBombless():void
		{
			depletedBombs.visible = true;
			addChild(depletedBombs);
			var delayImage:DelayedCall = new DelayedCall(outOfTimer, 2);
			Starling.juggler.add(delayImage);
		}
	}
}