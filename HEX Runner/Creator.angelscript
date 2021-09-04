class Creator : GameObject
{
	BlockArray[] vector;
	uint len;
	ETHEntityArray allEnt;
	float limit = GetScreenSize().y+200;
	int ads = 0;
	uint added = 0;
	int lastQ = -1;
	int lastAdd = -15;
	float distanceFactor;
	
	
	Creator()
	{
		string str;
		str = GetStringFromFileInPackage(GetResourceDirectory() +"arrays/data.enml");
		enmlFile f;
		f.parseString(str);
		len = parseUInt(f.get("data", "len"));
		for(uint i=0;i<len;i++)
		{
			vector.insertLast(BlockArray("array"+i+".enml"));
		}
	}
	
	void create()
	{	
		added = 0;
		lastAdd = -20;
		distanceFactor = 1366 * GetScale();
	}
	
	
	void update()
	{
		if(abs(camToInt()-lastAdd)<21)
		{
			lastAdd -= g_creator.create(lastAdd, allEnt);
			ads++;
		}
		delete();
	}
	
	void insertEntity(ETHEntity@ new)
	{
		allEnt.Insert(new);
	}
	
	void resume()
	{
		
	}

	void explodeEntities()
	{
		vector2 position = g_block.thisEntity.GetPositionXY();
		for(uint t=0;t<allEnt.Size();t++)
		{
			if(distance(allEnt[t].GetPositionXY(), position) < distanceFactor)
			{
				allEnt[t].SetUInt("delete", 1);
			}
		}
	}

	int create(int pos, ETHEntityArray& arr)
	{
		int q;
		if(added == ARRAYS_UNTIL_BREAK)
		{
			added = 0;
			q = 0;
		}
		else
		{
		q = rand(1, len-1);
		while(q==lastQ)
			q = rand(1, len-1);
		}
		if(!isEnergyOn())	
			added++;
		lastQ = q;
		
		
		return vector[q].add(pos,arr);
	}
	
	void delete()
	{
		const uint t = allEnt.Size();
		
		for(uint i=0;i<t;i++)
		{
			if(allEnt[i].GetPositionY()>GetCameraPos().y+limit)
			{
				DeleteEntity(allEnt[i]);
			}
		}
		allEnt.RemoveDeadEntities();
	}

	string getTag()
	{
		return "Creator";
	}
	
	int camToInt()
	{
		return (int(GetCameraPos().y)/(BLOCK_HEIGHT*GetScale())-1);
	}
	
	
}

Creator g_creator;