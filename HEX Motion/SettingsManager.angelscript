class SettingsManager
{
	SlideSetting@[] m_slides;
	CheckSetting@[] m_settings;
	Text@ m_back;
	Text@ m_restart;
	bool backin = false;
	
	bool back()
	{
		return backin;
	}
	
	void insertCheck(string path)
	{
		const string str = GetStringFromFileInPackage(GetResourceDirectory() +"settings/" +path);
		enmlFile f;
		f.parseString(str);
		uint id = parseUInt(f.get("data","id"));
		string name = f.get("data","name");
		bool en = parseBoolFromUInt(f.get("data", "enabled"));
		m_settings.insertLast(CheckSetting(id, name, en));
	}
	
	void insert(string path)
	{
		const string str = GetStringFromFileInPackage(GetResourceDirectory() +"settings/" +path);
		enmlFile f;
		f.parseString(str);
		uint id = parseUInt(f.get("data","id"));
		uint len = parseUInt(f.get("data","len"));
		uint current = parseUInt(f.get("data","current"));
		string name = f.get("data","name");
		string[] names;
		for(uint i=0;i<len;i++)
			names.insertLast(f.get("names", "name"+i));
		m_slides.insertLast(SlideSetting(id, name, len, names, current, path));
	}
	
	void create()
	{
		insert("set_aliasing.enml");
		//insert("set_fps.enml");
		insertCheck("set_showFps.enml");
		@m_back = Text(vector2(g_scale.SCREEN_SIZE_X2, 650*GetScale()), "BACK");
		@m_restart = Text(vector2(200, 550)*GetScale(), "*RESTARTING THE APP IS REQUIRED TO APPLY SOME SETTINGS", "Verdana20.fnt", white, 1, vector2(0,0.5));
		for(uint i=0;i<m_slides.length();i++)
		{
			//m_slides[i].create();
		}
	}
	
	
	
	void update(float bias)
	{
		for(uint i=0;i<m_slides.length();i++)
		{
			m_slides[i].update(bias);
			if(m_slides[i].deselectOthers())
			{
				for(uint q=0;q<m_slides.length();q++)
					m_slides[q].deselect();
				for(uint q=0;q<m_settings.length();q++)
					m_settings[q].deselect();
					m_slides[i].selected = true;
			}
		}
		for(uint i=0;i<m_settings.length();i++)
		{
			m_settings[i].update(bias);
			if(m_settings[i].deselectOthers())
			{
				for(uint q=0;q<m_settings.length();q++)
					m_settings[q].deselect();
				for(uint q=0;q<m_slides.length();q++)
					m_slides[q].deselect();
				m_settings[i].selected = true;
			}
		}
		backin = m_back.buttonDraw(ARGB(bias, whiteF));
		m_restart.drawColored(ARGB(bias, whiteF));
		if(backin)
		{
			SaveMSAA();
		}
	}
	
	void SaveMSAA()
	{
		uint q = m_slides[0].current;
		m_slides[0].save();
		uint set;
		if(q!=0)
		{
			set = pow(2,q);
		}
		else set=0;
		SaveStringToFile(GetResourceDirectory() +"/msaa.enml", ""+set);
	}
	
}

SettingsManager g_settingsManager;