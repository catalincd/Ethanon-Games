class SceneManager
{
	Scene@ currentScene;
	Scene@ nextScene;
	
	void setSceneNow(Scene@ newScene)
	{
		if(Alert.hoc)Alert.hide();
		@currentScene = newScene;
		LoadScene(currentScene.sceneName, create, update, resume, bucketSize);
	}
	
	void setNextScene()
	{
		setSceneNow(nextScene);
	}
	
	void setScene(Scene@ _nextScene)
	{
		@nextScene = _nextScene;
		g_transition.start();
	}
	
	void create()
	{
		g_execute.create();
		if(currentScene !is null)
			currentScene.create();
		
	}
	
	void update()
	{
		g_execute.update();
	
		if(currentScene !is null)
			currentScene.update();
			
		Alert.update();
		g_transition.update();
		
	}
	
	void resume()
	{
		g_spriteManager.load();
		g_execute.resume();
		if(currentScene !is null)
			currentScene.resume();
		
	}
	
}

SceneManager g_sceneManager;

void setScene(Scene@ scene)
{
	g_sceneManager.setScene(scene);
}

void createScene()
{
	g_sceneManager.create();
}

void updateScene()
{
	g_sceneManager.update();
}

void resumeScene()
{
	g_sceneManager.resume();
}