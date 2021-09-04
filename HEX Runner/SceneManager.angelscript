#include "Scene.angelscript"

class SceneManager
{
	Scene@ m_currentScene;

	void setCurrentScene(Scene@ scene)
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
			m_currentScene.onUpdate();
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
	g_playedTimeManager.create();
	g_sceneManager.runOnSceneCreatedFunction();
}

void onSceneUpdate()
{
	g_playedTimeManager.update();
	g_sceneManager.runOnSceneUpdateFunction();
	//DrawShapedSprite("sprites/square.png", V2_ZERO, vector2(GetScreenSize().x, 60), ARGB(180, 255,255,255));
}

void onResume()
{
	g_loader.resume();
	g_sceneManager.runOnResumeFunction();
}
