
#include "Button.angelscript"

bool firstBoot = true;

class MainMenuScene : Scene
{
	private Button@ m_startGameButton;
	InterpolationTimer@ m_timer = InterpolationTimer(500);
	InterpolationTimer@ m_startTimer = InterpolationTimer(500);
	Bouncer@ m_notificationBouncer = Bouncer(vector2(1.2,1.2), V2_ONE);
	TextButton@ settings;
	TextButton@ stat;
	bool STARTING = false;
	bool LOADING = true;
	bool goingToSettings;
	bool goingToStatistics;
	uint loads = 0;
	float xPos;
	float mirrorXPos;
	vector2 notificationSize;
	vector2 notificationPos;
	vector2 notificationPos2;
	vector2 notificationPos3;
	Block[] blocks;

	MainMenuScene()
	{
		const string sceneName = "empty";
		super(sceneName);
	}

	void onCreated()
	{
		g_loader.load();
		g_overlay.load();
		g_dataManager.save();
		
		SetBackgroundColor(black);
		
		if(loads==0)
		{
			g_soundManager.create();
		}
	
		
	
		vector2 settingsPos = vector2(GetScreenSize().x/2, GetScreenSize().y*0.85);
		vector2 statPos = vector2(GetScreenSize().x/2, GetScreenSize().y*0.95);
		notificationSize = vector2(40,40) * GetScale();
		vector2 setSize = ComputeTextBoxSize("Verdana64.fnt","SETTINGS") * GetScale() / 2;
		vector2 statSize = ComputeTextBoxSize("Verdana64.fnt","STATISTICS") * GetScale() / 2;
		notificationPos = settingsPos + vector2(setSize.x, -setSize.y);
		notificationPos2 = settingsPos - vector2(setSize.x, setSize.y);
		notificationPos3 = statPos - vector2(statSize.x, statSize.y);
		@settings = TextButton(settingsPos, "SETTINGS", "Verdana64.fnt");
		@stat = TextButton(statPos, "STATISTICS", "Verdana64.fnt");
		
		LoadSprite("sprites/square.png");
		
		g_menuBlock.create();
		g_tipManager.create();

		m_timer.reset(500);	
		m_timer.setFilter(@smoothBeginning);
		m_startTimer.reset(500);
		STARTING = false;
		LOADING = true;
		goingToSettings = false;
		goingToStatistics = false;
		loads++;
		
		
		
		float textSizeX = ComputeTextBoxSize("Verdana64.fnt", "SCORE:  "+g_scoreManager.lastScore).x  * GetScale();
		xPos = (GetScreenSize().x - textSizeX)/2;		
		//xPos = 75*GetScale();
		mirrorXPos = GetScreenSize().x-xPos;
		
		g_adManager.showAd();
	}

	void onUpdate()
	{
	
		settings.update();
		if(settings.isPressed())
		{
			goingToSettings = true;
		}
		stat.update();
		if(stat.isPressed())
		{
			goingToStatistics = true;
		}
		
		m_notificationBouncer.update();	
		
		uint opacity = uint(255.0f*max(0,(1-m_startTimer.getBias()*2)));
		uint textColor = ARGB(opacity,255,255,255);
		uint redTextColor = ARGB(opacity,GetColorFromIdx(CURRENT_COLOR));
		settings.setColor(textColor);
		stat.setColor(textColor);
		g_tipManager.update(textColor);
		
		if(NEW_COLOR_UNLOCKED)
		{
			DrawShapedSprite("sprites/notification.png", notificationPos,notificationSize*m_notificationBouncer.getBounceScale(), ARGB(opacity,GetColorFromIdx(UNLOCKED_COLORS)));
		}
		
		if(NEW_OVERLAY_UNLOCKED)
		{
			DrawShapedSprite("sprites/notification.png", notificationPos2,notificationSize*m_notificationBouncer.getBounceScale(), ARGB(opacity,white));
		}
		
		if(NEW_HIGH_SCORE)
		{
			DrawShapedSprite("sprites/notification.png", notificationPos3,notificationSize*m_notificationBouncer.getBounceScale(), ARGB(opacity,white));
		}
		
	//	DrawText("SWIPE LEFT AND RIGHT TO TURN", "Verdana30.fnt", vector2(GetScreenSize().x/2, 50*GetScale()), V2_HALF, textColor);
	//	DrawText("COLLECT ENERGY", "Verdana30.fnt", vector2(GetScreenSize().x/2, 100*GetScale()), V2_HALF, textColor);
	//	DrawText("HOLD DOWN TO USE THE COLLECTED ENERGY", "Verdana30.fnt", vector2(GetScreenSize().x/2, 150*GetScale()), V2_HALF, textColor);
		
		
		if(g_scoreManager.lastScore != 0)
		{	
			DrawText("SCORE:", "Verdana64.fnt", vector2(xPos, 400*GetScale()), vector2(0,0), textColor);
			DrawText(""+g_scoreManager.lastScore, "Verdana64.fnt", vector2(mirrorXPos, 400*GetScale()), vector2(1,0), redTextColor);
		}
		
		
		
		
		g_menuBlock.update(goingToStatistics);
	
		if(LOADING)
		{
			uint overlayColor = ARGB(uint(255.0f*(1-m_timer.getBias())),0,0,0);
			DrawShapedSprite("sprites/square.png", V2_ZERO, GetScreenSize(), overlayColor);
			m_timer.update();
			if(m_timer.isOver())
			{
				LOADING = false;
				m_timer.reset(500);
			}
		}
		
		if(STARTING)
		{
			m_startTimer.update();
			if(m_startTimer.isOver())
			if(goingToSettings)
				g_sceneManager.setCurrentScene(SettingsScene());
			else if(goingToStatistics)
				g_sceneManager.setCurrentScene(StatScene());
			else
			{	
				g_adManager.hideAd();
				if(TUTORIAL)
					g_sceneManager.setCurrentScene(TutorialScene());
				else
					g_sceneManager.setCurrentScene(GameScene());
			}
		}
	
	
		if(GetInputHandle().GetTouchState(0) == KS_HIT && !STARTING)
		{
			STARTING = true;
			
			g_menuBlock.start(vector2(0, GetScreenSize().y*0.1));
		}
		
		
		/*
		m_startGameButton.putButton();
		if (m_startGameButton.isPressed())
		{
			m_startGameButton.setPressed(false);
			//g_sceneManager.setCurrentScene(GameScene());
			
		}
		*/
		updateBlocks(blocks);
	}
	
	void onResume()
	{
		g_sceneManager.setCurrentScene(MainMenuScene());
	}
}
