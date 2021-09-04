class DataBase
{
	Entry@[] entries;


	DataBase()
	{
		init();
	}
	
	void init()
	{
		entries.resize(0);
		entries.insertLast(Entry("prefChar", "0"));
		entries.insertLast(Entry("highScore", "0"));
	}
	
	void load()
	{
		for(uint i=0;i<entries.length();i++)
		{
			entries[i].value = data.loadValue("data", entries[i].name, entries[i].defaultValue);
		}
	}
	
	void save()
	{
		for(uint i=0;i<entries.length();i++)
		{
			data.saveValue("data", entries[i].name, entries[i].value);
		}
	}
	
	string get(string name)
	{
		for(uint i=0;i<entries.length();i++)
		{
			if(entries[i].name == name)
				return entries[i].value;
		}
		return "";
	}
	
	void set(string name, string value)
	{
		for(uint i=0;i<entries.length();i++)
		{
			if(entries[i].name == name)
			{
				entries[i].value = value;
				return;
			}
		}
	}
	
}


uint PREF_CHAR = 0;


DataBase dataBase;


class Entry
{
	string name;
	string value;
	string defaultValue;
	
	//Entry(){}
	Entry(string _name, string _defaultValue, string _value = "")
	{
		name = _name;
		value = _value;
		defaultValue = _defaultValue;
	}
	
	
}