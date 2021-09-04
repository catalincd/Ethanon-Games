class GameScene : Scene
{
	GameObject@[] objects;

	GameScene()
	{
		const string sceneName = "empty";
		super(sceneName);
	}

	void preCreate()
	{
		objects.resize(0);
		objects.insertLast(g_turret);
		objects.insertLast(g_uiBar);
		objects.insertLast(g_ui);
		objects.insertLast(g_gameSuccess);
		objects.insertLast(g_bulletPoint);
		objects.insertLast(g_bps);
		objects.insertLast(g_hp);
		objects.insertLast(g_itemManager);
		objects.insertLast(g_mapManager);
		objects.insertLast(g_soundManager);
		objects.insertLast(g_sceneCreator);
		objects.insertLast(g_timer);
		objects.insertLast(g_backgroundManager);
		objects.insertLast(g_spawnManager);
		objects.insertLast(g_enemyManager);
		objects.insertLast(g_exp);
		objects.insertLast(g_gameOver);
		objects.insertLast(g_swiper);
		
		
	}

	void onCreated() override
	{	
		GAME_OVER = false;
		GAME_SUCCESS = false;
		FACTOR = 1.0f;
		SetGravity(vector2(0,0));
		SetZAxisDirection(vector2(0,0));
		preCreate();
				
		uint len = objects.length();
		for(uint t=0;t<len;t++)
			objects[t].create();
	}

	void onUpdate() override
	{		
	
		uint len = objects.length();
		for(uint t=0;t<len;t++)
			objects[t].update();
	}
	
	void onResume() override
	{
		uint len = objects.length();
		for(uint t=0;t<len;t++)
			objects[t].resume();
	}
	
}

