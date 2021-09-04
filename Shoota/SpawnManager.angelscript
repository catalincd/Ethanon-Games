class Enemy
{
	uint id;
	float units;
	float rarity;
	uint reward;
	Enemy(){}
	Enemy(uint i, float u, float r, uint rew = 5){id=i;units=u;rarity=r;reward=rew;}
}

Enemy enemy1 = Enemy(1, 10, 0.3f);
Enemy enemy2 = Enemy(2, 15, 0.3f);
Enemy enemy4 = Enemy(4, 50, 0.1f, 15);
Enemy enemy5 = Enemy(5, 20, 0.2f, 7);
Enemy enemy6 = Enemy(6, 25, 0.2f, 8);
Enemy enemy7 = Enemy(7, 15, 0.2f, 6);
Enemy enemy8 = Enemy(8, 20, 0.2f, 7);
Enemy enemy9 = Enemy(9, 25, 0.2f, 8);
Enemy enemy10 = Enemy(10, 50, 0.15f, 15);
Enemy enemy11 = Enemy(11, 60, 0.15f, 20);



class SpawnManager : GameObject
{

	float initSpeed;
	float targetSpeed;
	float currentUnits;
	uint timeToReach;
	uint elapsed;
	uint nextEnemyId = 0;
	float topLimit;
	Enemy@[] enemies;

	void fillEnemies()
	{
		enemies.resize(0);
		enemies.insertLast(enemy1);
		enemies.insertLast(enemy2);
		enemies.insertLast(enemy4);	
		enemies.insertLast(enemy5);	
		enemies.insertLast(enemy6);
		enemies.insertLast(enemy7);
		enemies.insertLast(enemy8);
		enemies.insertLast(enemy9);
		enemies.insertLast(enemy10);
		enemies.insertLast(enemy11);
	}

	void create()
	{
		currentUnits = 0;
		elapsed = 0;
		timeToReach = uint(float(g_gameSuccess.target) * 0.75);
		initSpeed = interpolate(INIT_ENEMY_RATE, LAST_ENEMY_RATE, getRankBias());
		targetSpeed = initSpeed*1.5;
		fillEnemies();
		fillArray();
	}

	void fillArray()
	{
		topLimit = 0;
		for(uint t=0;t<enemies.length();t++)
		{
			topLimit += enemies[t].rarity;
		}
		//print(topLimit);
	}

	uint getRandId()
	{
		float rnd = randF(0, topLimit);
		float currentLimit = topLimit;
		uint id = 0;
		while(rnd > enemies[id].rarity)
		{
			rnd -= enemies[id].rarity;
			id++;
		}
		//print(id);
		return id;
	}

	void update()
	{
		float bias = float(getTime()) / float(timeToReach);
		bias = max(0.0f, min(1.0f, bias));
		float currentSpeed = interpolate(initSpeed, targetSpeed, smoothBeginning(bias));

		if(!g_timer.gameStopped)
			currentUnits += UnitsPerSecond(currentSpeed) * SPAWN_RATE;
		//print(currentUnits);

		if(currentUnits > enemies[nextEnemyId].units)
		{
			currentUnits -= enemies[nextEnemyId].units;
			spawnNew();
		}
	}

	void spawnNew()
	{
		
		g_enemyManager.addNewEnemy(enemies[nextEnemyId].id, enemies[nextEnemyId].reward);
		//g_enemyManager.addNewEnemy(6);
		nextEnemyId = getRandId();
		//print("NEW :" + getTime() +" Units:" + currentUnits);
	}

	void resume()
	{


	}

	string getTag(){ return "Spawn";}
}

SpawnManager g_spawnManager;