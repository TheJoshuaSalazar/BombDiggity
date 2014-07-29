package
{
	import events.NavigationEvents;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	
	public class Store extends Sprite
	{
		private var bg:Image;
		private var buyButton1:Button;
		private var buyButton2:Button;
		private var buyButton3:Button;
		private var restartButton:Button;
		private var goldBar:Image;
		private var bombCounterText:TextField;
		private var betterBombCounterText:TextField;
		private var frostBombCounterText:TextField;
		private var levelName:String;
		private var levelOver:Boolean;
		public var currentBasic:int;
		public var currentBetter:int;
		public var currentFrost:int;
		public var goldCount:int;
		public var goldAmount:TextField;
		public var bombCount:int;
		public var betterBombCount:int;
		public var frostBombCount:int;
		
		private var showTutorial5:Boolean;
		private var tutorialShownOnce:Boolean;
		private var showTutorial6:Boolean;
		
		public function Store()
		{
			super();
			bombCount = 5;
			betterBombCount = 0;
			frostBombCount = 1;
			goldCount = 0;
			
			showTutorial5 = false;
			showTutorial6 = false;
			tutorialShownOnce = false;
		}
		
		public function initalize(gold:int, level:String, over:Boolean, basicBombs:int, betterBombs:int, frostBombs:int):void
		{
			visible = true;
			
			goldCount = gold;
			levelName = level;
			levelOver = over;
			
			currentBasic = basicBombs;
			currentBetter = betterBombs;
			currentFrost = frostBombs;
			
			drawScreen();
		}
		
		private function drawScreen():void
		{
			if(levelName == "Tutorial" || levelName == "Level 1")
			{
				bg = new Image(Assets.getTexture("firstStoreScreen"));
				bg.width = 600;
				addChild(bg);
			}
			else
			{
				bg = new Image(Assets.getTexture("secondStoreScreen"));
				bg.width = 600;
				addChild(bg);
				
				buyButton3 = new Button(Assets.getTexture("Buy"));
				buyButton3.width = 200;
				buyButton3.height = 100;
				buyButton3.x = 360;
				buyButton3.y = 550;
				addChild(buyButton3);
				
				frostBombCounterText = new TextField(200,30,"Frost Bombs: " + frostBombCount.toString(), "Veranda", 18, 0x000000);
				frostBombCounterText.x = 360;
				frostBombCounterText.y = 655;
				
				if(!levelOver)
					frostBombCounterText.text = "Frost Bombs: " + currentFrost.toString();
				
				addChild(frostBombCounterText);
			}
			
			buyButton1 = new Button(Assets.getTexture("Buy"));
			buyButton1.width = 200;
			buyButton1.height = 100;
			buyButton1.x = 360;
			buyButton1.y = 200;
			addChild(buyButton1);
			
			buyButton2 = new Button(Assets.getTexture("Buy"));
			buyButton2.width = 200;
			buyButton2.height = 100;
			buyButton2.x = 360;
			buyButton2.y = 350;
			addChild(buyButton2);
			
			restartButton = new Button(Assets.getTexture("Restart"));
			restartButton.width = 600;
			restartButton.height = 75;
			restartButton.x = 0;
			restartButton.y = 725;
			addChild(restartButton);
			
			goldBar = new Image(Assets.getTexture("GoldTexture"));
			goldBar.width = 100;
			goldBar.height = 30;
			goldBar.x = 40;
			goldBar.y = 110;
			addChild(goldBar);
			
			goldAmount = new TextField(100,30,"Gold: " + goldCount.toString(),"Verdana", 18, 0x000000);
			goldAmount.x = 40;
			goldAmount.y = 110;
			addChild(goldAmount);
			
			bombCounterText = new TextField(100,30,"Bombs: " + bombCount.toString(), "Veranda", 18, 0x000000);
			bombCounterText.x = 410;
			bombCounterText.y = 290;
			if(!levelOver)
				bombCounterText.text = "Bombs: " + currentBasic.toString();
			addChild(bombCounterText);
			
			betterBombCounterText = new TextField(200,30,"Better Bombs: " + betterBombCount.toString(), "Veranda", 18, 0x000000);
			betterBombCounterText.x = 360;
			betterBombCounterText.y = 445;
			if(!levelOver)
				betterBombCounterText.text = "Better Bombs: " + currentBetter.toString();
			addChild(betterBombCounterText);
			
			addEventListener(Event.TRIGGERED, onMainMenuClick);
		}
		
		private function onMainMenuClick(event:Event):void
		{
			var buttonClicked:Button = event.target as Button;
			
			if((buttonClicked as Button) == buyButton1)
			{
				if(goldCount > 0)
				{
					bombCount++;
					
					if(!levelOver)
						currentBasic++;
					
					goldCount--;
					goldAmount.text = "Gold: " + goldCount.toString();
					bombCounterText.text = "Bombs: " + bombCount.toString();
					
					if(!levelOver)
						bombCounterText.text = "Bombs: " + currentBasic.toString();
					
					showTutorial6 = true;
				}
			}
			if((buttonClicked as Button) == buyButton2)
			{
				if(goldCount > 2)
				{
					betterBombCount++;
					
					if(!levelOver)
						currentBetter++;
					
					goldCount -= 3;
					goldAmount.text = "Gold: " + goldCount.toString();
					betterBombCounterText.text = "Better Bombs: " + betterBombCount.toString();
					
					if(!levelOver)
						betterBombCounterText.text = "Better Bombs: " + currentBetter.toString();
					
					showTutorial5 = true;
					showTutorial6 = true;
				}
			}
			if((buttonClicked as Button) == buyButton3)
			{
				if(goldCount > 1)
				{
					frostBombCount++;
					
					if(!levelOver)
						currentFrost++;
					
					goldCount -= 2;
					goldAmount.text = "Gold: " + goldCount.toString();
					frostBombCounterText.text = "Frost Bombs: " + frostBombCount.toString();
					
					if(!levelOver)
					
						frostBombCounterText.text = "Frost Bombs: " + currentFrost.toString();
				}
			}
			if((buttonClicked as Button) == restartButton)
			{
				visible = false;
				
				removeChild(bg);
				removeChild(buyButton1);
				removeChild(buyButton2);
				removeChild(buyButton3);
				removeChild(restartButton)
				removeChild(goldBar);
				removeChild(bombCounterText);
				removeChild(betterBombCounterText);
				removeChild(frostBombCounterText);
				removeChild(goldAmount);
				
				if(levelOver)
					dispatchEvent(new NavigationEvents(NavigationEvents.CHANGE_SCREEN, {id: "Play"}, true));
				else
				{
					if(showTutorial5 && !tutorialShownOnce)
					{
						tutorialShownOnce = true;
						
						dispatchEvent(new NavigationEvents(NavigationEvents.CHANGE_SCREEN, {id: "Show Tutorial 5"}, true));
					}
					else
					{
						dispatchEvent(new NavigationEvents(NavigationEvents.CHANGE_SCREEN, {id: "Tutorial 5 Complete"}, true));
					}
					
					if(showTutorial6)
					{
						dispatchEvent(new NavigationEvents(NavigationEvents.CHANGE_SCREEN, {id: "Show Tutorial 6"}, true));
					}
					
					dispatchEvent(new NavigationEvents(NavigationEvents.CHANGE_SCREEN, {id: "Resume"}, true));
				}
			}
		}
	}
}