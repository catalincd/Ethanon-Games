class Time
{
	uint hrs=0, mins=0, secs=0;
	bool timeLoaded = false;
	Time(){}
	
	Time(string str)
	{
		uint s = str.find("/");
		uint b = str.find("|");
		hrs = parseUInt(str.substr(0, s));
		mins = parseUInt(str.substr(s+1, b-s));
		secs = parseUInt(str.substr(b+1, NPOS));
	}
	
	void set(string str)
	{
		uint s = str.find("/");
		uint b = str.find("|");
		hrs = parseUInt(str.substr(0, s));
		mins = parseUInt(str.substr(s+1, b-s));
		secs = parseUInt(str.substr(b+1, NPOS));
	}
	
	
	void set(uint d, uint m, uint y)
	{
		hrs = d;
		mins = m;
		secs = y;
	}
	
	void add(uint _secs)
	{
		print(_secs);
		secs +=_secs%60;
		uint min2 = -secs/60;
		mins += min2%60;
		hrs += min2/60;
		limit();
	}
	
	void limit()
	{
		mins += secs/60;
		hrs += mins/60;
		mins %= 60;
		secs %= 60;
	}
	
	
	string get()
	{
		return (""+hrs+"/"+mins+"|"+secs);
	}
	
	string getNormal()
	{
		return (""+hrs+" HOURS  "+mins+" MINUTES");
	}

}

Time g_timeManager;