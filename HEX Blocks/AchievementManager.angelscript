class AchievementManager
{
	Achievement[] m_ach;
	uint m_achieventsNum;
	uint m_lastAchieved;
	enmlFile File;
	
	
	void load()
	{
		m_ach.resize(0);
		const string path = GetExternalStorageDirectory()+"achievements.kta";
		const string str = GetStringFromFile(path);	
		File.parseString(str);
		m_achieventsNum = parseUInt(File.get("DATA", "NUM"));
		m_lastAchieved = parseUInt(File.get("DATA", "LAST"));
		load(m_achieventsNum);
	}
	
	
	void load(uint index)
	{
		for(uint i=0;i<index;i++)
		{
			Achievement aux;
			File.getUInt("ACH"+i, "TYPE", aux.type);
			aux.name = File.get("ACH"+i, "NAME");
			aux.argument = File.get("ACH"+i, "ARG");
			File.getUInt("ACH"+i, "XPREQ",aux.xp_req);
			aux.type = parseUInt(File.get("ACH"+i, "TYPE"));
			aux.path = File.get("ACH"+i, "PATH");
			aux.aq = stringToBool(File.get("ACH"+i, "AQ"));
			aux.new = stringToBool(File.get("ACH"+i, "NEW"));
			aux.aq_date.set(File.get("ACH"+i, "DATE"));
			m_ach.insertLast(aux);
		}
	}
	
	void save()
	{
		enmlFile FileW;
		
		enmlEntity dat;
		dat.add("NUM", ""+m_achieventsNum);
		dat.add("LAST", ""+m_lastAchieved);
		FileW.addEntity("DATA",dat);
		
		for(uint i=0;i<m_achieventsNum;i++)
		{
			enmlEntity aux;
			aux.add("TYPE", ""+m_ach[i].type);
			aux.add("NAME", m_ach[i].name);
			aux.add("ARG", m_ach[i].argument);
			aux.add("XPREQ", ""+m_ach[i].xp_req);
			aux.add("TYPE", ""+m_ach[i].type);
			aux.add("PATH", m_ach[i].path);
			aux.add("AQ", boolToString(m_ach[i].aq));
			aux.add("NEW", boolToString(m_ach[i].new));
			aux.add("DATE", m_ach[i].aq_date.get());
			FileW.addEntity("ACH"+i,aux);
		}
		
		const string str = FileW.generateString();
		SaveStringToFile(GetExternalStorageDirectory()+"achievements.kta", str);
	}
	
	
	uint getXpReq()
	{
		if(m_lastAchieved<m_achieventsNum)
			return m_ach[m_lastAchieved].xp_req;
		else 
			return 0;
	}
	
	void newAchievement()
	{
		m_ach[m_lastAchieved].aq = true;
		m_ach[m_lastAchieved].new = true;
		m_ach[m_lastAchieved].aq_date.setNow();
		m_lastAchieved++;
	}
	
	void emptyNews()
	{
		for(uint i=0;i<m_achieventsNum;i++)
		{
			m_ach[i].new = false;
		}
		save();
	}
	
}

AchievementManager g_achievementManager;