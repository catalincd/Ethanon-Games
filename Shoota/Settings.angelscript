float xArrowOffset;
float xArrowPos;
float xNegativeOffset;
float xTextPos;


class SettingsScene : Scene
{
	TextButton@ backButton;
	Setting[] settings;
	float xOffset;
	
	
	float yOffset;
	float ySize;

	SettingsScene()
	{
		super("empty");
	}
	
	void initSettings()
	{
		settings.resize(0);
		settings.insertLast(Setting("ENEMY INIT FACTOR", 0, 1));
		settings.insertLast(Setting("ENEMY FINAL FACTOR", 1, 1));
		settings.insertLast(Setting("ENEMY SPEED RATE", 2, 0.1f));
		settings.insertLast(Setting("ENEMY DAMAGE RATE", 3, 0.1f));
		settings.insertLast(Setting("ENEMY SPAWN RATE", 5, 0.1f));
		settings.insertLast(Setting("TURRET DAMAGE RATE", 4, 0.1f));

		xOffset = PX_100*1.25f;
		xArrowOffset = PX_100*1.5f;
		xNegativeOffset = GetScreenSize().x-xOffset;
		xTextPos = xNegativeOffset - (xArrowOffset * 0.5f);
		xArrowPos = xNegativeOffset - xArrowOffset;
		yOffset = PX_200*1.5f;
		ySize = PX_100;
	
		
	}
	
	void onCreated()
	{
		initSettings();
		@backButton = TextButton(vector2(GetScreenSize().x * 0.5, GetScreenSize().y * 0.9), "BACK", text128, black, true);

	}
	
	void onUpdate()
	{
		backButton.update();
		if(backButton.isPressed())
		{
			saveSettings();
			backButton.setPressed(false);
			g_sceneManager.transition(MainMenuScene());
		}
		updateSettings();
	}
	
	void updateSettings()
	{
		for(uint i=0;i<settings.length();i++)
		{
			vector2 thisPos = vector2(xOffset, yOffset + ySize * i);
			DrawSetting(settings[i], thisPos);
		}
	}
	
	void loadSettings()
	{
		string set = g_dataManager.loadSettings();
		if(set != "")
		{
			initSettings();
			float[] vals = getFloatArrayFromString(set);
			for(uint i=0;i<settings.length();i++)
			{
				setValue(settings[i].changeId, vals[i]);
			}
		}
	}
	
	void saveSettings()
	{
		initSettings();
		float[] vals;
		for(uint i=0;i<settings.length();i++)
		{
			vals.insertLast(getValue(settings[i].changeId));
		}
		g_dataManager.saveSettings(getStringFromFloatArray(vals));
	}
	
	
	void onResume()
	{
	
	}
}

void loadSettings()
{
	SettingsScene().loadSettings();
}

void DrawSetting(Setting set, vector2 pos)
{
	DrawText(set.name, sans64, pos, black, vector2(0.0f, 0.5f));
	vector2 buttonPos = vector2(xNegativeOffset, pos.y);
	DrawSettingButton(set.changeId, set.inc, buttonPos);
}

void DrawSettingButton(uint id, float off, vector2 pos)
{
	
	bool inc = putButton("sprites/arrow_right.png", pos, GetScale()*1.5f, vector2(0.5f, 0.5f), black, 0.0f);
	bool dec = putButton("sprites/arrow_left.png", vector2(xArrowPos, pos.y), GetScale()*1.5f, vector2(0.5f, 0.5f), black, 0.0f);
	if(inc)changeValue(id, off);
	if(dec)changeValue(id, -off);
	
	float value = getValue(id);
	DrawText(""+value, sans64, vector2(xTextPos, pos.y), red, vector2(0.5f, 0.5f));
}


class Setting
{
	string name;
	float inc;
	uint changeId;
	Setting(){}
	
	Setting(string n, uint id, float i = 0.1f)
	{
		name = n;
		inc = i;
		changeId = id;
	}
}

void setValue(uint id, float value)
{
	if(id == 0)INIT_ENEMY_RATE = value;
	if(id == 1)LAST_ENEMY_RATE = value;
	if(id == 2)ENEMY_SPEED_RATE = value;
	if(id == 3)ENEMY_DAMAGE_RATE = value;
	if(id == 4)DAMAGE_RATE = value;
	if(id == 5)SPAWN_RATE = value;
}

void changeValue(uint id, float value)
{
	if(id == 0)INIT_ENEMY_RATE += value;
	if(id == 1)LAST_ENEMY_RATE += value;
	if(id == 2)ENEMY_SPEED_RATE += value;
	if(id == 3)ENEMY_DAMAGE_RATE += value;
	if(id == 4)DAMAGE_RATE += value;
	if(id == 5)SPAWN_RATE += value;
}

float getValue(uint id)
{
	if(id == 0)return INIT_ENEMY_RATE;
	if(id == 1)return LAST_ENEMY_RATE;
	if(id == 2)return ENEMY_SPEED_RATE;
	if(id == 3)return ENEMY_DAMAGE_RATE;
	if(id == 4)return DAMAGE_RATE;
	if(id == 5)return SPAWN_RATE;
	return 0.0f;
}