const string ETH_FRAMEWORK_USER_DATA_FILE_NAME = "hexdata.enml";
const string ETH_FRAMEWORK_SCORE_FILE_NAME = "hexscore.enml";
const string ETH_FRAMEWORK_TIME_FILE_NAME = "hextime.enml";

class UserDataManager
{
	void saveValue(const string &in entity, const string &in valueName, const string &in value)
	{
		const string filePath = GetExternalStoragePath() + ETH_FRAMEWORK_USER_DATA_FILE_NAME;
		const string content = GetStringFromFile(filePath);
		enmlFile userData;
		userData.parseString(content);
		userData.addValue(entity, valueName, value);
		userData.writeToFile(filePath);
	}

	string loadValue(const string &in entity, const string &in valueName, const string &in defaultValue)
	{
		const string filePath = GetExternalStoragePath() + ETH_FRAMEWORK_USER_DATA_FILE_NAME;
		const string content = GetStringFromFile(filePath);
		enmlFile userData;
		userData.parseString(content);
		const string value = userData.get(entity, valueName);
		return (value != "") ? value : defaultValue;
	}
	
	void saveTime()
	{
		const string filePath = GetExternalStoragePath() + ETH_FRAMEWORK_TIME_FILE_NAME;
		const string content = GetStringFromFile(filePath);
		enmlFile userData;
		userData.parseString(content);
		userData.addValue("data", "timePlayed", ""+TIME_PLAYED_SECONDS);
		userData.writeToFile(filePath);
	}

	void loadTime()
	{
		const string filePath = GetExternalStoragePath() + ETH_FRAMEWORK_TIME_FILE_NAME;
		const string content = GetStringFromFile(filePath);
		enmlFile userData;
		userData.parseString(content);
		TIME_PLAYED_SECONDS = parseUInt(userData.get("data", "timePlayed"));
	}

	void saveScore()
	{
		const string filePath = GetExternalStoragePath() + ETH_FRAMEWORK_SCORE_FILE_NAME;
		const string content = GetStringFromFile(filePath);
		enmlFile userData;
		userData.parseString(content);
		userData.addValue("data", "highScore", ""+HIGH_SCORE);
		userData.addValue("data", "scoreCount", ""+CURRENT_SCORE_COUNT);
		userData.addValue("data", "scoreAvg", ""+CURRENT_SCORE_AVG);
		userData.addValue("data", "coins", ""+TOTAL_BOOST_COINS);
		userData.addValue("data", "games", ""+GAMES_PLAYED);
		userData.writeToFile(filePath);
		saveTime();
	}
	
	void loadScore()
	{
		const string filePath = GetExternalStoragePath() + ETH_FRAMEWORK_SCORE_FILE_NAME;
		const string content = GetStringFromFile(filePath);
		enmlFile userData;
		userData.parseString(content);
		HIGH_SCORE = parseUInt(userData.get("data", "highScore"));
		CURRENT_SCORE_COUNT = parseUInt(userData.get("data", "scoreCount"));
		CURRENT_SCORE_AVG = parseUInt(userData.get("data", "scoreAvg"));
		TOTAL_BOOST_COINS = parseUInt(userData.get("data", "coins"));
		GAMES_PLAYED = parseUInt(userData.get("data", "games"));
		loadTime();		
	}

	void saveFloat(const string &in entity, const string &in valueName, const float value)
	{
		saveValue(entity, valueName, "" + value);
	}

	float loadFloat(const string &in entity, const string &in valueName, const float defaultValue)
	{
		const string value = loadValue(entity, valueName, "" + defaultValue);
		return ParseFloat(value);
	}

	void saveBoolean(const string &in entity, const string &in valueName, const bool value)
	{
		saveValue(entity, valueName, boolToString(value));
	}

	bool loadBoolean(const string &in entity, const string &in valueName, const bool defaultValue)
	{
		const string value = loadValue(entity, valueName,  boolToString(defaultValue));
		return isTrue(value);
	}

	string boolToString(const bool value)
	{
		return value ? "true" : "false";
	}

	bool isTrue(const string &in value)
	{
		if (value == "true" || value == "TRUE" || value == "YES" || value == "yes")
			return true;
		else
			return false;
	}
}

UserDataManager g_userDataManager;
