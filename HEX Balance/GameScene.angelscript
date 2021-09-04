class GameSceneClass : Scene
{

	

	GameSceneClass()
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

float getVel(float v)
{
	return float(int(v * 100.0f)) / 10.f;
}

GameSceneClass GameScene;