class AutoTurret : Turret
{
	
	vector2 turretPos;
	ETHEntity@ turret;
	ETHEntity@ body;
	ETHEntity@ currentTarget = null;
	uint lastShotTime = 0;
	float bulletScale = 0.4f;
	float radius = 100;
	float bulletRadius = 100;
	uint fireRate = 500;
	uint HP = 100;
	uint DAMAGE = 100;
	uint id = 0;
	bool dead = false;
	uint bulletSoundId = 2;
	
	bool isDead()
	{
		return dead;
	}
	
	void spawn(vector2 pos, string turretName, string bodyName, vector3 color){}
	
	void spawn(vector2 pos, uint hp, uint damage, string turretName, string bodyName, float rd, vector3 color = V3_ONE, float blScale = 0.4f, uint soundId = 2, uint fRate = 500)
	{
		turretPos = pos;
		AddEntity(bodyName, vector3(turretPos,0), 0, @body, "body", 0.375f);
		AddEntity(turretName, vector3(turretPos,0), 0, @turret, "turret", 0.75f);
		bulletRadius = turret.GetFloat("radius") * GetScale() * 0.75;
		body.SetUInt("body", 1);
		lastShotTime = 0;
		body.SetColor(color);
		bulletScale = blScale;
		fireRate = fRate;
		HP = hp;
		DAMAGE = damage;
		radius = rd;
		body.SetInt("hp", HP);
		body.SetInt("hpMax", HP);
		body.SetFloat("hpScale", 1.0f);
		@currentTarget = null;
		updateBodyColor();
		bulletSoundId = soundId;
		//turret.SetColor(vector3(0.9, 0.9, 0.9));
	}
	
	void decId()
	{
		id--;
	}
	
	uint getId()
	{
		return id;
	}
	
	void setId(uint q)
	{
		id = q;
		body.SetUInt("id", q);
	}
	
	void destroy()
	{
		dead = true;
		AddEntity("explosion.ent", body.GetPosition(), 0);
		g_enemyManager.explodeEnemies(body.GetPositionXY());
		DeleteEntity(turret);
		DeleteEntity(body);
		g_turret.remove(id);
		g_enemyManager.resetTargets();
	}
	
	void updateBodyColor()
	{
		float bias = float(body.GetInt("hp")) / float(body.GetInt("hpMax"));
		body.SetColor(interpolate(V3_RED, V3_GREEN, bias));
	}
	
	
	void update()
	{	
		drawBlueLifeBar(body);
		restorePosition();
		setTarget();
		updateTargetShooting();
		if(body.GetInt("hp") <= 0 && !dead)
			destroy();
	}
	
	void setTarget()
	{
		if(currentTarget is null || !currentTarget.IsAlive())
		{
	
			uint len = g_enemyManager.allEnt.Size();
			if(len != 0)
			{
				float minDist = HIGH_VALUE;
				uint minDistId = 0;
				for(uint i=0;i<len;i++)
				{
					if(g_enemyManager.allEnt[i].GetUInt("enemy") == 1)
					{
						float newDist = distance(body, g_enemyManager.allEnt[i]);
						if(newDist < minDist)
						{
							minDist = newDist;
							minDistId = i;
						}
					}
				}
				if(minDist < radius)
					@currentTarget = g_enemyManager.allEnt[minDistId];
			}
		}
	}
	
	void shoot(vector2 target){}
	
	void autoShoot(vector2 target)
	{
		vector2 offset = normalize(turretPos -  target);
		float angle = radianToDegree(getAngle(offset));
		turret.SetAngle(angle);
		turret.SetPositionXY(turretPos + offset * PX_15);
		vector2 bulletPos = turretPos - offset * bulletRadius;
		//vector2 muzzlePos = turretPos - offset * PX_100;
		ETHEntity@ bullet,muzzle;
		AddEntity("bullet.ent", vector3(bulletPos, 0), angle, @bullet, "bullet.ent", bulletScale);
		AddEntity("muzzle.ent", vector3(bulletPos, 0), 0, @muzzle, "muzzle.ent", 0.75f);
		lastShotTime = getTime();
		bullet.SetInt("damage", DAMAGE);
		play(bulletSoundId);
	}
	
	void updateTargetShooting()
	{
		if(currentTarget !is null && currentTarget.IsAlive())
		{
			setTurretAngle(turret, currentTarget);
			if(getTime() - lastShotTime > fireRate)
			{
				lastShotTime = getTime();
				autoShoot(currentTarget.GetPositionXY());
			}
		}
	}
	
	void restorePosition()
	{
		if(distance(turret.GetPositionXY(), turretPos) > 1.0f)
		{
			vector2 dir = normalize(turret.GetPositionXY() - turretPos);
			turret.AddToPositionXY(-UnitsPerSecond(100) * dir);
		}
	}
	
	vector2 getPosition()
	{
		return turretPos;
	}
}


void getSurroundingBucket(ETHEntity@ thisEntity, ETHEntityArray@ outAr)
{
	GetEntitiesAroundBucket(thisEntity.GetCurrentBucket(), outAr);
}