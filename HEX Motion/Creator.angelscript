int create(int pos, ETHEntityArray& arr)
{
	uint k=1;
	switch(k){
		case 1: return Add1(pos, arr);
	}
	return 1;
}



class Creator
{
	BlockArray[] vector;
	uint len;
	
	void create()
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


	
	int create(int pos, ETHEntityArray& arr)
	{
		int q = rand(len-1);
		return vector[q].add(pos,arr);
		
	}
}

Creator g_creator;