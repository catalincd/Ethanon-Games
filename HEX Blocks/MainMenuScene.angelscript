#include "Button.angelscript"
#include "Swyper.angelscript"
#include "Interpolator.angelscript"
class MainMenuScene : Scene
{
	uint alpha = 0;
	bool descending = false;
	vector2 boxSz = SCREEN_SIZE_2-(ComputeTextBoxSize("Verdana64.fnt","START")/2*GetScale());
	vector2 boxSz2;
	vector2 boxSz3;
	vector2 boxSz4;
	vector2 m_startPos;
	vector2 m_achpos;
	vector2 m_statsPos;
	vector2 m_settingsPos;
	vector2 m_supportPos;
	bool newH = false;
	float xScale = 0;
	bool ascX = true;
	uint hitTime;
	uint bestL = 1;
	string xStr;
	vector2 m_offset(0,0);
	float mainScale = 2;
	float opacity = 0;
	Swyper m_swyper;
	InterpolationTimer@ Zoomer = InterpolationTimer(300);
	bool switching = false;
	int switchingTo = 0;
	TextButton@ m_start;
	TextButton@ m_inventory;
	TextButton@ m_stats;
	TextButton@ m_delete;
	TextButton@ m_settings;
	TextButton@ m_support;
	string data1, data2, data3;
	
	MainMenuScene()
	{
		const string sceneName = "empty";
		super(sceneName);
	}

	void onResume()
	{
		g_setOrigin.resetAllOrigins();
		SetBackgroundColor(PRIM.getUInt());
		g_loader.load();
	}

	void onCreated()
	{
		g_loader.load();
		g_gameManager.setMainColorWhite();
		g_achievementManager.load();
		dataBase.loadPref();
		//g_gameManager.parseColors();
		const string resourceDir = GetResourceDirectory();
		SetBackgroundColor(PRIM.getUInt());
		dataBase.checkInstall();
		ForwardCommand("admob show 300");
		newH = false;
		if(FROM_GAME)
		{	
			string destDir = GetExternalStoragePath();
			uint tx = parseUInt(GetStringFromFile(destDir+"scr.eth"));
			if(tx<LAST_SCORE)
			{
				bestL = max(bestL,tx);
				BEST_SCORE = LAST_SCORE;
				SaveStringToFile(destDir+"scr.eth", ""+LAST_SCORE);
				newH = true;
				
			}
			else BEST_SCORE = tx;
			if(newH)
			xStr = float(uint(float(BEST_SCORE)/float(bestL)*100.0))/100.0+"x better";
			else
			xStr = uint(float(LAST_SCORE)/float(BEST_SCORE)*100)+"% of best score";
			boxSz4 = vector2(SCREEN_SIZE_X2, 230*GetScale())-(ComputeTextBoxSize("Verdana30.fnt",xStr)/2*GetScale());
			boxSz2 = vector2(SCREEN_SIZE_X2, 150*GetScale())-(ComputeTextBoxSize("Verdana30.fnt","SCORE: "+LAST_SCORE)/2*GetScale());
			
		}
		m_startPos = SCREEN_SIZE/2-vector2(0, 180*GetScale());
		@m_start = TextButton("START", "Comforta64.fnt", m_startPos, vector2(0,0));
		
		m_achpos = m_startPos+vector2(0, 100*GetScale());
		m_statsPos = m_achpos+vector2(0, 100*GetScale());
		m_settingsPos = m_statsPos+vector2(0, 100*GetScale());
		m_supportPos = m_settingsPos+vector2(0, 100*GetScale());
		
		@m_stats = TextButton("STATISTICS", dataBase.font64, m_statsPos, vector2(0,0));
		@m_inventory = TextButton("ACHIEVEMENTS", dataBase.font64, m_achpos, vector2(0,0));
		@m_settings = TextButton("SETTINGS", dataBase.font64, m_settingsPos, vector2(0,0));
		@m_support = TextButton("SUPPORT", dataBase.font64, m_supportPos, vector2(0,0));
		@m_delete = TextButton("DELETE", dataBase.font64, vector2(0,0), vector2(0,0));
		
		m_start.setSecondaryColor(SEC.getUInt());
		m_stats.setSecondaryColor(SEC.getUInt());
		m_delete.setSecondaryColor(SEC.getUInt());
		m_support.setSecondaryColor(SEC.getUInt());
		
		m_inventory.setColor(SEC.getUInt());
		m_inventory.setSecondaryColor(PRIM.getUInt());
		m_inventory.setFilter(@smoothBeginning);
		
		m_settings.setColor(SEC.getUInt());
		m_settings.setSecondaryColor(PRIM.getUInt());
		m_settings.setFilter(@smoothBeginning);
		
		
		Zoomer.setFilter(@smoothEnd);
		//print(GetScale());
		
		SetSharedData("TEXT", "NONE");
		
	}

