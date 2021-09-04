class CameraManager : GameObject
{
	float screenSize2 = GetScreenSize().y*0.6;
	float screenSize3 = GetScreenSize().y/2;
	vector2 gameOverCamPos = V2_ZERO;
	vector2 offset = V2_ZERO;
	vector2 currentFocusPos = 0;
	uint shakeIdx = 0;
	InterpolationTimer@ shakeTimer = InterpolationTimer(SHAKE_LENGTH_MS);
	
	void focusGameOver()
	{
		gameOverCamPos = currentFocusPos;
	}
	
	void updateGameOver()
	{
		uint GAME_OVER_ELAPSED = GetTime()-GAME_OVER_TIME;
		if(GAME_OVER_ELAPSED < 700)
		{
			float xy = 8+(700-float(GAME_OVER_ELAPSED))*12/700;
			vector2 add = vector2(randF(1)*xy, randF(1)*xy) * GetScale();
			SetCameraPos(gameOverCamPos+add);
		}
		else SetCameraPos(gameOverCamPos);
	}
	
	void create()
	{
		@shakeTimer = InterpolationTimer(SHAKE_LENGTH_MS);
		shakeTimer.m_elapsedTime = SHAKE_LENGTH_MS-1;
	}
	void resume(){}
	string getTag(){ return "Camera";}
		
	void update()
	{
	
		screenSize2 = GetScreenSize().y*0.6;
		screenSize3 = GetScreenSize().y/2;
	
		shakeTimer.update();
		if(!GAME_OVER)
		{
			if(!shakeTimer.isOver())
			{
				
				if(!isEnergyOn())
				{
					float xy = (1.0f-shakeTimer.getBias())*15.0f;
					offset = vector2(randF(-1,1)*xy, randF(-1,1)*xy) * GetScale();
					SetBackgroundColor(COL((1.0f-flickerCycles(shakeTimer.getBias(), 0.05f)) * GetV3ColorFromIdx(shakeIdx)));
				}
				else
				{
					offset = V2_ZERO;
				}
			}
			else
			{
				SetBackgroundColor(black);
				offset = V2_ZERO;
			}
			
		}
		//if(GetInputHandle().GetKeyState(K_LMOUSE)==KS_HIT)
		//	shake();
		
		//
	}
	
	bool shaking()
	{
		return !shakeTimer.isOver();
	}
	
	void shake()
	{
		shake(0);
	}
	
	void shake(uint _shakeIdx)
	{
		shakeTimer.reset(SHAKE_LENGTH_MS);
		shakeIdx = _shakeIdx;
	}

	void focus(ETHEntity@ thisEntity)
	{
		currentFocusPos = vector2(0, thisEntity.GetPositionY()-screenSize2);
		SetCameraPos(currentFocusPos + offset);
	}
	
	vector2 getCameraPos()
	{
		return vector2(0, g_block.thisEntity.GetPositionY()-screenSize2);
	}
}

CameraManager g_cameraManager;

vector2 getCameraPos()
{
	return g_cameraManager.getCameraPos();
}