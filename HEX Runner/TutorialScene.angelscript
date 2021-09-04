class TutorialScene : Scene
{	
	TutorialScene()
	{
		super("empty");
		
	}

	uint elapsedTime;
		

	void onCreated()
	{
		GAME_OVER = false;
		NEW_HIGH_SCORE = false;
		BLOWN = false;
		GAME_OVER_TIME = 0;
		SetGravity(V2_ZERO);
		createScene();
		elapsedTime = 0;
		g_tutorialLayer.create();
		//g_colorManager.create();
		g_block.create();
		g_energyManager.create();
	}
	
	void onUpdate()
	{
		g_block.update();
		elapsedTime += GetLastFrameElapsedTime();
		g_tutorialLayer.update();
		g_energyManager.update();
	}
	
	void onResume()
	{
		g_block.resume();
		g_energyManager.resume();
	}
	
	void createScene()
	{
		for(uint i=3;i<9;i++)
		{
			addLeft(i);
			addRight(i);
		}
		for(uint i=9;i<15;i++)
		{
			addLeft(i);
			addMid(i);
		}
		for(uint i=17;i<23;i++)
		{
			addRight(i);
			addMid(i);
		}
		
		addRightArrow(8);
		addLeftArrow(16);
		addLeftArrow(16, 616);
		addLeftArrow(15, 616);
		
		AddEntity("coin.ent", vector3(104,25*-256,0)*GetScale(), 0);
		AddEntity("coin.ent", vector3(360,25*-256,0)*GetScale(), 0);
		AddEntity("coin.ent", vector3(616,25*-256,0)*GetScale(), 0);
		
		for(uint i=27;i<47;i++)
		{
			addRight(i);
			addMid(i);
			addLeft(i);
		}
		
		for(uint i=52;i<57;i++)
		{
			ETHEntity@ coin;
			AddEntity("coin_"+GetColorNameFromIdx(CURRENT_COLOR)+".ent", vector3(104,i*-256,0)*GetScale(), 0, @coin, "coin_color.ent",0.75);
			AddEntity("coin_"+GetColorNameFromIdx(CURRENT_COLOR)+".ent", vector3(360,i*-256,0)*GetScale(), 0, @coin, "coin_color.ent",0.75);
			AddEntity("coin_"+GetColorNameFromIdx(CURRENT_COLOR)+".ent", vector3(616,i*-256,0)*GetScale(), 0, @coin, "coin_color.ent",0.75);
		}
		
		for(uint i=65;i<75;i++)
		{
			addLeft(i, COL(GetColorFromIdx(rand(0,7))));
			addMid(i, COL(GetColorFromIdx(rand(0,7))));
			addRight(i, COL(GetColorFromIdx(rand(0,7))));
		}
		
	}
	
	void addRightArrow(float i, float x = 360)
	{
		ETHEntity@ ent1;
		AddEntity("arrow.ent", vector3(x,i*-256,0)*GetScale(), 0, @ent1, "arrow.ent", 1);
	}
	
	void addLeftArrow(float i, float x = 360)
	{
		ETHEntity@ ent1;
		AddEntity("arrow.ent", vector3(x,i*-256,0)*GetScale(), 180, @ent1, "arrow.ent", 1);
	}
	
	void addLeft(uint i, vector3&in colorNow = V3_ONE)
	{
		ETHEntity@ ent1;
		AddEntity(blockName, vector3(104,i*-256,0)*GetScale(), 0, @ent1, "blockNormal.ent", 1);
		ent1.SetColor(colorNow);
		ent1.SetVector3("color",colorNow);
	}
	
	void addRight(uint i, vector3&in colorNow = V3_ONE)
	{
		ETHEntity@ ent1;
		AddEntity(blockName, vector3(616,i*-256,0)*GetScale(), 0, @ent1, "blockNormal.ent", 1);
		ent1.SetColor(colorNow);
		ent1.SetVector3("color",colorNow);
	}
	
	void addMid(uint i, vector3&in colorNow = V3_ONE)
	{
		ETHEntity@ ent1;
		AddEntity(blockName, vector3(360,i*-256,0)*GetScale(), 0, @ent1, "blockNormal.ent", 1);
		ent1.SetColor(colorNow);
		ent1.SetVector3("color",colorNow);
	}
	
}

TutorialLayer g_tutorialLayer;

class TutorialLayer
{
	TutorialFadingText@[] messages;
	uint currentMessage = 0;
	InterpolationTimer@ startTimer = InterpolationTimer(300);
	InterpolationTimer@ runTimer = InterpolationTimer(4400);
	InterpolationTimer@ endTimer = InterpolationTimer(300);
	InterpolationTimer@ overTimer = InterpolationTimer(700);
	uint phase = 0;
	uint elapsed;
	vector2 coinTextPos;
	vector2 coinPos;
	vector2 blockSize;
	vector2 scorePosition;
	
