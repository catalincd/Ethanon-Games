#include "Button.angelscript"

class GameScene : Scene
{
	private Button@ m_exitButton;
	uint time = 0;
	bool ended = false;
	bool pause = false;
	GameObject@[] objects;

	GameScene()
	{
		const string sceneName = "empty";
		super(sceneName);
		preCreate();
	}

	void preCreate()
	{
		objects.resize(0);
		objects.insertLast(g_gameEffector);
		objects.insertLast(g_cameraManager);
		objects.insertLast(g_energyManager);
		objects.insertLast(g_effector);
		objects.insertLast(g_gameLayer);		
		objects.insertLast(g_block);
		objects.insertLast(g_creator);
		objects.insertLast(g_backgroundEffector);
		objects.insertLast(g_gameOverManager);
		objects.insertLast(g_timer);
		objects.insertLast(g_scoreManager);
		objects.insertLast(g_speedFactorManager);
		objects.insertLast(g_colorManager);
		objects.insertLast(g_pauseManager);
	}

	void onCreated()
	{
		time = 0;
		COINS = 0;
		BOOST_COINS = 0;
		ended = false;
		GAME_OVER = false;
		NEW_HIGH_SCORE = false;
		//NEW_COLOR_UNLOCKED = false;
		BLOWN = false;
		GAME_OVER_TIME = 0;
		SetGravity(vector2(0,0));
		uint len = objects.length();
		for(uint t=0;t<len;t++)
			objects[t].create();
	}

	void onUpdate()
	{
		//time+=GetLastFrameElapsedTime();
		//DrawScore(time);
		
		
		
		uint len = objects.length();
		for(uint t=0;t<len;t++)
			objects[t].update();
	}
	
	void onResume()
	{
		//g_pauseManager.pause();
		
		
		
		uint len = objects.length();
		for(uint t=0;t<len;t++)
			objects[t].resume();
	}
	
	uint getTimePlayed()
	{
		return time / 1000;
	}
}



void DrawScore(uint time)
{
	uint score = GetScore();
	float factor = float(score)/float(time);
	DrawText(vector2(0,100), "Scale:  "+factor, "Verdana30.fnt", COLOR_WHITE, GetScale());
}


void DrawFPS()
{
	DrawText(vector2(0,0), "FPS: "+uint(GetFPSRate()), "Verdana30.fnt", COLOR_WHITE, GetScale());
}