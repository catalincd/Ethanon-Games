class GameOverManager : GameObject
{
	Timer@ timer = Timer(300);
	uint overTime = 0;
	bool set = false;

	void create()
	{
		GAME_OVER = false;
		set = false;
	}
	
	void update()
	{
		if(!GAME_OVER && o_world.GameIsOver())
		{
			GAME_OVER = true;
			timer.reset(300);
			overTime = GetTime();
		}
		
		if(GAME_OVER)
		{
			timer.update();
			o_ui.drawGameOverLay(timer.getBias());
			if(GetTime() - overTime > 2000 && !set)
			{
				setScene(MainMenuScene);
				set = true;
				GAME_OVER = false;
			}
		}
	}
	
	void resume()
	{
	
	}
	
	string getTag()
	{
		return "GameOver";
	}
	
}

bool GAME_OVER = false;


GameOverManager o_gameOver;