	void onUpdate()
	{
		//DrawText(GetSharedData("TEXT"), dataBase.font64, SEC.getUInt(), vector2(SCREEN_SIZE_X,0), vector2(1,0), GetScale());
		Zoomer.update();
		
		
		m_start.setPos(m_startPos-m_start.getTextSize()*mainScale);
		m_inventory.setPos(m_achpos-m_inventory.getTextSize()*mainScale);
		m_stats.setPos(m_statsPos-m_stats.getTextSize()*mainScale);
		m_settings.setPos(m_settingsPos-m_settings.getTextSize()*mainScale);
		m_support.setPos(m_supportPos-m_support.getTextSize()*mainScale);
		
		m_start.setScale(mainScale);
		m_stats.setScale(mainScale);
		m_inventory.setScale(mainScale);
		m_settings.setScale(mainScale);
		m_support.setScale(mainScale);
		
		m_start.putButton();
		m_inventory.putButton();
		m_stats.putButton();
		m_settings.putButton();
		m_support.putButton();
		//m_delete.putButton();
		
		if(!switching)
		{
			mainScale = 2 - Zoomer.getBias();
			opacity = Zoomer.getBias();
		}
		else 
		{
			mainScale = 1 + Zoomer.getBias();
			opacity = 1-Zoomer.getBias();
			uint op = uint(255.0*opacity);
			m_start.setColor(ARGB(op, SEC));
			m_stats.setColor(ARGB(op, SEC));
			m_inventory.setColor(ARGB(op, SEC));
			m_settings.setColor(ARGB(op, SEC));
			m_support.setColor(ARGB(op, SEC));
			m_delete.setColor(ARGB(op, SEC));
			
		}
				uint blackk = ARGB(uint(255.0f*opacity), SEC);
				
				if(m_delete.isPressed())
				{
					m_delete.setPressed(false);
					string res = GetResourceDirectory();
					string text = GetStringFromFileInPackage(res + "gameData/achievements.kta");
					SaveStringToFile(GetExternalStorageDirectory()+"achievements.kta", text);
					
					string text2 = GetStringFromFileInPackage(res + "gameData/misc.kta");
					SaveStringToFile(GetExternalStorageDirectory()+"misc.kta", text2);
					g_achievementManager.load();
					dataBase.loadPref();
					dataBase.loadMisc();
				}

		/*
		//m_swyper.updateMain();
		//m_offset.x = m_swyper.getOffset();
		//if(GetInputHandle().GetKeyState(K_LMOUSE)==KS_HIT)Zoomer.reset(300);
		string data = vector3ToString(round(GetInputHandle().GetAccelerometerData(), 1));
		if(descending)
		{
			alpha-=8;
			if(alpha<=7) {alpha = 0;descending = false;}
		}
		if(!descending)
		{
			alpha+=8;	
			if(alpha>=255) {alpha = 255;descending = true;}
		}
		uint xalph = switching? uint(255*opacity):alpha;
		uint xalph2 = switching? uint(255*opacity):(255-alpha);
		//m_start.setColor(ARGB(xalph,0,0,0));
		//m_inventory.setColor(ARGB(xalph2,0,0,0));
		//drawText(boxSz+m_offset, "START", "Verdana64.fnt", ARGB(xalph,0,0,0), mainScale);
	
		boxSz4 = vector2(SCREEN_SIZE_X2, 230*GetScale())-(ComputeTextBoxSize("Verdana30.fnt",xStr)/2*GetScale()*mainScale);
		boxSz2 = vector2(SCREEN_SIZE_X2, 150*GetScale())-(ComputeTextBoxSize("Verdana30.fnt","SCORE: "+LAST_SCORE)/2*GetScale()*mainScale);

	
		if(newH)
		{
			if(ascX) {xScale+=2.5;if(xScale>50){xScale = 50; ascX = false;}}
			if(!ascX) {xScale-=2.5;if(xScale<0){xScale = 0; ascX = true;}}
			boxSz3 = vector2(SCREEN_SIZE_X2,50*GetScale())-(ComputeTextBoxSize("Verdana30.fnt","New highscore")/2*(0.75+(xScale/200))*GetScale());
			DrawText(boxSz3+m_offset, "New highscore!", "Verdana30.fnt", blackk, (0.75+(xScale/200))*GetScale()*mainScale);
		}
	
		if(FROM_GAME)
		{
			drawText(boxSz2+m_offset, "SCORE: "+LAST_SCORE, "Verdana30.fnt", blackk, mainScale);
			drawText(boxSz4+m_offset, xStr, "Verdana30.fnt", blackk, mainScale);
		}
		//if (GetInputHandle().GetTouchState(0) == KS_HIT)
		*/
		if(m_start.isPressed() && !switching)
		{	
			m_start.setPressed(false);
			switching = true;
			hitTime = GetTime();
			Zoomer.reset(300);
			switchingTo = 1;
			ForwardCommand("admob hide 300");
		}
		if(m_inventory.isPressed() && !switching)
		{	
			m_inventory.setPressed(false);
			switching = true;
			hitTime = GetTime();
			Zoomer.reset(300);
			switchingTo = 2;
		}
		
		if(m_stats.isPressed() && !switching)
		{	
			m_stats.setPressed(false);
			switching = true;
			hitTime = GetTime();
			Zoomer.reset(300);
			switchingTo = 3;
		}
		
		if(m_settings.isPressed() && !switching)
		{	
			m_settings.setPressed(false);
			switching = true;
			hitTime = GetTime();
			Zoomer.reset(300);
			switchingTo = 4;
		}
		if (switching && GetTime()-hitTime>300)
		{	
			GAME_OVER = false;
			if(switchingTo == 1)
				g_sceneManager.setCurrentScene(GameScene());
			if(switchingTo == 2)
				g_sceneManager.setCurrentScene(TraySelector());
			if(switchingTo == 3)
				g_sceneManager.setCurrentScene(StatsScene());
			if(switchingTo == 4)
				g_sceneManager.setCurrentScene(SettingsScene());
		}
	}
}
