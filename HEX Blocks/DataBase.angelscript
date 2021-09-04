class DataBase
{
	string BLOCK = "block";
	string BLOCK_I = "block";
	string pixel = "sprites/white.png";
	string font30 = "Comforta30.fnt";
	string font20 = "Comforta20.fnt";
	string font40 = "Comforta45.fnt";
	string font64 = "Comforta64.fnt";
	enmlFile misc;
	
	
	void loadMisc()
	{
		const string path = GetExternalStorageDirectory()+"misc.kta";
		
		if(FileExists(path))
		{
		const string str = GetStringFromFile(path);
		misc.parseString(str);
		misc.getUInt("DATA", "TOTAL_XP", CURRENT_TOTAL_XP);
		misc.getUInt("DATA", "BEST_XP", BEST_XP);
		misc.getFloat("DATA", "TIME", CURRENT_TOTAL_TIME);
		misc.getUInt("DATA", "GAMES", GAMES_PLAYED);
		}
	}
	
	void saveMisc()
	{
		enmlFile f;
		enmlEntity entity,entity2;
		entity.add("TOTAL_XP", ""+CURRENT_TOTAL_XP);
		entity.add("BEST_XP", ""+BEST_XP);
		entity.add("TIME", ""+CURRENT_TOTAL_TIME);
		entity.add("GAMES", ""+GAMES_PLAYED);
		f.addEntity("DATA", entity);
		
		entity2.add("BALL", g_gameManager.m_mainBall);
		entity2.add("BACK", ""+g_gameManager.background);
		entity2.add("TRAY", g_gameManager.tray);
		entity2.add("ROTATE", ""+g_gameManager.rotate);
		entity2.add("BLOCKS", BLOCK_I);
		entity2.add("COLOR", ""+g_gameManager.color);
		entity2.add("SUFIX", g_gameManager.sufix);
		
		f.addEntity("PREF", entity2);
		string str = f.generateString();
		SaveStringToFile(GetExternalStorageDirectory()+"misc.kta", str);
	}
	
	void loadPref()
	{
		const string path = GetExternalStorageDirectory()+"misc.kta";
		
		if(FileExists(path))
		{
		const string str = GetStringFromFile(path);
		misc.parseString(str);
		g_gameManager.m_mainBall = misc.get("PREF", "BALL");
		g_gameManager.tray = misc.get("PREF", "TRAY");
		g_gameManager.sufix = misc.get("PREF", "SUFIX");
		g_gameManager.setColor(parseUInt(misc.get("PREF", "COLOR")));
		g_gameManager.background = parseUInt(misc.get("PREF", "BACK"));
		g_gameManager.rotate = parseUInt(misc.get("PREF", "ROTATE"));
		g_effector.background = g_gameManager.background;
		BLOCK_I = misc.get("PREF", "BLOCKS");
		g_gameManager.refresh();
		}
	}
	
	
	void checkInstall()
	{
		const string path = GetExternalStorageDirectory()+"install.kta";
		if(!FileExists(path))
		{
			dateTime dt;
			enmlFile f;
			enmlEntity entity;
			entity.add("DAY", ""+dt.getDay());
			entity.add("MONTH", ""+dt.getMonth());
			entity.add("YEAR", ""+dt.getYear());
			
			f.addEntity("DATE", entity);

			string str = f.generateString();
			SaveStringToFile(GetExternalStorageDirectory()+"install.kta", str);
			string res = GetResourceDirectory();
			string text = GetStringFromFileInPackage(res + "gameData/achievements.kta");
			SaveStringToFile(GetExternalStorageDirectory()+"achievements.kta", text);
		}
		
	}
	
}


DataBase dataBase;