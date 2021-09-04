
class StatsScene : Scene
{

	vector2 strokePos;
	vector2 strokeSize;
	vector2 fillPos;
	vector2 fillSize;
	vector2 fillSize2;
	vector2 levelTextPos;
	float levelBias ;
	uint op = ARGB(255,255,255,255);
	string level_string;
	float mainScale = 0.5;
	vector2 text_total_pos;
	vector2 text_current_pos;
	vector2 text_best_pos;
	
	vector2 text_total_size;
	vector2 text_current_size;
	vector2 text_best_size;
	
	string total;
	string current;
	string best;
	
	vector2 navSize;
	vector2 navSize2;
	vector2 textPos2;
	vector2 textPos;
	vector2 sprPos2;
	vector2 sprPos;
	vector2 index = vector2(0,0);
	bool resuming = false; 
	int resumingTo = 0;
	bool newH = false;
	bool sliderStarted = false;
	
	InterpolationTimer@ Zoomer = InterpolationTimer(350);
	InterpolationTimer@ Slider = InterpolationTimer(500);
	uint alpha;
	StatsScene()
	{
		const string sceneName = "empty";
		super(sceneName);
	}
	
	void onResume()
	{
		g_setOrigin.resetAllOrigins();
		SetBackgroundColor(PRIM.getUInt());
		g_loader.load();
		Slider.reset(800*levelBias);
	}
	
	
	void onCreated()
	{
		dataBase.loadMisc();
		
		SetBackgroundColor(PRIM.getUInt());
		strokeSize = vector2(500,50)*GetScale();
		strokePos = vector2(SCREEN_SIZE_X2, 200*GetScale());
		levelTextPos = strokePos - (ComputeTextBoxSize(dataBase.font30, level_string)/2*GetScale());
		fillPos = strokePos - vector2(243, 18)*GetScale();
		fillSize = vector2(0, 36)*GetScale();
		fillSize2 = vector2(486, 36)*GetScale();
		setSpriteOrigin("sprites/stroke.png", vector2(0.5, 0.5));
		
		navSize = vector2(SCREEN_SIZE_X, 70*GetScale());
		textPos = vector2(SCREEN_SIZE_X2, -35*GetScale()) - (ComputeTextBoxSize(dataBase.font40, "BACK TO MAIN MENU")/2*GetScale());
		textPos2 = vector2(SCREEN_SIZE_X2, SCREEN_SIZE_Y+35*GetScale()) - (ComputeTextBoxSize(dataBase.font40, "START")/2*GetScale());
		sprPos = vector2(0, -70)*GetScale();
		sprPos2 = vector2(0, SCREEN_SIZE_Y);
		
		Zoomer.setFilter(@smoothEnd);
		Slider.setFilter(@smoothEnd);
		
		CURRENT_LEVEL = scoreToLevel(CURRENT_TOTAL_XP);
		level_string = "LEVEL "+CURRENT_LEVEL;
		levelBias = float(CURRENT_TOTAL_XP-levelToScore(CURRENT_LEVEL))/float(levelToScore(CURRENT_LEVEL+1)-levelToScore(CURRENT_LEVEL));
		
		total = "TOTAL SCORE   "+CURRENT_TOTAL_XP;
		current = "CURRENT SCORE   "+CURRENT_LEVEL_XP;
		best = "BEST SCORE   "+BEST_XP;
		
		text_total_size = ComputeTextBoxSize(dataBase.font30, total)/2*GetScale();
		text_current_size = ComputeTextBoxSize(dataBase.font30, current)/2*GetScale();
		text_best_size = ComputeTextBoxSize(dataBase.font30, best)/2*GetScale();
		
				float lPos = SCREEN_SIZE_X/2-(250*GetScale());

		
		text_total_pos = vector2(lPos, 300*GetScale())+vector2(text_total_size.x,0);
		text_current_pos = vector2(lPos, 375*GetScale())+vector2(text_current_size.x,0);
		text_best_pos = vector2(lPos, 450*GetScale())+vector2(text_best_size.x,0);
		
		
	}
	
	void onUpdate()
	{
		
		uint whitee = ARGB(alpha, PRIM);
		uint realWhite = ARGB(alpha, 255,255,255);
		uint blackk = ARGB(alpha, SEC);
		op = ARGB(uint(100*float(alpha)/255),255,255,255);
		DrawShapedSprite(g_gameManager.blockS, sprPos+index, navSize, realWhite);
		DrawText(textPos+index, "BACK TO MAIN MENU", dataBase.font40, whitee, GetScale());
		
		DrawShapedSprite(g_gameManager.blockS, sprPos2-index, navSize, realWhite);
		DrawText(textPos2-index, "START", dataBase.font40, whitee, GetScale());

		
		Zoomer.update();
		if(Zoomer.isOver() && !sliderStarted)
		{
			sliderStarted = true;
			Slider.reset(800*levelBias);
		}
		if(sliderStarted)
		{
			Slider.update();
		}
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
				if(resumingTo==1)
					g_sceneManager.setCurrentScene(MainMenuScene());
				if(resumingTo==2)
				{
				//	GameOver = false;
					g_sceneManager.setCurrentScene(GameScene());
				}
			}
		}
		if(!resuming)
		{
			if((GetInputHandle().GetTouchState(0)==KS_HIT && GetInputHandle().GetTouchPos(0).y<70*GetScale()) || (GetInputHandle().GetKeyState(K_BACK)==KS_HIT))
			{
				resuming = true;
				Zoomer.reset(350);
				resumingTo = 1;
			}
			if(GetInputHandle().GetTouchState(0)==KS_HIT && GetInputHandle().GetTouchPos(0).y>SCREEN_SIZE_Y-(70*GetScale()))
			{
				resuming = true;
				Zoomer.reset(350);
				resumingTo = 2;
			}
		}
		levelTextPos = strokePos - (ComputeTextBoxSize(dataBase.font30, level_string)/2*GetScale()*mainScale);
		fillPos = strokePos - vector2(243, 18)*GetScale()*mainScale;
		fillSize = vector2(486*levelBias*Slider.getBias(), 36)*GetScale();
		DrawShapedSprite("sprites/stroke.png", strokePos, strokeSize*mainScale, blackk);
		DrawShapedSprite("sprites/grey.png", fillPos, fillSize2*mainScale, op);
		DrawShapedSprite("sprites/grey.png", fillPos, fillSize*mainScale, realWhite);
		DrawText(levelTextPos, level_string, dataBase.font30, blackk, GetScale()*mainScale);
		
		DrawText(text_total_pos-(mainScale*text_total_size), total, dataBase.font30, blackk, GetScale()*mainScale);
		DrawText(text_current_pos-(mainScale*text_current_size), current, dataBase.font30, blackk, GetScale()*mainScale);
		DrawText(text_best_pos-(mainScale*text_best_size), best, dataBase.font30, blackk, GetScale()*mainScale);
	}
	
}