class BlockArray
{
	uint idx;
	uint difficultyLevel;
	uint len;
	uint point;
	uint colorIdx;
	int height;
	BlockEntity[] entities;
	vector2[] points;
	string blockName = "blockGlow.ent";
		
	BlockArray(){}
	
	BlockArray(string fileName)
	{
		const string str = GetStringFromFileInPackage(GetResourceDirectory() +"arrays/" +fileName);
		enmlFile f;
		f.parseString(str);
		idx = parseUInt(f.get("data", "idx"));
		difficultyLevel = parseUInt(f.get("data", "diff"));
		height = parseInt(f.get("data", "height"));
		len = parseUInt(f.get("data", "len"));
		point = parseUInt(f.get("data", "point"));
		colorIdx = parseUInt(f.get("data", "color"));
		//print(colorIdx);
		for(uint i=0;i<len;i++)
		{
			entities.insertLast(stringToEntity(f.get("entities", "entity"+i)));
		}
		for(uint i=0;i<point;i++)
		{
			points.insertLast(stringToVector2(f.get("points", "point"+i)));
		}
		
	}
	
	int add(int pos, ETHEntityArray& arr)
	{
		
		for(uint i=0;i<point;i++)
		{
			g_waypoint.insert((points[i]+vector2(0, pos*70))*GetScale());
		}
	
		for(uint i=0;i<len;i++)
		{
			ETHEntity@ ent;
			AddEntity(blockName, vector3(entities[i].x,entities[i].y+pos*70,0)*GetScale(), 0, @ent, "blockNormal.ent", 1);
			ent.SetAngle(entities[i].angle);
			ent.SetUInt("data", entities[i].data);
			ent.SetUInt("color", colorIdx);
			arr.Insert(ent);
		}
		return height;
	}
	
	
}