class DataManager
{
	
	void load()
	{
		SOUND_ON = g_userDataManager.loadBoolean("settings", "sound", true);
	}
	
	void saveSettings()
	{
		g_userDataManager.saveBoolean("settings", "sound", SOUND_ON);
	}
	

	void saveInventory(uint autos)
	{
		string str = g_mainInventory.getString();
		g_userDataManager.saveValue("data", "inventory", str);
		g_userDataManager.saveValue("data", "autos", ""+autos);
	}

	void loadInventory()
	{
		string str = g_userDataManager.loadValue("data", "inventory", "");
		uint autos = parseUInt(g_userDataManager.loadValue("data", "autos", "0"));
		g_mainInventory.fill(str, autos);
	}
	
	
	void saveTurrets(string str)
	{
		g_userDataManager.saveValue("data", "turrets", str);
	}

	string loadTurrets()
	{
		return g_userDataManager.loadValue("data", "turrets", "1,6");
	}
	
	void saveExp()
	{
		string str = ""+EXP;
		g_userDataManager.saveValue("progress", "exp", str);
	}
	
	void loadExp()
	{
		string str = g_userDataManager.loadValue("progress", "exp", "0");
		EXP = parseUInt(str);
	}
	
	void saveRankup()
	{
		g_userDataManager.saveBoolean("progress", "rankup", RANK_UP);
	}
	
	void getRankup()
	{
		RANK_UP = g_userDataManager.loadBoolean("progress", "rankup", false);
	}
	
	
	void saveFunds()
	{
		g_userDataManager.saveValue("progress", "funds", ""+FUNDS);
	}
	
	void loadFunds()
	{
		FUNDS = parseUInt(g_userDataManager.loadValue("progress", "funds", "0"));
	}
	
	void saveSettings(string str)
	{
		g_userDataManager.saveValue("settings", "set", str);
	}
	
	string loadSettings()
	{
		return g_userDataManager.loadValue("settings", "set", "");
	}
}


DataManager g_dataManager;

bool SOUND_ON = true;