package
{
	import events.NavigationEvents;
	
	import levels.Level;
	import levels.Level1;
	import levels.Level2;
	import levels.Level3;
//	import levels.Level4;
	import levels.Tutorial;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Game extends Sprite
	{
		private var currentLevel:Level;
		private var currentLevelName:String;
		private var store:Store;
		private var winScreen:WinScreen;
		private var creditScreen:CreditScreen;
		private var newBombs:int;
		private var startScreen:TitleScreen;
		private var goldGenerated:int;
		
		private var firstTutorial:Boolean;
		private var showTutorial1:Boolean;
		private var showTutorial2:Boolean;
		private var showTutorial3:Boolean;
		private var showTutorial4:Boolean;
		private var showTutorial5:Boolean;
		private var showTutorial6:Boolean;
		
		public function Game()
		{
			super();
			Assets.getSound("BackGroundMusic").play(0,99);

			addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		protected function onAddedToStage(event:Event):void
		{
			firstTutorial = true;
			
			addEventListener(events.NavigationEvents.CHANGE_SCREEN, onChangeScreen);
			
			winScreen = new WinScreen();
			winScreen.visible = false;
			
			creditScreen = new CreditScreen();
			creditScreen.visible = false;
			
			store = new Store();
			addChild(store);
			
			startScreen = new TitleScreen();
			addChild(startScreen);
		}
		
		private function onChangeScreen(event:NavigationEvents):void
		{
			switch(event.params.id)
			{
				case "Play":
					store.visible = false;
					
					if(currentLevelName == "Tutorial")
					{
						if(firstTutorial)
						{
							store.bombCount = 3;
							
							firstTutorial = false;
							showTutorial1 = true;
							showTutorial2 = true;
							showTutorial3 = true;
							showTutorial4 = true;
							showTutorial5 = false;
							showTutorial6 = false;
						}
						
						currentLevel.initialize(store.bombCount, store.goldCount, store.betterBombCount, store.frostBombCount, goldGenerated, currentLevelName);
						
						currentLevel.initializeTutorial(showTutorial1, showTutorial2, showTutorial3, 
							showTutorial4, showTutorial6);
					}
					else
					{
						currentLevel.initialize(store.bombCount, store.goldCount, store.betterBombCount, store.frostBombCount, goldGenerated, currentLevelName);
					}
					
					currentLevel.visible = true;
					break;
				
				case "Store":
					currentLevel.visible = false;
					
					store.initalize(currentLevel.goldCount, currentLevelName, currentLevel.gameOver, 
						currentLevel.bombCount, currentLevel.betterBombCount, currentLevel.frostBombCount);
					break;
				
				case "ResetShop":
					store.bombCount = 5;
					store.betterBombCount = 0;
					store.frostBombCount = 1;
					store.goldCount = 0;
					dispatchEvent(new NavigationEvents(NavigationEvents.CHANGE_SCREEN, {id: "Level 1"}, true));
					break;
				
				case "Resume":
					store.visible = false;
					currentLevel.visible = true;
					currentLevel.takeStoreItems(store.currentBasic,store.currentBetter,store.currentFrost,store.goldCount);
					
					if(currentLevelName == "Tutorial")
					{
						if(showTutorial5)
						{
							currentLevel.initializeTutorial5();
						}
						
						if(showTutorial6)
						{
							currentLevel.initializeTutorial6();
						}
					}
					
					break;
				
				case "Winner":
					currentLevel.visible = false;
					addChild(winScreen);
					winScreen.visible = true;
					break;
				
				case "Credits":
					removeChild(startScreen);
					removeChild(winScreen);
					creditScreen.visible = true;
					addChild(creditScreen);
					break;
					
				case "Title Screen":
					firstTutorial = true;
					
					startScreen.visible = true;
					addChild(startScreen);
					break;
				
				case "Level 1":
					removeChild(currentLevel);
					
					goldGenerated = 2;
					
					currentLevel = new Level1();
					currentLevelName = "Level 1";
					
					addChild(currentLevel);
					
					dispatchEvent(new NavigationEvents(NavigationEvents.CHANGE_SCREEN, {id: "Play"}, true));
					break;
				
				case "Level 2":
					removeChild(currentLevel);
					
					goldGenerated = 3;
					
					currentLevel = new Level2();
					currentLevelName = "Level 2";
					
					addChild(currentLevel);
					
					dispatchEvent(new NavigationEvents(NavigationEvents.CHANGE_SCREEN, {id: "Play"}, true));
					break;
				
				case "Level 3":
					removeChild(currentLevel);
					
					goldGenerated = 4;
					
					currentLevel = new Level3();
					currentLevelName = "Level 3";
					
					addChild(currentLevel);
					
					dispatchEvent(new NavigationEvents(NavigationEvents.CHANGE_SCREEN, {id: "Play"}, true));
					break;
				
//				case "Level 4":
//					removeChild(currentLevel);
//					
//					goldGenerated = 4;
//					
//					currentLevel = new Level4();
//					currentLevelName = "Level 4";
//					
//					addChild(currentLevel);
//					
//					dispatchEvent(new NavigationEvents(NavigationEvents.CHANGE_SCREEN, {id: "Play"}, true));
//					break;
				
				case "Tutorial":				
					removeChild(currentLevel);
					
					goldGenerated = 5;
					
					currentLevel = new Tutorial();
					currentLevelName = "Tutorial";
					
					addChild(currentLevel);
					
					dispatchEvent(new NavigationEvents(NavigationEvents.CHANGE_SCREEN, {id: "Play"}, true));
					break;
				
				case "Send Gold":
					currentLevel.visible = false;
					
					store.initalize(currentLevel.goldCount, currentLevelName, currentLevel.gameOver,currentLevel.bombCount,currentLevel.betterBombCount,currentLevel.frostBombCount);
					break;
				
				case "Tutorial 1 Complete":
					showTutorial1 = false;
					break;

				case "Tutorial 2 Complete":
					showTutorial2 = false;
					break;
				
				case "Tutorial 3 Complete":
					showTutorial3 = false;
					break;
				
				case "Tutorial 4 Complete":
					showTutorial4 = false;
					break;
				
				case "Show Tutorial 5":
					showTutorial5 = true;
					break;
				
				case "Tutorial 5 Complete":
					showTutorial5 = false;
					break;
				
				case "Show Tutorial 6":
					showTutorial6 = true;
					break;
			}
		}
	}
}