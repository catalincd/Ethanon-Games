class MainMenuScene : Scene
{
	uint runs = 0;
	bool rankUp = false;
	bool whiteOver = false;
	bool rankUpOver = false;
	vector2 continuePos;
	vector2 rankPos;
	vector2 newRankPos;
	vector2 rankNamePos;
	vector2 rankNumPos;
	vector2 expPos;
	vector2 expPos2;
	vector2 missionPos;
	vector2 missionPos2;
	vector2 rewardPos;
	vector2 rewardPos2;
	
	vector2 menuRankPos;
	uint rankupReward;
	TextButton@ start_button;
	TextButton@ settings_button;
	InterpolationTimer@ layerTimer = InterpolationTimer(300);
	InterpolationTimer@ whiteTimer = InterpolationTimer(300);
	FloatBouncer@ layerBouncer = FloatBouncer(0.0f, 1.0f, 450);
	
	Polygon rankPoly;

	MainMenuScene()
	{
		const string sceneName = "empty";
		super(sceneName);
	}

	void execBegin()
	{
		EnableLightmaps(false);
		SF.set();
		g_loader.fill();
		g_loader.load();
		g_dataManager.load();
		g_dataSet.init();
		g_exp.init();
		g_fundManager.init();
		loadSettings();
	}

	void onCreated()
	{	
		SetBackgroundColor(white);
		if(runs == 0)
		{
			execBegin();
		}
		
		
		
		continuePos = vector2(SS_50.x, GetScreenSize().y * 0.9);
		rankPos = vector2(SS_50.x, SS_50.y * 0.8);
		newRankPos = vector2(SS_50.x, SS_50.y * 0.3);
		rankNamePos = vector2(SS_50.x, SS_50.y);
		rankNumPos = vector2(SS_50.x, SS_50.y * 0.6);
		expPos = vector2(SS_50.x - PX_220, SS_50.y*1.25f);
		expPos2 = vector2(SS_50.x + PX_220, SS_50.y*1.25f);
		missionPos = vector2(SS_50.x - PX_220, SS_50.y*1.35f);
		missionPos2 = vector2(SS_50.x + PX_220, SS_50.y*1.35f);
		rewardPos = vector2(SS_50.x - PX_220, SS_50.y*1.45f);
		rewardPos2 = vector2(SS_50.x + PX_100*1.325, SS_50.y*1.45f);
		
		
		//menuRankPos = vector2(PX_200, SS_50.y * 0.75);
		menuRankPos = vector2(SS_50.x, SS_50.y * 0.75);
		
		
		g_dataManager.getRankup();
		rankUp = RANK_UP;
		if(rankUp)
		{
			rankupReward = getMissionReward(getRank()) * 3;
			g_fundManager.addRankup(rankupReward);
		}
		//rankUp = true;
		rankUpOver = false;
		whiteOver = false;
		RANK_UP = false;
		g_dataManager.saveRankup();
		
		g_rankLayer.create();
		g_rankLayer.enabled = false;
		
		whiteTimer.reset(300);
		layerTimer.reset(500);
		runs++;
		@start_button = TextButton(vector2(GetScreenSize().x/2, GetScreenSize().y*0.8), "START", text128, black, true);
		@settings_button = TextButton(vector2(GetScreenSize().x/2, GetScreenSize().y*0.9), "SETTINGS", text128, black, true);
		initRankPoly();
	}

	void initRankPoly()
	{
		rankPoly.reset();
		
		rankPoly.insert(menuRankPos - vector2(PX_100, PX_200));
		rankPoly.insert(menuRankPos + vector2(-PX_100, PX_10*2.5));
		rankPoly.insert(menuRankPos + vector2(-PX_200*1.25, PX_10*2.5));
		rankPoly.insert(menuRankPos + vector2(-PX_200*1.25, PX_200*1.25));
		rankPoly.insert(menuRankPos + vector2(PX_200*1.25, PX_200*1.25));
		rankPoly.insert(menuRankPos + vector2(PX_200*1.25, PX_10*2.5));
		rankPoly.insert(menuRankPos + vector2(PX_100, PX_10*2.5));
		rankPoly.insert(menuRankPos + vector2(PX_100, -PX_200));
		
	}


	void updateLayerButton()
	{
	//	rankPoly.debugDraw();
		if(GetInputHandle().GetTouchState(0) == KS_HIT)
		{
			if(rankPoly.isPointInPolygon(GetInputHandle().GetTouchPos(0)))
				g_rankLayer.enable();
		}
	}

	void onUpdate()
	{
		g_exp.DrawMainMenu(menuRankPos);
		
		if(!rankUp && !g_rankLayer.enabled)
		{
			start_button.update();
			settings_button.update();
			updateLayerButton();
		}
		else
			start_button.draw();
		if(start_button.isPressed())
		{
			start_button.setPressed(false);
			g_sceneManager.transition(ItemSelectorScene());
		}
		if(settings_button.isPressed())
		{
			settings_button.setPressed(false);
			g_sceneManager.transition(SettingsScene());
		}
		updateRankupLayer();
		g_rankLayer.update();
		
		//updateTestRect();
	}
	
	
	void updateTestRect()
	{
		uint color1 = red;
		uint color2 = multiply(0xFF6473bd, vector3(1,0,0));
		print((color2 & 0x00FF0000)>>16);
		DrawRectangle(V2_ZERO, GetScreenSize(), color1, color2, color1, color2);
	}
	
	
	void updateRankupLayer()
	{
		if(rankUp)
		{
			
			uint opacity = (1.0f - layerTimer.getBias()) * 255.0f;
			uint color = ARGB(opacity, 255, 255, 255);
			uint newGreen = ARGB(opacity, 0, 255, 0);
			uint newRed = ARGB(opacity, 255, 0, 0);
			uint newAQUA_BLUE = ARGB(opacity, 28,134,242);
			uint newBlack = ARGB(opacity, 0,0,0);
			
			uint opacityWh = (1.0f - whiteTimer.getBias()) * 255.0f;
			uint newWhite = ARGB(opacityWh, 255, 255, 255);
			DrawShapedSprite("sprites/square.png", V2_ZERO, GetScreenSize(), newWhite);
			
			
			g_rank.DrawRankOp(getRank(), rankPos, V2_200, V2_HALF, color, newAQUA_BLUE);
			
			
			layerBouncer.update();
			float textBias = (layerBouncer.getBounceScale() / 1.5);
			uint textColor = interpolateColor(newGreen, color, textBias);
			DrawText("NEW RANK!", sans128, newRankPos, textColor);
			DrawText(getRankName(getRank()), sans128, rankNamePos, newAQUA_BLUE, V2_HALF, 0.75);
			string str = ""+AssembleColorCode(newBlack)+getRank()+AssembleColorCode(color)+"/15";
			DrawText(str, sans128, rankNumPos, AQUA_BLUE, V2_HALF, 0.75);
			
			DrawText("EXP", sans64, expPos, newGreen, vector2(0.0f, 0.5f));
			DrawText(""+EXP+" ", sans64, expPos2, newRed, vector2(1.0f, 0.5f));
			
			DrawText("MISSION", sans64, missionPos, newGreen, vector2(0.0f, 0.5f));
			DrawText(""+g_timer.getTimeString(MINUTE * getMissionBias(getRankTier(getRank())))+" ", sans64, missionPos2, newRed, vector2(1.0f, 0.5f));
			
			DrawText("REWARD", sans64, rewardPos, newGreen, vector2(0.0f, 0.5f));
			DrawFunds(rankupReward, rewardPos2, 0.5f, 0.5f, newRed, color);
			
			
			uint continueColor = interpolateColor(newBlack, color, 1.0f-layerBouncer.getBounceScale());
			DrawText("MAIN MENU", sans128, continuePos, continueColor, V2_HALF, 0.75);
			
			if(GetInputHandle().GetTouchState(0) == KS_HIT)
				if(!whiteOver)
				{
					whiteOver = true;
					layerBouncer.end();
				}
			
			if(whiteOver)
			{
				layerTimer.update();
				if(layerTimer.isOver())
				{
					rankUpOver = true;
					whiteOver = false;
				}
			}
			
			if(rankUpOver)
			{
				whiteTimer.update();
				if(whiteTimer.isOver())
					rankUp = false;
			}
			
		}
	}

	void onResume()
	{
		SetBackgroundColor(white);
	}
}
