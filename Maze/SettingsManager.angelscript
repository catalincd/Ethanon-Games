class SettingsManager
{
	Setting@[] settings;
	

	
	void init()
	{
		settings.resize(0); 
		
		
		settings.insertLast(SET_ads);
		settings.insertLast(SET_sens);
		settings.insertLast(SET_touchScale);
		settings.insertLast(SET_touchControls);
		settings.insertLast(SET_touchFixed);//4
	}
	
	
	void load()
	{
		for(uint i=0;i<settings.length();i++)
		{
			settings[i].load();
		}
		ASSIGN_VALUES();
	}
	
	void save()
	{
		for(uint i=0;i<settings.length();i++)
		{
			settings[i].save();
		}
		ASSIGN_VALUES();
	}
	
	void create()
	{
		for(uint i=0;i<settings.length();i++)
		{
			float y = (250 + i * 175) * GetScale();
			float xt = 100 * GetScale();
			float xs = 800 * GetScale();
		
			settings[i].create(vector2(xt, y), vector2(xs, y));
		}
	}
	
	void update()
	{
		for(uint i=0;i<settings.length();i++)
		{
			settings[i].update(1.0f, white);
		}
		ASSIGN_VALUES();
		
		//settings[3].hidden = !TOUCH_CONTROLS;
		settings[4].hidden = !TOUCH_CONTROLS;
	}
}

SettingsManager g_settings;