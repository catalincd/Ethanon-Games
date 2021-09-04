class SetOrigin
{
	uint index = 0;
	string[] names;
	vector2[] origins;
	
	


	void setSpriteOrigin(string name, vector2 origin)
	{
		SetSpriteOrigin(name, origin);
		bool notFound = true;
		for(uint t=0;t<index;t++)
		{
			if(name==names[t])
			{
				notFound = false;
				break;
			}
		}
		if(notFound)
		{
			index++;
			names.insertLast(name);
			origins.insertLast(origin);
		}
	}
	
	void resetAllOrigins()
	{
		for(uint t=0;t<index;t++)
		{
			SetSpriteOrigin(names[t], origins[t]);
		}
	}

}

SetOrigin g_setOrigin;

void setSpriteOrigin(string name, vector2 origin)
{
	g_setOrigin.setSpriteOrigin(name, origin);
}