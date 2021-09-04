class SettingsScene : Scene
{
	
	InterpolationTimer@ Zoomer = InterpolationTimer(300);
	UseButton@[] useButtons;
	bool resuming = false;
	vector2 index(0,0);
	uint alpha;
	uint op;
	float mainScale;
	vector2 navSize;
	vector2 sprPos;
	vector2 textPos;
	uint selectedIdx;
	bool selected = false;
	bool selectedAs = false;
	bool selectedAs2 = false;
	bool goingBack = false;
	float xTPos = 0.35*SCREEN_SIZE_X;
	float yTPos = 0.70*SCREEN_SIZE_Y;
	float yTPos2 = 0.70*SCREEN_SIZE_Y+(50*GetScale());
	string timestr;
	
	SettingsScene()
	{
		const string sceneName = "empty";
		super(sceneName);
	}
	
	void onCreated()
	{
		resuming = false;
		navSize = vector2(SCREEN_SIZE_X, 70*GetScale());
		textPos = vector2(SCREEN_SIZE_X2, SCREEN_SIZE_Y+35*GetScale()) - (ComputeTextBoxSize(dataBase.font40, "BACK TO MAIN MENU")/2*GetScale());
		sprPos = vector2(0, SCREEN_SIZE_Y);
		timestr = g_timeManager.getNormal();
		insertButtons();

	}
	
	void onResume()
	{
		g_setOrigin.resetAllOrigins();
		SetBackgroundColor(PRIM.getUInt());
		g_loader.load();
	}
	
	void insertButtons()
	{
		//color - 0
		UseButton@ m_color = UseButton(vector2(360, 200)*GetScale());
		m_color.setText("THEME COLOR", dataBase.font40);
		useButtons.insertLast(m_color);
	}
	
	void onUpdate()
	{
		Zoomer.update();
		uint whitee = ARGB(alpha, PRIM);
		uint realWhite = ARGB(alpha, 255,255,255);
		uint blackk = ARGB(alpha, SEC);
		op = ARGB(uint(100*float(alpha)/255),255,255,255);
		DrawShapedSprite(g_gameManager.blockS, sprPos-index, navSize, realWhite);
		DrawText(textPos-index, "BACK TO MAIN MENU", dataBase.font40, whitee, GetScale());
		
		if(!resuming)
		{
			mainScale = 0.3+(Zoomer.getBias()*0.7);
			alpha = uint(Zoomer.getBias()*255.0);
			index.y = Zoomer.getBias()*70*GetScale();
		}
		else
		{
			mainScale = 0.3+((1-Zoomer.getBias())*0.7);
			alpha = uint((1-Zoomer.getBias())*255.0);
			index.y = (1-Zoomer.getBias())*70*GetScale();
			
			if(Zoomer.isOver())
			{
				g_sceneManager.setCurrentScene(MainMenuScene());
			}
		}
		
		for(uint i=0;i<useButtons.length();i++)
		{
			useButtons[i].setScale(mainScale);
			useButtons[i].setColor(ARGB(alpha, SEC));
		
			useButtons[i].putButton();
		}
		
		DrawText("TIME SPENT:   "+timestr, dataBase.font30, ARGB(alpha, SEC),vector2(xTPos, yTPos), vector2(0,0), GetScale()*mainScale);
		DrawText("GAMES PLAYED: "+GAMES_PLAYED, dataBase.font30, ARGB(alpha, SEC),vector2(xTPos, yTPos2), vector2(0,0), GetScale()*mainScale);
		
		
		
		if(!resuming)
		{
			if((GetInputHandle().GetTouchState(0)==KS_HIT && GetInputHandle().GetTouchPos(0).y>SCREEN_SIZE_Y-70*GetScale()) || (GetInputHandle().GetKeyState(K_BACK)==KS_HIT))
			{
				resuming = true;
				Zoomer.reset(350);
			}

		}
	}
	
}