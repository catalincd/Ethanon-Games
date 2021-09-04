class MainMenuSceneClass : Scene
{

	FloatBouncer@ backgroundBouncer;
	MainMenuPage@ page;
	uint runs = 0;
	

	MainMenuSceneClass()
	{
		super("empty");
		init();
	}
	
	void init()
	{
		@backgroundBouncer = FloatBouncer(0.0f, 1.0f, A_SLOW * 7);
		backgroundBouncer.setFilter(defaultFilter);
		
		@page = MainMenuPage();
		page.init();
		
		
	}
	
	void create()
	{	
		if(runs == 0)mainInit();
		runs++;
		
		g_spriteManager.load();
		
		page.create();
		
		Alert.create();
	}
	
	void update()
	{
		
		page.update();
		
		backgroundBouncer.update();
		SetBackgroundColor((interpolate(green, cyan, backgroundBouncer.getBounceScale())).getUInt());
	}
	
	
	void resume()
	{
		
	}
}

MainMenuSceneClass MainMenuScene;

void mainMenu()
{
	setScene(MainMenuScene);
}

void casualScene()
{
	setScene(CasualScene);
}

void gameScene()
{
	setScene(GameScene);
}

void settingsScene()
{
	setScene(SettingsScene);
}