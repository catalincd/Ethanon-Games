class CasualSceneClass : Scene
{	
	TextButton@ startButton;
	TextButton@ backButton;

	UIntSlider@ slider;
	float alpha = 1.0f;
	float scale = 1.0f;
	vector2 textPos;
	vector2 sizePos;

	CasualSceneClass()
	{
		super("empty");
	}
	
	void create()
	{
		@slider = UIntSlider(GetScreenSize() * vector2(0.5f, 0.45f), 5, 15, CASUAL_WIDTH);
		
		@startButton = TextButton("START", GetScreenSize() * vector2(0.5f, 0.75f), f128, black);
		startButton.setDelay(150);
		@backButton = TextButton("BACK", GetScreenSize() * vector2(0.5f, 0.85f), f128, black);
		backButton.setDelay(250);
		
		textPos = GetScreenSize() * vector2(0.5f, 0.35f);
		sizePos = GetScreenSize() * vector2(0.5f, 0.55f);
	}
	
	void resetAndFade()
	{
		startButton.setDelay(200);startButton.FadeOut();
		backButton.setDelay(200);backButton.FadeOut();
	}
	
	void update()
	{
	
		slider.update(alpha, scale);
		MAZE_WIDTH = slider.getValue();
		string mazeString = ""+MAZE_WIDTH+AssembleColorCode(black.getUInt())+" x "+AssembleColorCode(white.getUInt())+MAZE_WIDTH;
		
		DrawText("MAZE SIZE", f128, textPos, black.getUInt());
		DrawText(mazeString, f128, sizePos, red.getUInt());
	
		
		
		startButton.update();
		backButton.update();
		
		if(startButton.isHit())
		{
			CASUAL = true;
			CASUAL_WIDTH = MAZE_WIDTH;
			progress.save();
			resetAndFade();
			startButton.setDelay(50);
			gameScene();
		}
		
		if(backButton.isHit())
		{
			resetAndFade();
			backButton.setDelay(50);
			mainMenu();
		}
	}
}

CasualSceneClass CasualScene;