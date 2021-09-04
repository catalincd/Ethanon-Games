class TurretManager : GameObject
{

	Turret@[] turrets;
	uint idCounter = 0;

	void insertNewTurret(Turret@ turret)
	{
		turrets.insertLast(turret);
		turret.setId(idCounter++);
	}
	
	uint getArrayIdx(uint idC)
	{
		for(uint i=0;i<turrets.length();i++)
		{
			if(turrets[i].getId() == idC)
				return i;
		}
		
		return 999;
	}
		
	
	void remove(uint id)
	{
		uint normalId = getArrayIdx(id);
		removeNormal(normalId);
	}
	
	
	void removeNormal(uint id)
	{
		if(id < turrets.length())
		{
			g_mapManager.remove(turrets[id].getPosition());
			turrets.removeAt(id);
		}
	}
	
	vector2 getClosestTurret(vector2 startingPoint)
	{
		uint len = turrets.length();
		float closest = HIGH_VALUE;
		vector2 closestTurret = vector2(0,0);
		for(uint t=0;t<len;t++)
		{
			float newDist = distance(turrets[t].getPosition(), startingPoint);
			if(newDist < closest)
			{
				closest = newDist;
				closestTurret = turrets[t].getPosition();
			}
		}
		
		return closestTurret;
	}

	void updateBodyColor(uint id)
	{
		uint normalId = getArrayIdx(id);
		if(normalId != 999)
			turrets[normalId].updateBodyColor();
	}

	void create()
	{
		//float yPos = GetScreenSize().y * 0.75;
		//float xPos = GetScreenSize().x * 0.25;
		//float xOffset = 284 * GetScale();
		//insertNewTurret(addTurret1_Tier1(vector2(xPos*2,yPos)));
		//insertNewTurret(addAutoTurret1_Tier1(vector2(xOffset,yPos/2)));
		//insertNewTurret(addAutoTurret1_Tier1(vector2(GetScreenSize().x-xOffset,yPos/2)));
		turrets.resize(0);
	}
	
	void update()
	{
		uint len = turrets.length();
		for(uint t=0;t<len;t++)
		{
			if(!turrets[t].isDead())
				turrets[t].update();
		}
		
	}
	
	void shoot(vector2 pos)
	{
		uint len = turrets.length();
		for(uint t=0;t<len;t++)
		{
			turrets[t].shoot(pos);
		}
	}
	
	void resume()
	{
		
	}
	
	
	
	string getTag(){ return "TurretManager"; }
}


TurretManager g_turret;


