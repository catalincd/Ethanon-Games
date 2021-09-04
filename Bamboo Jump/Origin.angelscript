class SpriteManager
{
	string[] names;
	vector2[] origins;
	
	void insertNormal(string sprite, vector2 origin = V2_HALF)
	{
		uint find = findName(names, sprite);
		if(find != 99999)
		{
			origins[find] = origin;
			SetSpriteOrigin(names[find], origin);
		}
		else
		{
			insert(sprite, origin);
		}
	}
	
	void insert(string sprite, vector2 origin = V2_HALF)
	{
		names.insertLast(sprite);
		origins.insertLast(origin);
		LoadSprite(sprite);
		SetSpriteOrigin(sprite, origin);
	}
	
	void set()
	{
		for(uint i=0;i<names.length();i++)
		{
			SetSpriteOrigin(names[i], origins[i]);
		}
	}
	
	void load()
	{
		for(uint i=0;i<names.length();i++)
		{
			LoadSprite(names[i]);
		}
		set();
	}
	
}

SpriteManager g_spriteManager;

void setSpriteOrigin(string spr, vector2 origin)
{
	g_spriteManager.insertNormal(spr, origin);
}

uint findName(string[] arr, string ref)
{
	for(uint i=0;i<arr.length();i++)
	{
		if(arr[i] == ref)
			return i;
	}
	
	return 99999;
}


vector2 TOP_LEFT = vector2(0.0f, 0.0f);
vector2 TOP_RIGHT = vector2(1.0f, 0.0f);

vector2 BOTTOM_LEFT = vector2(0.0f, 1.0f);
vector2 BOTTOM_RIGHT = vector2(1.0f, 1.0f);

vector2 TOP_MID = vector2(0.5f, 0.0f);
vector2 BOTTOM_MID = vector2(0.5f, 1.0f);

vector2 LEFT_MID = vector2(0.0f, 0.5f);
vector2 RIGHT_MID = vector2(1.0f, 0.5f);