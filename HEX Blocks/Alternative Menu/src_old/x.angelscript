class DataBase
{
	string BLOCK = "block";
	enmlFile achievements;
	enmlFile misc;
	uint achievements_index;
	
	void loadLevels()
	{
		
	}
	
	void reloadMisc()
	{
		const string path = GetExternalStorageDirectory()+"misc.kta";
		if(FileExists(path))
		{
		const string str = GetStringFromFile(path);

		//print(str);
		
		misc.parseString(str);
		
		//string name = f.get("myCar", "name");
		//string artist = f.get("theWall", "artist");

		//double myPi;
		//f.getDouble("numbers", "pi", myPi);

		//float posX;
		//f.getFloat("numbers", "posX", posX);

		//uint myInteger;
		//f.getUInt("numbers", "myInteger", myInteger);
		misc.getUInt("DATA", "TOTAL_XP", CURRENT_TOTAL_XP);
		misc.getUInt("DATA", "BEST_XP", BEST_XP);
		}
	}
	
	void loadAchievements()
	{
		const string path = GetExternalStorageDirectory()+"achievements.kta";
		if(FileExists(path))
		{
			const string str = GetStringFromFile(path);	
			achievements.parseString(str);
			
		}
	}
	
	
	void saveMisc()
	{
		enmlFile f;

		enmlEntity entity;
		entity.add("TOTAL_XP", ""+CURRENT_TOTAL_XP);
		entity.add("BEST_XP", ""+BEST_XP);
		g_achievementManager.getLastAch();
		entity.add("LASTACHIEVED", ""+g_achievementManager.lastAch);
		
		f.addEntity("DATA", entity);

		//entity.clear();
		

		string str = f.generateString();
		SaveStringToFile(GetExternalStorageDirectory()+"misc.kta", str);
	}
	
	
	void checkInstall()
	{
		const string path = GetExternalStorageDirectory()+"install.kta";
		const string path2 = GetExternalStorageDirectory()+"achievements.kta";
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
			
		}
		
	}
	
	void newAchievement(uint xi)
	{
		enmlFile f;
		enmlEntity entity;
		entity.add("TOTAL_XP", ""+CURRENT_TOTAL_XP);
		entity.add("BEST_XP", ""+BEST_XP);
		entity.add("LASTACHIEVED", ""+g_achievementManager.lastAch);
		f.addEntity("DATA", entity);
		string str = f.generateString();
		SaveStringToFile(GetExternalStorageDirectory()+"misc.kta", str);
		
		enmlEntity current;
		current.add("TPYE", ""+g_achievementManager.m_ach[xi].type);
		current.add("NAME", ""+g_achievementManager.m_ach[xi].name);
		current.add("PATH", ""+g_achievementManager.m_ach[xi].path);
		current.add("XPREQ", ""+g_achievementManager.m_ach[xi].xp_req);
		current.add("AQ", boolToString(true));
		dateTime dt;
		current.add("DATE",""+dt.getDay()+"/"+dt.getMonth()+"|"+dt.getYear());
		achievements.addEntity("ACH"+xi,current);
		print(xi);
		str = achievements.generateString();
		SaveStringToFile(GetExternalStorageDirectory()+"achievements.kta", str);
	}
	
	
	
}



void loadNewAchievements()
	{
		string str = GetStringFromFile(GetExternalStorageDirectory()+"new.kta");
		enmlFile fx;
		fx.parseString(str);
		newAchievement = stringToBool(fx.get("NEWACH", "EXIST"));
		print(boolToString(stringToBool(fx.get("NEWACH", "EXIST"))));
		if(newAchievement)
		{
			uint k = parseUInt(fx.get("NEWACH", "NUM"));
			newAch.resize(0);
			for(uint i=0;i<k;i++)
				newAch.insertLast(parseUInt(fx.get("NEWACH", "ACH"+i)));
			print(newAch.length());
		}
	}
	
	void saveNewAchievements()
	{
		enmlFile f;
		enmlEntity ent;
		ent.add("EXIST", "TRUE");
		ent.add("NUM", ""+newAch.length());
		for(uint i=0;i<newAch.length();i++)
			ent.add("ACH"+i, ""+newAch[i]);
		f.addEntity("NEWACH", ent);
		string str = f.generateString();
		SaveStringToFile(GetExternalStorageDirectory()+"new.kta", str);
	}
	
	void emptyNewAch()
	{
		enmlFile f;
		enmlEntity ent;
		ent.add("EXIST", "FALSE");
		f.addEntity("NEWACH", ent);
		string str = f.generateString();
		SaveStringToFile(GetExternalStorageDirectory()+"new.kta", str);
	}

DataBase data;