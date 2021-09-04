class EnemyManager : GameObject
{

	uint stride = STRIDE_ENEMY;
	uint lastAdd = 0;
	ETHEntityArray allEnt;
	float topLen;
	float bottomLen;
	float verticalLen;
	spawn[] spawns;
	uint lastSpawned = 0;
	
	void create()
	{
		lastAdd = 0;
		lastSpawned = 0;
		allEnt.Clear();
		initPositions();
	}
	
	void initPositions()
	{
		verticalLen = LIMIT_SCREEN_SIZE_DOWN.y / 3;
		topLen = LIMIT_SCREEN_SIZE_DOWN.x / 2;
		bottomLen = LIMIT_SCREEN_SIZE_DOWN.x;
		
		
		spawns.resize(0);
		//top
		spawns.insertLast(spawn(vector2(0.5f * topLen,LIMIT_SCREEN_SIZE_TOP.y), false));
		spawns.insertLast(spawn(vector2(1.5f * topLen,LIMIT_SCREEN_SIZE_TOP.y), false));
		
		//left
		spawns.insertLast(spawn(vector2(LIMIT_SCREEN_SIZE_TOP.x, SS_50.y - verticalLen)));
		spawns.insertLast(spawn(vector2(LIMIT_SCREEN_SIZE_TOP.x, SS_50.y)));
		spawns.insertLast(spawn(vector2(LIMIT_SCREEN_SIZE_TOP.x, SS_50.y + verticalLen)));
			
		//right
		spawns.insertLast(spawn(vector2(LIMIT_SCREEN_SIZE_DOWN.x, SS_50.y - verticalLen)));
		spawns.insertLast(spawn(vector2(LIMIT_SCREEN_SIZE_DOWN.x, SS_50.y)));
		spawns.insertLast(spawn(vector2(LIMIT_SCREEN_SIZE_DOWN.x, SS_50.y + verticalLen)));
		
		//bottom
		spawns.insertLast(spawn(vector2(SS_50.x, LIMIT_SCREEN_SIZE_DOWN.y), false));
		
		randomize(spawns);
		randomize(spawns);
		randomize(spawns);
	}
	
	
	vector2 GetNextPosition()
	{
		
		vector2 pos = spawns[lastSpawned].pos;
		if(spawns[lastSpawned].vertical)
			pos.y+= randF(-1.0f, 1.0f) * verticalLen;
		else
			pos.x+= randF(-1.0f, 1.0f) * topLen;
		lastSpawned++;
		if(lastSpawned == spawns.length())
			lastSpawned = 0;
		return pos;
	}
	
	void update()
	{
		//uint strideOffset = min(1.0f, float(getTime()) / 60000.0f) * 100.0f;
		//uint currentStride = stride - strideOffset;
		
		allEnt.removeDeadEntities();
	}
	
	void resetTargets()
	{
		for(uint i=0;i<allEnt.size();i++)
		{
			setTarget(allEnt[i]);
		}
	}
	
	void explodeEnemies(vector2 pos)
	{
		for(uint i=0;i<allEnt.size();i++)
		{
			if(distance(allEnt[i].GetPositionXY(), pos) < PX_128)
				allEnt[i].SetInt("hp", -1);
		}
	}
	
	void explodeAll()
	{
		for(uint i=0;i<allEnt.size();i++)
		{
			allEnt[i].SetInt("hp", -1);
		}
	}
	
	void addNewEnemy(uint id, uint reward = 5)
	{
		
		vector2 pos = GetNextPosition();
	
		ETHEntity@ oute;
		AddEntity("enemy"+id+".ent", vector3(pos, 0), 0, @oute, "enemy", 1.0f);
		vector3 newColor = COL(randOf(enemyColors));
		newColor = V3_ONE;
		oute.SetColor(newColor);
		oute.SetVector3("color", newColor);
		oute.SetUInt("reward", reward);
		setTarget(oute);
		allEnt.Insert(oute);
		setEnemyAngle(oute);
	}
	
	void resume(){}
	string getTag()
	{
		return "Enemies";
	}
}

EnemyManager g_enemyManager;


class spawn
{
	vector2 pos;
	bool vertical;
	
	spawn(vector2 p, bool v = true)
	{
		pos = p;
		vertical = v;
	}
	
	spawn(){}
}

void setTarget(ETHEntity@ thisEntity)
{
	vector2 newTarget = g_turret.getClosestTurret(thisEntity.GetPositionXY());
	if(newTarget != V2_ZERO)
	{
		thisEntity.SetVector2("target", newTarget);
		setEnemyAngle(thisEntity);
	}
	else
	{
		thisEntity.SetUInt("stop", 1);
	}
}