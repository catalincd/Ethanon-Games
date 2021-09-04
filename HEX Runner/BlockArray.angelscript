string blockName = "block.ent";

class BlockArray
{
	uint idx;
	uint difficultyLevel;
	uint len;
	uint colorIdx;
	int height;
	uint coins;
	float unitHeight = 64;
	BlockEntity[] entities;
	vector2[] coinPositions;
		
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
		colorIdx = parseUInt(f.get("data", "color"));
		coins = parseUInt(f.get("data", "coins"));
		unitHeight = 64 * GetScale();
		//print(colorIdx);
		for(uint i=0;i<len;i++)
		{
			entities.insertLast(stringToEntity(f.get("entities", "entity"+i)));
		}
		
		for(uint i=0;i<coins;i++)
		{
			coinPositions.insertLast(stringToVector2(f.get("coins", "coin"+i)));
		}

		
	}
	
	int add(int pos, ETHEntityArray& arr)
	{
		
		//for(uint i=0;i<point;i++)
		//{
		//	g_waypoint.insert((points[i]+vector2(0, pos*70))*GetScale());
		//}
		if(coins > 0)
		{
			
			if(rand(0, COIN_RATIO) == 0)
			{
				for(uint i=0;i<coins;i++)
				{
					vector2 posi = coinPositions[i];
					vector3 newPos = vector3(posi.x,posi.y+pos*BLOCK_HEIGHT,0)*GetScale();
					ETHEntity@ coin = null;
					AddEntity("coin_"+GetColorNameFromIdx(CURRENT_COLOR)+".ent", newPos, 0, @coin, "coin_color.ent",0.75);
					arr.Insert(coin);
				}
			}
			else
			if(!isEnergyOn() && rand(0, BOOST_RATIO) == 0)
			{
				vector2 posi = coinPositions[rand(0, coins-1)];
				vector3 newPos = vector3(posi.x,posi.y+pos*BLOCK_HEIGHT,0)*GetScale();
				ETHEntity@ coin = null;
				AddEntity("coin.ent", newPos, @coin);
				arr.Insert(coin);
				//print(vector2ToString(pos));
			}
		}
	
		for(uint i=0;i<len;i++)
		{
			ETHEntity@ ent;
			AddEntity(blockName, vector3(entities[i].x,entities[i].y+pos*BLOCK_HEIGHT,0)*GetScale(), 0, @ent, "blockNormal.ent", 1);
			ent.SetAngle(entities[i].angle);
			float yPos = (abs(pos))*BLOCK_HEIGHT*GetScale();
			vector3 colorNow = g_colorManager.getCurrentColor(yPos);
			if(GetScore(yPos) > SCORE_TO_RAINBOW)
			{
				ent.SetUInt("hex", 1);
				ent.SetUInt("cId", rand(0,7));
			}
			if(ENABLE_EFFECTS)
			{
				g_gameEffector.add(ent);
			}
			ent.SetColor(colorNow);
			ent.SetVector3("color",colorNow);
			ent.SetVector2("pos", ent.GetPositionXY());
			ent.SetUInt("data", entities[i].data);
			//ent.SetUInt("color", colorIdx);
			arr.Insert(ent);
		}
		return height;
	}
	
	
}