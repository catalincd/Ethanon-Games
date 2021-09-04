class GameUI
{
	bool flickering = false;
	bool backing = false;
	Flicker flicker = Flicker(2);
	TextButton@ backButton;
	ProgressBar@ levelProgress;
	string progressText1;
	string progressText2;
	float thisBias = 1.0f;
	float progressWidth = 400;
	uint elapsed = 0;
	vector2 textPos;

	void create()
	{
		flicker.create();
		@backButton = TextButton("BACK", GetScreenSize() * vector2(0.075f, 0.03f), f64, black, V2_ZERO);
		backButton.setDelay(150);
		backing = false;
		
		textPos = GetScreenSize() * vector2(0.925f, 0.03f);
		
		progressWidth = mazeSize.x;
		
		vector2 progressBarPos = GetScreenSize()*vector2(0.5f, -0.065f) + vector2(0.0f, offset.y);
		//if(LAYOUT == 1)
		//	progressBarPos -= vector2(0.0f, GetScreenSize().y * 0.05f);
		
		@levelProgress = ProgressBar(vector2(progressWidth, 75 * GetScale()), 10*GetScale(), V2_HALF, progressBarPos);
		setText();
	}
	
	void setText()
	{
		progressText1 = " LEVEL " + (LEVEL / 10 + 1);
		progressText2 = "" + (LEVEL % 10 + 1) + " / 10 ";
		thisBias = float(LEVEL % 10 + 1) / 10.0f;
		elapsed = 0;
	}
	
	void update()
	{
	
		elapsed += GetLastFrameElapsedTime();
		string timeText = getTime(toSeconds(elapsed));
	//	DrawText(timeText, f64, textPos);
		DrawText(timeText, f64, textPos, black.getUInt(), vector2(1.0f, 0.0f));
		
		
		backButton.update();
		
		if(!CASUAL)
		{
			levelProgress.setFillColor(ballColor);
			levelProgress.update(progressText1, progressText2, thisBias, 1.0f, -1.0f * g_camera.getOffset());
		}
		
		if(backButton.isHit() || GetInputHandle().GetKeyState(K_BACK) == KS_HIT)
		{
			backing = true;
			Alert.show("RETURN TO MAIN MENU?");
		}
		
		if(backing)
		{
			if(Alert.yes())
			{
				Alert.hideOnChange();
				backing = false;
				backButton.FadeOut();
				mainMenu();
			}
			if(Alert.no())
			{
				backing = false;
				Alert.hide();
			}
		}
		
		
		if(flickering) 
		{
			flicker.update();
			if(flicker.going())
				DrawShapedSprite("sprites/flick.png", V2_ZERO, GetScreenSize(), black.getUInt());
		}
			
			
	}
	
	void resume()
	{
		
	}
}

GameUI ui;



uint toSeconds(uint ms)
{
	return ms / 1000;
}

string getTime(uint seconds)
{
	if(seconds > 60)
	{
		uint minutes = seconds / 60;
		seconds %= 60;
		return ("" + minutes + ":" + (seconds<10? "0":"") +seconds);
	}
	return ""+seconds;
}