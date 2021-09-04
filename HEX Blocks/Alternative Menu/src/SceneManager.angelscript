#include "Scene.angelscript"

class SceneManager
{

	uint m_currentTime = 0;
	Scene@ m_currentScene;

	void setCurrentScene(Scene@ scene)
	{
		//if(m_currentTime>0)
		//addTime(m_currentTime);
		m_currentTime=0;
		setScene(scene);
	}
	
	void setCurrentScene(Scene@ scene, bool change)
	{
		//if(m_currentTime>0)
		//addTime(m_currentTime);
		m_currentTime=0;
		if(change)
			setScene(scene);
	}
	
	void setScene(Scene@ scene)
	{
		@m_currentScene = @scene;
		LoadScene(
			scene.getSceneFileName(),
			"onSceneCreated",
			"onSceneUpdate",
			"onResume",
			scene.getBucketSize());
	}

	void runOnSceneCreatedFunction()
	{
		if (m_currentScene !is null)
			m_currentScene.onCreated();
	}

	void runOnSceneUpdateFunction()
	{
		if (m_currentScene !is null)
		{	
			m_currentScene.onUpdate();
			m_currentTime+=GetLastFrameElapsedTime();
		}
	}

	void runOnResumeFunction()
	{
		if (m_currentScene !is null)
			m_currentScene.onResume();
	}
}

SceneManager g_sceneManager;

void onSceneCreated()
{
	g_sceneManager.runOnSceneCreatedFunction();
}

void onSceneUpdate()
{
	g_sceneManager.runOnSceneUpdateFunction();
}

void onResume()
{
	g_sceneManager.runOnResumeFunction();
}
