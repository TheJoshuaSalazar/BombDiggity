package levels
{
	import blocks.Block;
	
	import events.NavigationEvents;
	
	import starling.animation.DelayedCall;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;

	public class Tutorial extends Level
	{
		private var nextButton:Button;
		private var skipButton:Button;
		
		private var tutorial1:Image;
		private var tutorial2:Image;
		private var tutorial3:Image;
		private var tutorial4:Image;
		private var tutorial5:Image;
		private var tutorial6:Image;
		
		private var findGoldTutorial:Boolean;
		private var foundGoldTutorial:Boolean;

		private var hideTutorial2:Boolean;
		

		
		public function Tutorial()
		{
			super();
			
			hideTutorial2 = false;
		}
		
		override public function initializeTutorial(showTutorial1:Boolean, showTutorial2:Boolean, 
													showTutorial3:Boolean, showTutorial4:Boolean,
													showTutorial6:Boolean):void
		{
			if(showTutorial1)
			{
				tutorial1 = new Image(Assets.getTexture("ClickSquare"));
				
				initializeTutorialBlock(tutorial1, 55, 315, 400, 100);
				
				dispatchEvent(new NavigationEvents(NavigationEvents.CHANGE_SCREEN, {id: "Tutorial 1 Complete"}, true));
			}
			
			if(showTutorial2)
			{
				tutorial2 = new Image(Assets.getTexture("ClickRetry"));
				
				dispatchEvent(new NavigationEvents(NavigationEvents.CHANGE_SCREEN, {id: "Tutorial 2 Complete"}, true));
			}
			
			findGoldTutorial = showTutorial3;
			
			foundGoldTutorial = showTutorial4;
			
			if(showTutorial6)
			{
				initializeTutorial6();
			}
		}
		
		override public function initializeTutorial5():void
		{
				tutorial5 = new Image(Assets.getTexture("ClickDifferentBomb"));
				
				initializeTutorialBlock(tutorial5, 130, 46, 300, 80);
				
				var removeTutorial5:DelayedCall = new DelayedCall(removeTutorialBlock, 2, [tutorial5]);
				
				Starling.juggler.add(removeTutorial5);
		}
		
		override public function initializeTutorial6():void
		{
			removeChild(tutorial1);
			removeChild(tutorial2);
			removeChild(tutorial3);
			removeChild(tutorial4);

			
			tutorial6 = new Image(Assets.getTexture("ReachTheBottom"));
			
			initializeTutorialBlock(tutorial6, 300, 180, 300, 75);
		}
		
		override protected function insertGold(numGold:int):void
		{
			for(var i:int; i < numGold; i++)
			{
				goldGenerationRows = 5;
				goldGenerationRowOffset = 3;
				
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
		
		override protected function hardCodeLevel():void
		{	
			for(var i:uint = 0; i < MAX_BLOCKS_PER_LAYER; i++)
			{
				row1[i] = new Block((i * 58) + 40, 285, "DirtTexture");
				row2[i] = new Block((i * 58) + 40, 340, "DirtTexture");
				row3[i] = new Block((i * 58) + 40, 395, "DirtTexture");
				row4[i] = new Block((i * 58) + 40, 450, "DirtTexture");
				row5[i] = new Block((i * 58) + 40, 505, "DirtTexture");
				row6[i] = new Block((i * 58) + 40, 560, "DirtTexture");
				row7[i] = new Block((i * 58) + 40, 615, "DirtTexture");
				row8[i] = new Block((i * 58) + 40, 670, "DirtTexture");
				row9[i] = new Block((i * 58) + 40, 725, "DirtTexture");
				row10[i] = new Block((i * 58) + 40, 780, "DirtTexture");
			}
		}
		
		private function initializeTutorialBlock(tutorialImage:Image,
												 imageX:int, imageY:int,
												 imageWidth:int, imageHeight:int):void
		{
			tutorialImage.x = imageX;
			tutorialImage.y = imageY;
			tutorialImage.width = imageWidth;
			tutorialImage.height = imageHeight;
			tutorialImage.touchable = false;
			tutorialImage.visible = true;
			addChild(tutorialImage);
		}
		
		override protected function onGameTick(event:Event):void
		{
			goldAmount.text = goldCount.toString();
			
			if(tutorial1 && bombing)
			{
				removeChild(tutorial1);
			}
			
			if(tutorial2 && bombCount == 0 && betterBombCount == 0 && !hideTutorial2)
			{				
				var delayTutorial2:DelayedCall = new DelayedCall(initializeTutorialBlock, 1,
					[tutorial2, 60, 108, 300, 75]);
				
				Starling.juggler.add(delayTutorial2);
				
				hideTutorial2 = true;
			}
			
			for(var i:int = MAX_LAYERS - 1; i >= 0; i--)
			{
				for(var j:int = MAX_BLOCKS_PER_LAYER - 1; j >= 0; j--)
				{		
					if(map[i][j].uncovered && map[i][j].goldProximityParticleType > 0 && 
						findGoldTutorial && bombCount != 0)
					{
						tutorial3 = new Image(Assets.getTexture("FindGold"));
						
						initializeTutorialBlock(tutorial3, 
							map[i][j].positionX - 25, map[i][j].positionY + 25, 200, 60);
						
						findGoldTutorial = false;
						
						dispatchEvent(new NavigationEvents(NavigationEvents.CHANGE_SCREEN, {id: "Tutorial 3 Complete"}, true));
					}
				}
			}
			
			if(tutorial3 && bombing)
			{
				removeChild(tutorial3);
			}
			
			if(goldCount > 0 && foundGoldTutorial)
			{		
				tutorial4 = new Image(Assets.getTexture("FoundGold"));
				
				initializeTutorialBlock(tutorial4, 228, 55, 260, 60);
				
				foundGoldTutorial = false;

				dispatchEvent(new NavigationEvents(NavigationEvents.CHANGE_SCREEN, {id: "Tutorial 3 Complete"}, true));
				dispatchEvent(new NavigationEvents(NavigationEvents.CHANGE_SCREEN, {id: "Tutorial 4 Complete"}, true));
			}
			
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
	
		private function removeTutorialBlock(tutorial:Image):void
		{
			removeChild(tutorial);
		}
		
		override protected function victory():void
		{
			levelComplete = true;
			var delayedCall:DelayedCall = new DelayedCall(makeButtons, 1.5);
			Starling.juggler.add(delayedCall);
		}
		
		private function makeButtons():void
		{
			skipButton = new Button(Assets.getTexture("SkipButton"));
			skipButton.x = 100;
			skipButton.y = 400;
			skipButton.width *= 0.7;
			skipButton.height *= 0.7;
			skipButton.addEventListener(Event.TRIGGERED, skipTutorial);
			addChild(skipButton);
		}
		
		private function skipTutorial():void
		{
			//Go to the first level of the game.
			dispatchEvent(new NavigationEvents(NavigationEvents.CHANGE_SCREEN, {id: "ResetShop"}, true));
		}
	}
}