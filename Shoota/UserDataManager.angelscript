const string ETH_FRAMEWORK_USER_DATA_FILE_NAME = "data.enml";
const string INVENTORY = "inventory.enml";

class UserDataManager
{
	void saveValue(const string &in entity, const string &in valueName, const string &in value, const string fileName = ETH_FRAMEWORK_USER_DATA_FILE_NAME)
	{
		const string filePath = GetExternalStoragePath() + fileName;
		const string content = GetStringFromFile(filePath);
		enmlFile userData;
		userData.parseString(content);
		userData.addValue(entity, valueName, value);
		userData.writeToFile(filePath);
	}

	string loadValue(const string &in entity, const string &in valueName, const string &in defaultValue, const string fileName = ETH_FRAMEWORK_USER_DATA_FILE_NAME)
	{
		const string filePath = GetExternalStoragePath() + fileName;
		const string content = GetStringFromFile(filePath);
		enmlFile userData;
		userData.parseString(content);
		const string value = userData.get(entity, valueName);
		return (value != "") ? value : defaultValue;
	}
	
	void saveFloat(const string &in entity, const string &in valueName, const float value, const string fileName = ETH_FRAMEWORK_USER_DATA_FILE_NAME)
	{
		saveValue(entity, valueName, "" + value, fileName);
	}

	float loadFloat(const string &in entity, const string &in valueName, const float defaultValue, const string fileName = ETH_FRAMEWORK_USER_DATA_FILE_NAME)
	{
		const string value = loadValue(entity, valueName, "" + defaultValue, fileName);
		return ParseFloat(value);
	}

	void saveBoolean(const string &in entity, const string &in valueName, const bool value, const string fileName = ETH_FRAMEWORK_USER_DATA_FILE_NAME)
	{
		saveValue(entity, valueName, boolToString(value), fileName);
	}

	bool loadBoolean(const string &in entity, const string &in valueName, const bool defaultValue, const string fileName = ETH_FRAMEWORK_USER_DATA_FILE_NAME)
	{
		const string value = loadValue(entity, valueName,  boolToString(defaultValue), fileName);
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
