class PauseManager : GameObject
{ 
	bool pause = false;
	bool loading = false;
	bool leaving = false;
	bool resuming = false;
	uint m_color = white;
	TextButton@ resumeButton;
	TextButton@ mainMenu;
	vector2 touchPauseLimit = 32;
	InterpolationTimer@ timer = InterpolationTimer(300);
	InterpolationTimer@ resumeTimer = InterpolationTimer(3000);
	
	string getTag()
	{
		return "PauseManager";
	}
	
	void create()
	{
		pause = false;
		resuming = false;
		m_color = ARGB(100,GetColorFromIdx(CURRENT_COLOR));
		@resumeButton = TextButton(vector2(GetScreenSize().x/2, GetScreenSize().y*0.4), "RESUME", "Verdana64.fnt");
		@mainMenu = TextButton(vector2(GetScreenSize().x/2, GetScreenSize().y*0.6), "MAIN MENU", "Verdana64.fnt");
		touchPauseLimit = GetScreenSize() - vector2(100,100)*GetScale();

	}
	
	void update()
	{
		//DrawRectangle(touchPauseLimit, GetScreenSize(), white, white, white, white);
	
		if(pause)
		{
			if(!resuming)
			{
				
				if(resumeButton.isPressed() && !loading && !leaving)
				{
					loading = true;
					g_adManager.hideAd();
					resumeButton.setPressed(false);
				}
				if(mainMenu.isPressed() && !loading && !leaving)
				{
					leaving = true;
					mainMenu.setPressed(false);
				}

				if(loading)
				{
					timer.update();
					uint newColor = ARGB(uint(100.0f * (1-timer.getBias())), GetColorFromIdx(CURRENT_COLOR));
					uint newButtonColor = ARGB(uint(255.0f * (1-timer.getBias())),255,255,255);
					resumeButton.setColor(newButtonColor);
					mainMenu.setColor(newButtonColor);
					DrawShapedSprite("sprites/square.png", V2_ZERO, GetScreenSize(), newColor);
					if(timer.isOver())
					{
						loading = false;
						resuming = true;
					}
				}
				else if(leaving)
				{
					timer.update();
					uint newColor = ARGB(uint(255.0f * timer.getBias()),0,0,0);
					uint newButtonColor = ARGB(uint(255.0f * (1.0f-timer.getBias())),255,255,255);
					resumeButton.setColor(newButtonColor);
					mainMenu.setColor(newButtonColor);
					DrawShapedSprite("sprites/square.png", V2_ZERO, GetScreenSize(), m_color);
					DrawShapedSprite("sprites/square.png", V2_ZERO, GetScreenSize(), newColor);
					if(timer.isOver())
					{
						leaving = false;
						resuming = true;
						g_sceneManager.setCurrentScene(MainMenuScene());
					}
				}
				else
				{
					DrawShapedSprite("sprites/square.png", V2_ZERO, GetScreenSize(), m_color);
				}
				
				resumeButton.update();
				mainMenu.update();
				
			}
			else
			{
				resumeTimer.update();
				float new = float(1+uint(3*(1-resumeTimer.getBias())))/1.0f;
				DrawText(""+new, "Verdana64.fnt", GetScreenSize()/2);
				if(resumeTimer.isOver())
				{
					pause = false;
				}
			}
		}
		else 
		{
			if(!GAME_OVER && !isEnergyOn())
				if(GetInputHandle().GetTouchState(0) == KS_HIT)
				{
					vector2 touchPos = GetInputHandle().GetTouchPos(0);
					if(touchPos.x > touchPauseLimit.x && touchPos.y > touchPauseLimit.y)
					{
						setPause();
					}
				}
		}
	}
	
	void resume()
	{
		setPause();
	}
	
	float getFactor()
	{
		if(!pause)
			return 1.0f;
		return 0.0f;
	}
	
	void setPause()
	{
		pause = true;
		resuming = false;
		loading = false;
		leaving = false;
		timer.reset(300);
		resumeTimer.reset(3000);
		resumeTimer.setFilter(@defaultFilter);
		g_adManager.showAd();
		resumeButton.setColor(white);
		mainMenu.setColor(white);
	}
}

PauseManager g_pauseManager;