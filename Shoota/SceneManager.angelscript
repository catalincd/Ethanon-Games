#include "Scene.angelscript"

bool LOADING_OVERLAY = false;

class SceneManager
{
	Scene@ m_currentScene;
	Scene@ nextScene;

	bool transitioning = false;
	uint transColor = 255;
	bool fadeOut = true;
	bool outF = false;
	uint animTime = 250;
	InterpolationTimer@ transTimer = InterpolationTimer(animTime);


	void transition(Scene@ next)
	{	
		fadeOut = true;
		outF = false;
		@nextScene = next;
		transColor = 255;
		transition();
	}
	
	void transitionGame(Scene@ next)
	{
		fadeOut = false;
		outF = false;
		@nextScene = next;
		transColor = 255;
		transition();
	}
	
	void transitionBack()
	{
		if(!transitioning)
		{
			fadeOut = true;
			outF = true;
			transColor = 0;
			transition();
		}
	}

	void transition()
	{
		transitioning = true;
	}
	
	void updateTransition()
	{
		if(transitioning)
		{
			transTimer.update();
			float bias = outF? 1.0f-transTimer.getBias() : transTimer.getBias();
			uint color = ARGB(255.0f * bias, transColor,transColor,transColor);
			DrawShapedSprite("sprites/square.png", V2_ZERO, GetScreenSize(), color);
			
			if(LOADING_OVERLAY)
			{
				DrawText("LOADING..", text128, vector2(SS_50.x, SS_50.y), black, V2_HALF);
			}
			
			if(transTimer.isOver())
			{
				if(outF)
				{
					LOADING_OVERLAY = false;
					transitioning = false;
					transTimer.reset(animTime);
				}
				else
				{
					setCurrentScene(@nextScene);
					if(fadeOut)
					{
						transTimer.reset(animTime);
						outF = true;
					}
					else
					{
						transitioning = false;
						transTimer.reset(animTime);
					}
				}
			}
		}
	}
	
	void updateLoadingOverlay()
	{
		if(GetSharedData("LOADING") == "Y")
		{
			LoadScene("empty");
			SetSharedData("LOADING", "N");
		}
		DrawText(V2_ZERO, ""+vector2ToString(GetInputHandle().GetTouchMove(0)), "Verdana30.fnt", black);
		DrawText(vector2(0,50), ""+GetInputHandle().GetTouchMove(0).y / GetScale(), "Verdana30.fnt", black);
	}
	
	void setCurrentScene(Scene@ scene)
	{
		@m_currentScene = @scene;
		LoadScene(
			scene.getSceneFileName(),
			"onSceneCreated",
			"onSceneUpdate",
			"onSceneResume",
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
		updateTransition();
		//updateLoadingOverlay();
	}

	void runOnResumeFunction()
	{	
	//	g_sceneManager.setCurrentScene(LoadingScene());
		g_loader.load();
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

void onSceneResume()
{
	g_sceneManager.runOnResumeFunction();
}
