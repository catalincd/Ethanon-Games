class ProgressManager
{
	void load()
	{
		LEVEL = parseUInt(data.loadValue("progress", "level", "0"));
		CASUAL_WIDTH = parseUInt(data.loadValue("progress", "casualw", "5"));
	}
	
	void save()
	{
		data.saveValue("progress", "level", ""+LEVEL);
		data.saveValue("progress", "casualw", ""+CASUAL_WIDTH);
	}
}

ProgressManager progress;




uint getMaxWidth(uint level)
{
	return min(15, (level / 10) + 5);
}

uint getMaxWidth()
{
	return getMaxWidth(LEVEL);
}