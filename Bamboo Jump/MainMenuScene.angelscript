class MainMenuScene : Scene
{
	
	MenuButton@ startButton;
	bool nextScene = false;
	
	MainMenuScene()
	{
		super("empty");
	}
	
	void create() override
	{
		if(RUNS == 0)
		{
			begin();
		}
		RUNS++;
		
		PREF_CHAR = parseUInt(dataBase.get("prefChar"));
		
		scoreManager.load();
		
		SetBackgroundColor(backColor);
		nextScene = false;
		@startButton = MenuButton("START", vector2(540*GetScale(), GetScreenSize().y*0.75f), GetScale());
		startButton.setColor(mainColor);
	
		g_selector.create();
	}
	
	void update() override
	{
		scoreManager.draw();
	
		startButton.update();
		if(startButton.isPressed() && !nextScene)
		{
			nextScene = true;
			g_sceneManager.setScene(GameScene());
			dataBase.set("prefChar", ""+PREF_CHAR);
			dataBase.save();
		}
		g_selector.update();
	}
	
	void resume() override
	{
		g_selector.resume();
		SetBackgroundColor(backColor);
	}
}

uint RUNS = 0;