	void create()
	{
		currentMessage = 0;
		fillMessages();
		elapsed = 0;
		scorePosition = vector2(15,15) * GetScale();
		blockSize = 20 * GetScale();
	}
	
	void update()
	{
		coinPos = vector2(scorePosition.x,GetScreenSize().y - scorePosition.y);
		coinTextPos = coinPos + vector2(32.5*GetScale(),0);
		coinPos -= vector2(0, 15*GetScale());

		
		elapsed += GetLastFrameElapsedTime();
		//DrawText(V2_ZERO, ""+(elapsed/100), "Verdana30.fnt", white);
		DrawText(""+BOOST_COINS, "Verdana30.fnt", coinTextPos, vector2(0,1));
		DrawShapedSprite("sprites/square.png", coinPos, blockSize, GetColorFromIdx(CURRENT_COLOR), 45);
		
		if(elapsed > 55000)
		{
			overTimer.update();
			uint newColor = ARGB(uint(float(255.0f*overTimer.getBias())),0,0,0);
			DrawShapedSprite("sprites/square.png", V2_ZERO, GetScreenSize(), newColor);
		}
		
		if(elapsed > 63000)
		{
			g_sceneManager.setCurrentScene(MainMenuScene());
			TUTORIAL = false;
		}
		
		if(currentMessage < messages.length())
		{
			if(elapsed > messages[currentMessage].enterTime)
			{
			
				float currentBias = startTimer.getBias();
				if(phase == 1)currentBias = 1.0f;
				if(phase == 2)currentBias = 1.0f-endTimer.getBias();
				
				
				uint thisColor = ARGB(uint(150.0f*currentBias), 255,255,255);
				uint thisColor2;
				if(elapsed < 56000)
					thisColor2 = ARGB(uint(255.0f*currentBias), 0,0,0);
				else
					thisColor2 = ARGB(uint(255.0f*currentBias), 255,255,255);
				 
				DrawShapedSprite("sprites/square.png", V2_ZERO, GetScreenSize(), thisColor);
				messages[currentMessage].draw(thisColor2);
								
				m_runFactor = 1.0f - currentBias;
			
				if(phase == 0)
				{
					startTimer.update();
					if(startTimer.isOver())
					{
						phase++;
					}
				}
				if(phase == 1)
				{
					runTimer.update();
					if(runTimer.isOver())
					{
						phase++;
					}
					if(GetInputHandle().GetTouchState(0) == KS_HIT)
					{
						uint timeLeft = uint((1.0f-runTimer.getUnfilteredBias())*4400.0f);
						elapsed += timeLeft;
						phase++;
					}
				}
				if(phase == 2)
				{
					endTimer.update();
					if(endTimer.isOver())
					{
						phase = 0;
						startTimer.reset(300);
						runTimer.reset(4400);
						endTimer.reset(300);
						currentMessage++;
					}
				}
				
				
				
			}
		}
		
		
	}
	
	void fillMessages()
	{
		messages.resize(0);
		messages.insertLast(TutorialFadingText("SWIPE LEFT AND RIGHT TO TURN",5200));
		messages.insertLast(TutorialFadingText("COLLECT POWER-UPS\n"+
											   "TO BOOST YOUR JOURNEY",20000));
		messages.insertLast(TutorialFadingText("FOR EVERY 30 COINS COLLETED\n"+
											   "A NEW OVERLAY IS UNLOCKED",29000));
		messages.insertLast(TutorialFadingText("REACHING A COLOR WILL\n" +
											   "UNLOCK IT",40000));
		
		messages.insertLast(TutorialFadingText("YOU CAN SWITCH\n" +
											   "COLORS AND OVERLAYS\n" +
											   "IN THE SETTINGS MENU",57100));
											
			
		
		//swipe left and right to turn
		//avoid hitting other blocks
		//collect power-ups to boost your journey
		//for every 30 coins collected a new overlay is unlocked
		//reaching a color will unlock it
		//you can switch colors and overlays in the settings menu
		//you can choose whether to display or not the overlays in game
	}
}


class TutorialFadingText
{
	uint enterTime;
	string text;
	vector2 pos;
	float textScale = 0.7;
	TutorialFadingText(string _text, uint _time)
	{
		text = _text;
		enterTime = _time;
		vector2 size = ComputeTextBoxSize("Verdana64.fnt", text) * GetScale() * textScale;
		pos = (GetScreenSize() - size)/2;
	}
	
	void draw(uint thisColor)
	{
		//DrawText(pos, text, "Verdana64.fnt", thisColor, GetScale()*textScale);
		DrawCenteredLines(text, textScale, "Verdana64.fnt", thisColor);
	}
}