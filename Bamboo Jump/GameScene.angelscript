class GameScene : Scene
{
	GameScene()
	{
		super("empty");
	}

	void create() override
	{
		Objects.create();
	}

	void update() override
	{
		Objects.update();
	}	
	
	void resume() override
	{
		Objects.resume();
	}
}