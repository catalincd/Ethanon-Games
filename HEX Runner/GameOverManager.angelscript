class GameOverManager : GameObject
{

	uint elapsedTime;
	InterpolationTimer@ m_timer = InterpolationTimer(500);
	bool LOADING = true;
	
	void create()
	{
		LOADING = true;
		m_timer.reset(500);
		m_timer.setFilter(@smoothBeginning);
	}
	
	void resume()
	{
		
	}
	
	string getTag()
	{
		return "GameOverManager";
	}
	
	void update()
	{
		if(!GAME_OVER)
		{
			if(LOADING)
			{
				uint overlayColor = ARGB(uint(255.0f*(1-m_timer.getBias())),0,0,0);
			//	DrawShapedSprite("sprites/square.png", V2_ZERO, GetScreenSize(), overlayColor);
				m_timer.update();
				if(m_timer.isOver())
				{
					LOADING = false;
				}
			}
		}
		else
		{	
			uint GAME_OVER_ELAPSED = GetTime() - GAME_OVER_TIME;
			if(GAME_OVER_ELAPSED <= 700)
			{
			
			}
			else if(GAME_OVER_ELAPSED > 700 && GAME_OVER_ELAPSED <= 2000)
			{
			
			}
			else if(GAME_OVER_ELAPSED > 2000 && GAME_OVER_ELAPSED < 3000)
			{	
				uint overlayColor = ARGB(uint((float(GAME_OVER_ELAPSED-2000) / 1000.0f)*255),0,0,0);
				DrawShapedSprite("sprites/square.png", V2_ZERO, GetScreenSize(), overlayColor);
			}
			else
			{
				DrawShapedSprite("sprites/square.png", V2_ZERO, GetScreenSize(), COLOR_BLACK);
				g_sceneManager.setCurrentScene(MainMenuScene());
			}
		}
	}
}

bool GAME_OVER = false;
bool BLOWN = false;
uint GAME_OVER_TIME = 0;
GameOverManager g_gameOverManager;