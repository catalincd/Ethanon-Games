	//games played
	//time played
	//average score
	//highest score
	//
	//global position
	//global average
	//global best

class StatScene : Scene
{
	
	TextButton@ back;
	InterpolationTimer@ timer = InterpolationTimer(500);
	bool goingBack;
	float xPos; 
	float mirrorXPos;
	vector2 blockSize;
	float HighscoreScale = 1.0f;
	FloatBouncer@ highscoreBouncer = FloatBouncer(1.0f, 1.2f);
	
	StatScene()
	{
		super("empty");
	}
	
	
	


	void onCreated()
	{
		vector2 backPos = vector2(GetScreenSize().x/2, GetScreenSize().y*0.95);
		@back = TextButton(backPos, "BACK", "Verdana64.fnt");
		timer.reset(500);
		goingBack = false;
	
		xPos = 75*GetScale();
		mirrorXPos = GetScreenSize().x-xPos;
		blockSize = 45 * GetScale() * 0.70f;
		HighscoreScale = 1.0f;
		@highscoreBouncer = FloatBouncer(1.0f, 1.2f);
	}
	
	void onUpdate()
	{
		//high
		DrawText("HIGH SCORE:", "Verdana64.fnt", vector2(xPos, 250*GetScale()), V2_ZERO, white, 0.70);
		DrawText(""+HIGH_SCORE, "Verdana64.fnt", vector2(mirrorXPos, 250*GetScale()), vector2(1,0), GetColorFromIdx(CURRENT_COLOR), 0.70*HighscoreScale);
		//average
		DrawText("AVERAGE SCORE:", "Verdana64.fnt", vector2(xPos, 375*GetScale()), V2_ZERO, white, 0.70);
		DrawText(""+CURRENT_SCORE_AVG, "Verdana64.fnt", vector2(mirrorXPos, 375*GetScale()), vector2(1,0), GetColorFromIdx(CURRENT_COLOR), 0.70);
		//games 
		DrawText("GAMES PLAYED:", "Verdana64.fnt", vector2(xPos, 500*GetScale()), V2_ZERO, white, 0.70);
		DrawText(""+GAMES_PLAYED, "Verdana64.fnt", vector2(mirrorXPos, 500*GetScale()), vector2(1,0), GetColorFromIdx(CURRENT_COLOR), 0.70);
		//time
		DrawText("TIME PLAYED:", "Verdana64.fnt", vector2(xPos, 625*GetScale()), V2_ZERO, white, 0.70);
		DrawText(""+GetTimePlayedString(), "Verdana64.fnt", vector2(mirrorXPos, 625*GetScale()), vector2(1,0), GetColorFromIdx(CURRENT_COLOR), 0.70);
		//coins
		DrawText("COLLECTED:", "Verdana64.fnt", vector2(xPos, 750*GetScale()), V2_ZERO, white, 0.70);
		DrawText(""+TOTAL_BOOST_COINS, "Verdana64.fnt", vector2(mirrorXPos - blockSize.x, 750*GetScale()), vector2(1,0), GetColorFromIdx(CURRENT_COLOR), 0.70);
		float xSize = ComputeTextBoxSize("Verdana64.fnt", ""+TOTAL_BOOST_COINS).x * GetScale();
		
		DrawShapedSprite("sprites/square.png", vector2(mirrorXPos-0.5*blockSize.x, 772.5*GetScale()), blockSize, GetColorFromIdx(CURRENT_COLOR), 45);
		
		if(NEW_HIGH_SCORE)
		{
			highscoreBouncer.update();
			HighscoreScale = highscoreBouncer.getBounceScale();
		}
	
	
		back.update();
	
		if(!goingBack)
		{
			if(back.isPressed() || GetInputHandle().GetKeyState(K_BACK)==KS_HIT || GetInputHandle().GetKeyState(K_BACKSPACE)==KS_HIT)
			{
				back.setPressed(false);
				goingBack = true;
			}
		}
		if(goingBack)
		{
			timer.update();
			uint overlayColor = ARGB(uint(255.0f*(timer.getBias())),0,0,0);
			DrawShapedSprite("sprites/square.png", V2_ZERO, GetScreenSize(), overlayColor);
			if(timer.isOver())
			{
				g_sceneManager.setCurrentScene(MainMenuScene());
				NEW_HIGH_SCORE = false;
			}
		}
	}
}