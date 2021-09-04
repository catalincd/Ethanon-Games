class GameSceneClass : Scene
{

	GameSceneClass()
	{
		super("empty");
	}
	
	
	void create() override
	{
		g_gameBackground.create();
		g_maze.create();
		g_camera.create();
		ui.create();
	}
	
	void update() override
	{
		
		g_gameBackground.update();
		g_maze.update();
		g_camera.update();
		ui.update();
	}
	
	
	
	void resume() override
	{
		ui.resume();
		g_maze.resume();
		g_camera.resume();
		SetBackgroundColor(white.getUInt());
	}
}

GameSceneClass GameScene;

