class SceneManager
{
	Scene@ m_currentScene;
	Scene@ m_nextScene;
	
	bool transitioning = false;
	bool ascending = true;
	Timer@ timer;
	
	void setSceneNow(Scene@ newScene)
	{
		@m_currentScene = newScene;
		LoadScene(m_currentScene.m_sceneName, CREATE, UPDATE, RESUME, m_currentScene.m_bucketSize);
	}
	
	void setNextScene()
	{
		if(m_nextScene !is null)
			setSceneNow(m_nextScene);
	}
	
	void setScene(Scene@ newScene)
	{	
		@m_nextScene = newScene;
		transitioning = true;
		ascending = true;
		@timer = Timer(transitionTime);
	}

	void create()
	{
		m_currentScene.create();
	}
	
	void update()
	{
		
		m_currentScene.update();
		updateTransition();
	}
	
	void resume()
	{
		m_currentScene.resume();
		g_spriteManager.load();
		loadCharacters();
	}
	
	void updateTransition()
	{
		if(transitioning)
		{
			timer.update();
			uint op = uint((ascending? timer.getBias() : 1 - timer.getBias()) * 255.0f);
			uint color = ARGB(op, 207, 239, 252);
			DrawShapedSprite("sprites/white.png", V2_ZERO, GetScreenSize(), color);
			if(timer.isOver() && ascending)
			{
				timer.reset(transitionTime);
				ascending = false;
				setNextScene();
			}
			if(timer.isOver() && !ascending)
			{
				transitioning = false;
			}
		}
	}
}

uint transitionTime = 350;

SceneManager g_sceneManager;

void onCreate()
{
	g_sceneManager.create();
}

void onUpdate()
{
	g_sceneManager.update();
}

void onResume()
{
	g_sceneManager.resume();
}