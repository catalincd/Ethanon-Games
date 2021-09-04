class DataManager
{
	void load()
	{
		CURRENT_COLOR = parseUInt(g_userDataManager.loadValue("data", "color", "0"));
		CURRENT_OVERLAY = parseUInt(g_userDataManager.loadValue("data", "overlay", "0"));
		UNLOCKED_OVERLAYS = parseUInt(g_userDataManager.loadValue("data", "unlockedOverlay", "0"));
		UNLOCKED_COLORS = parseUInt(g_userDataManager.loadValue("data", "unlocked", "0"));
		DRAWING_OVERLAYS = g_userDataManager.loadBoolean("data", "drawing", false);
		DRAWING_EYES = g_userDataManager.loadBoolean("data", "eyes", true);
		SHOW_TIPS = g_userDataManager.loadBoolean("data", "tips", true);
		ENABLE_ADS = g_userDataManager.loadBoolean("data", "ads", true);
		TOUCH_CONTROLS = g_userDataManager.loadBoolean("data", "touch", false);
		ENABLE_EFFECTS = g_userDataManager.loadBoolean("data", "effects", true);
		ENABLE_SOUND = g_userDataManager.loadBoolean("data", "sound", false);
		g_userDataManager.loadScore();
	}
	
	void save()
	{
		g_userDataManager.saveValue("data", "color", ""+CURRENT_COLOR);
		g_userDataManager.saveValue("data", "overlay", ""+CURRENT_OVERLAY);
		g_userDataManager.saveValue("data", "unlockedOverlay", ""+UNLOCKED_OVERLAYS);
		g_userDataManager.saveValue("data", "unlocked", ""+UNLOCKED_COLORS);
		g_userDataManager.saveBoolean("data", "drawing", DRAWING_OVERLAYS);
		g_userDataManager.saveBoolean("data", "eyes", DRAWING_EYES);
		g_userDataManager.saveBoolean("data", "tips", SHOW_TIPS);
		g_userDataManager.saveBoolean("data", "ads", ENABLE_ADS);
		g_userDataManager.saveBoolean("data", "touch", TOUCH_CONTROLS);
		g_userDataManager.saveBoolean("data", "effects", ENABLE_EFFECTS);
		g_userDataManager.saveBoolean("data", "sound", ENABLE_SOUND);
		g_userDataManager.saveValue("data", "beta", "1");
		
	}
	
	string getOwnedOverlays()
	{
		return g_userDataManager.loadValue("overlay", "array", "0");
	}
	
	void saveOwnedOverlays(string str)
	{
		g_userDataManager.saveValue("overlay", "array", str);
	}
}

DataManager g_dataManager;