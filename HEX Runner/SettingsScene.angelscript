class SettingsScene : Scene
{
	
	TextButton@ back;
	TextButton@ colorsButton;
	TextButton@ overlayButton;
	TextButton@ settingsButton;
	bool goingBack = false;
	bool colorON = true;
	float size_bias = 0;
	InterpolationTimer@ timer = InterpolationTimer(500);
	InterpolationTimer@ size_timer = InterpolationTimer(300);
	vector2 initBlockSize;
	vector2 targetBlockSize;
	vector2 center;
	vector2 colorsPos;
	vector2 overlaysPos;
	vector2 settingsPos;
	vector2 overlayPos;
	uint CURRENT_WHEEL = 0;
	
	SettingsScene()
	{
		super("empty");
	}
	

	void onCreated()
	{
		g_colorWheel.create();
		
		//g_overlayWheel.create();
		overlaySelector.create();
		
		g_optionsLayer.create();
		colorON = true;
		CURRENT_WHEEL = 0;
		if(RATIO)
		{
			colorsPos = vector2(GetScreenSize().x*0.2, 140*GetScale());
			overlayPos = vector2(GetScreenSize().x/2, 140*GetScale());
			settingsPos = vector2(GetScreenSize().x*0.8, 140*GetScale());
		}
		
		else
		
		{
			colorsPos = vector2(GetScreenSize().x*0.25, 200*GetScale());
			overlayPos = vector2(GetScreenSize().x/2, 275*GetScale());
			settingsPos = vector2(GetScreenSize().x*0.75, 350*GetScale());
		}

		@colorsButton = TextButton(colorsPos, "COLOR", "Verdana64.fnt");
		@overlayButton = TextButton(overlayPos, "OVERLAY", "Verdana64.fnt");
		@settingsButton = TextButton(settingsPos, "OPTIONS", "Verdana64.fnt");
		
		overlayButton.disable();
		settingsButton.disable();
		
		if(RATIO)
		{
			colorsButton.setScale(0.75f);
			overlayButton.setScale(0.75f);
			settingsButton.setScale(0.75f);
		}
		
		//overlayButton.setText("DRAWING OVERLAYS IN-GAME:  " + AssembleColorCode(DRAWING_OVERLAYS? green:red)+(DRAWING_OVERLAYS? "ON " : "OFF"));
		
		goingBack = false;
		vector2 backPos = vector2(GetScreenSize().x/2, GetScreenSize().y*0.95);
		center = vector2(GetScreenSize().x/2, GetScreenSize().y*0.6);
		@back = TextButton(backPos, "BACK", "Verdana64.fnt");
		
		NEW_COLOR_UNLOCKED = false;
		NEW_OVERLAY_UNLOCKED = false;
		
		size_bias = 0;
		size_timer.reset(500);
		timer.reset(500);
		initBlockSize = vector2(64,64)*GetScale();
		targetBlockSize = 3*vector2(64,64)*GetScale();
	}
	
	void onUpdate()
	{
		if(CURRENT_WHEEL==0)
		g_colorWheel.update();
		if(CURRENT_WHEEL==1)
		//g_overlayWheel.update();
		overlaySelector.update();
		if(CURRENT_WHEEL==2)
		g_optionsLayer.update();
	
		size_timer.update();
		back.update();
		colorsButton.update();
		overlayButton.update();
		settingsButton.update();
		if(colorsButton.isPressed())
		{
			if(CURRENT_WHEEL != 0)
			{
				CURRENT_WHEEL = 0;
				colorsButton.enable();
				overlayButton.disable();
				settingsButton.disable();
			}
			colorsButton.setPressed(false);
		}
		if(overlayButton.isPressed())
		{
			if(CURRENT_WHEEL != 1)
			{
				CURRENT_WHEEL = 1;
				colorsButton.disable();
				overlayButton.enable();
				settingsButton.disable();
			}
			overlayButton.setPressed(false);
		}
		if(settingsButton.isPressed())
		{
			if(CURRENT_WHEEL != 2)
			{
				CURRENT_WHEEL = 2;
				colorsButton.disable();
				overlayButton.disable();
				settingsButton.enable();
			}
			settingsButton.setPressed(false);
		}
		
		
		
		/*if(overlayButton.isPressed())
		{
			DRAWING_OVERLAYS = !DRAWING_OVERLAYS;
			overlayButton.setText("DRAWING OVERLAYS IN-GAME:  " + AssembleColorCode(DRAWING_OVERLAYS? green:red)+(DRAWING_OVERLAYS? "ON " : "OFF"));
		}*/
		if(CURRENT_WHEEL != 2)
		drawCenterBlock();
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
			
				
			//	if(CURRENT_COLOR > UNLOCKED_COLORS)
			//		CURRENT_COLOR = UNLOCKED_COLORS;
				
				g_sceneManager.setCurrentScene(MainMenuScene());
			}
		}
		
	}
	
	void drawCenterBlock()
	{
		size_bias += UnitsPerSecond(3);
		size_bias = min(1, size_bias);
		vector2 finalSize = interpolate(initBlockSize, targetBlockSize, size_timer.getBias());
		//vector2 finalSize = interpolate(initBlockSize, targetBlockSize, size_bias);
		
		//DrawShapedSprite("sprites/block/body6.png", center, finalSize, CURRENT_COLOR);
		
		
		DrawShapedSprite("entities/block_64.png", center,finalSize, GetColorFromIdx(CURRENT_COLOR));
		DrawShapedSprite("sprites/block/eyes_contour.png", center,finalSize, GetColorFromIdx(CURRENT_COLOR));
		string overlay = GetOverlayNameFromIdx(CURRENT_OVERLAY);
		if(overlay != "")
			DrawShapedSprite(overlay, center,finalSize * 2, white);
		DrawShapedSprite("sprites/block/eyes.png", center, finalSize, white);
	}
	
	void onResume()
	{
	
	}
}

