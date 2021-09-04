class DateTime
{
	uint day,month,year;
	
	DateTime(){}
	
	DateTime(string str)
	{
		uint s = str.find("/");
		uint b = str.find("|");
		day = parseUInt(str.substr(0, s));
		month = parseUInt(str.substr(s+1, b-s));
		year = parseUInt(str.substr(b+1, NPOS));
	}
	
	void set(string str)
	{
		uint s = str.find("/");
		uint b = str.find("|");
		day = parseUInt(str.substr(0, s));
		month = parseUInt(str.substr(s+1, b-s));
		year = parseUInt(str.substr(b+1, NPOS));
	}
	
	void setNow()
	{
		dateTime dt;
		day = dt.getDay();
		month = dt.getMonth();
		year = dt.getYear();
	}
	
	void set(uint d, uint m, uint y)
	{
		day = d;
		month = m;
		year = y;
	}
	
	string get()
	{
		return (""+day+"/"+month+"|"+year);
	}
	
	string getNormal()
	{
		return (""+day+" / "+month+" / "+year);
	}
}