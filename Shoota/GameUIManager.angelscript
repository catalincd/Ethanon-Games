class UIManager : GameObject
{

	vector2 windowSize;
	vector2 windowPos;
	vector2 windowTopLeft;
	vector2 windowBottomRight;
	float yOffset = 0.0f;
	float RES_OFFSET = 150.0f;
	bool windowUp = false;
	bool windowGoingUp = true;
	bool windowGoingDown = false;
	bool resuming = false;
	InterpolationTimer@ timer = InterpolationTimer(WINDOW_UP);
	TextButton@ returnButton;
	TextButton@ menuButton;
	uint WINDOW_UP = 150;
	vector2 error = V2_ONE * 10;
	uint lastUp = 0;
	uint upStride = 10000;
	bool swipedUp = false;


	void create()
	{
		windowSize = vector2(762, 150)*GetScale();
		windowPos = vector2(GetScreenSize().x/2, GetScreenSize().y);
		windowTopLeft = windowPos - vector2(windowSize.x/2, windowSize.y);
		windowBottomRight = windowTopLeft + windowSize;
		windowUp = false;
		windowGoingUp = true;
		windowGoingDown = false;
		resuming = false;
		yOffset = 0.0f;
		RES_OFFSET = GetScreenSize().y * 0.05f;
		error = 10 * GetScale();
		@returnButton = TextButton(V2_ZERO, "RESUME", text128, red);
		@menuButton = TextButton(V2_ZERO, "MAIN MENU", text128, red, true);
		lastUp = GetTime();
		swipedUp = false;
	}
	
	void update()
	{
		if(g_itemManager.selected)
			DrawShapedSprite("sprites/window.png", windowPos-vector2(0, yOffset), windowSize, ARGB(uint((1-g_itemManager.getBias())*255.0f),255,255,255));
		else	
			DrawShapedSprite("sprites/window.png", windowPos-vector2(0, yOffset), windowSize, white);
		
		
		if(!windowUp)
		{
			updateGameTouch();
			//if(
		}
		else
		{
			updateWindow();
		
			if(windowGoingUp)
				goingUp();
			else if(windowGoingDown)
				goingDown();
		}
		
		if(!windowUp)
		{
			if(GetTime() - lastUp > upStride && !swipedUp)
			{
				DrawText("SWIPE UP", text128, vector2(SS_50.x, GetScreenSize().y - PX_80), red, V2_HALF, 0.75);
			}
		}
	}
	
	void updateGameTouch()
	{
		ETHInput@ input = GetInputHandle();
		if(input.GetTouchState(0) == KS_HIT)
		{
			vector2 touchPos = input.GetTouchPos(0);
			if(isPointInWindow(touchPos))
			{
				goUp();
			}
			else
			{
				g_turret.shoot(touchPos);
			}
		}
		if(goSwipeUp())
		{
			goUp();
		}
	}
	
	void DrawResumeText()
	{
		DrawText("LOADING..", text128, vector2(SS_50.x, SS_75.y), AQUA_BLUE, V2_HALF, 0.8);
	}
	
	void updateWindow()
	{
		float yPos = GetScreenSize().y - yOffset;
		float yPosLine = yPos-PX_5;
		
		uint WH = WHITE_HALF;
		uint BH = BLACK_HALF;
		
		if(g_itemManager.selected)
		{
			uint opacity = uint((1-g_itemManager.getBias())*200.0f);
			WH = ARGB(opacity,255,255,255);
			BH = ARGB(opacity,0,0,0);
		}
		
		DrawShapedSprite("sprites/square.png", vector2(0, yPos), GetScreenSize(), WH);
		DrawShapedSprite("sprites/square.png", vector2(0, yPosLine-PX_5), vector2(windowTopLeft.x+PX_10, PX_10),BH);
		DrawShapedSprite("sprites/square.png", vector2(windowBottomRight.x-PX_10, yPosLine-PX_5), vector2(windowTopLeft.x+PX_10, PX_10),BH);
		drawUI(yPos);
		
		
	}
	
	void drawUI(float offset)
	{
	
		float yOffsetOrigin = GetScreenSize().y-yOffset;
		
		g_itemManager.setButtonsYOffset(SS_90.y - yOffset);
		returnButton.setPosition(vector2(SS_HALF_X, SS_190.y-yOffset-RES_OFFSET));
		menuButton.setPosition(vector2(SS_HALF_X, SS_110.y-yOffset));
		uint alpha = uint((1-g_itemManager.getBias())*255.0f);
		uint alphaRed = ARGB(alpha,255,0,0);
		uint alphaWhite = ARGB(alpha,255,255,255);
			
		vector2 volumePos = vector2(SS_90.x, yOffsetOrigin + PX_64);
		drawSoundButton(alphaWhite, volumePos, V2_96);
		
		
		returnButton.setColor(alphaRed);
		menuButton.setColor(alphaRed);
		returnButton.update();
		menuButton.update();
		
		if(returnButton.isPressed())
		{
			returnButton.setPressed(false);
			if(!windowGoingDown)
			{
				goDown();
			}
		}
		
		if(menuButton.isPressed())
		{
			menuButton.setPressed(false);
			g_sceneManager.transition(MainMenuScene());
		}
	}
	
	void drawSoundButton(uint color, vector2 pos, vector2 size)
	{
		DrawShapedSprite("sprites/sound_"+(SOUND_ON? "on":"off")+".png", pos, size, color);
		//print(vector2);
		if(GetInputHandle().GetTouchState(0) == KS_HIT)
		{
			if(isPointInRect(GetInputHandle().GetTouchPos(0), pos, size, V2_HALF))
			{
				SOUND_ON = !SOUND_ON;
				setVolume();
				g_dataManager.saveSettings();
			}
		}
	}
	
	void goingUp()
	{
		timer.update();
		yOffset = timer.getBias() * SS_90.y;
		if(timer.isOver())
		{
			windowGoingUp = false;
		}
	}
	
	void goingDown()
	{
		timer.update();
		yOffset = (1-timer.getBias()) * SS_90.y;
		if(timer.isOver())
		{
			end();
		}
	}
	
	void end()
	{
		windowUp = false;
		
	}
	
	void forceUp()
	{
		windowUp = true;
		windowGoingUp = false;
		windowGoingDown = false;
		g_timer.gameStopped = true;
		FACTOR = 0.0f;
		g_itemManager.fillButtons();
		g_itemManager.setButtons();
		g_itemManager.setButtonsYOffset(0);
		yOffset = SS_90.y;
		lastUp = GetTime();
	}
	
	void forceDown()
	{
		goDown();
		yOffset = 0;
		end();
	}
	
	void goUp()
	{
		if(!GAME_OVER && !GAME_SUCCESS)
		{
			windowUp = true;
			lastUp = GetTime();
			swipedUp = true;
			windowGoingUp = true;
			windowGoingDown = false;
			timer.reset(WINDOW_UP);
			g_timer.gameStopped = true;
			FACTOR = 0.0f;
			g_itemManager.fillButtons();
			g_itemManager.setButtons();
			g_itemManager.setButtonsYOffset(SS_90.y - yOffset);
		}
	}
	
	void goDown()
	{
		windowGoingUp = false;
		windowGoingDown = true;
		timer.reset(WINDOW_UP);
		g_timer.gameStopped = false;
		FACTOR = 1.0f;
	}

	bool isPointInWindow(vector2 p)
	{
		return isPointInRect(p, windowTopLeft - error, windowBottomRight + error);
	}

	void resume()
	{
		resuming = true;
		forceUp();
		DrawResumeText();
	}
	
	string getTag(){ return "UIManager";}
}

UIManager g_ui;