void ETHCallback_enemy(ETHEntity@ thisEntity)
{

	//setEnemyAngle(thisEntity);

	if(thisEntity.GetInt("hp") <= 0)
	{
		g_bulletPoint.add(thisEntity.GetInt("bulletPoints"));
		g_gameSuccess.incEnemies();
		g_gameSuccess.incReward(thisEntity.GetUInt("reward"));
		play(10);
		AddEntity("explosion.ent", thisEntity.GetPosition(), 0);
		DeleteEntity(thisEntity);
		return;
	}

	if(thisEntity.GetUInt("stop") != 1)
	{
		drawLifeBar(thisEntity);
		shoot(thisEntity);
		
		vector2 turretPos = thisEntity.GetVector2("target");
		
		if(distance(thisEntity.GetPositionXY(), turretPos) > PX_256)
		{
			float speed = thisEntity.GetFloat("speed") * ENEMY_SPEED_RATE;
			thisEntity.AddToPositionXY(FACTOR* -UnitsPerSecond(speed) * normalize(thisEntity.GetPositionXY() - turretPos));
		}
	}
	
	uint lastHitTime = thisEntity.GetUInt("time");
	if(lastHitTime != 0)
	{
		if(getTime() - lastHitTime < STRIDE_HIT)
		{
			thisEntity.SetColor(V3_RED);
		}
		else 
			thisEntity.SetColor(thisEntity.GetVector3("color"));
	}
}

void shoot(ETHEntity@ thisEntity)
{	
	uint lastShot = thisEntity.GetUInt("lastShot");
	uint shootingRate = thisEntity.GetUInt("stride");
	if(getTime() - lastShot > shootingRate)
	{
		vector2 target = thisEntity.GetVector2("target");
		if(distance(thisEntity.GetPositionXY(), target) < PX_384)
		{
			float radius = thisEntity.GetFloat("radius");
			vector2 dir = normalize(thisEntity.GetPositionXY() - target);
			float angle = radianToDegree(getAngle(dir));
			vector2 bulletPos = thisEntity.GetPositionXY() - dir * radius * GetScale();
			ETHEntity@ bullet,muzzle;
			float scale = thisEntity.GetFloat("bulletScale");
			int damage = thisEntity.GetInt("damage") * ENEMY_DAMAGE_RATE;
			AddEntity("bulletEnemy.ent", vector3(bulletPos, 0), angle, @bullet, "enemyBullet.ent", scale);
			AddEntity("muzzle.ent", vector3(bulletPos, 0), 0, @muzzle, "muzzle.ent", scale);
			thisEntity.SetUInt("lastShot", getTime());
			bullet.SetInt("damage", damage);
			thisEntity.AddToPositionXY(dir * 10);
			play(5);
			//play(0);
		}
	}
}



