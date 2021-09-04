class SimpleTurret : Turret
{
	
	vector2 turretPos;
	ETHEntity@ turret;
	ETHEntity@ body;
	float heat = 0;
	uint lastShotTime = 0;
	uint HP;
	uint HP_MAX;
	uint DAMAGE;
	bool dead = false;
	uint id = 0;
	uint shootingSoundId = 6;
	
	
	void spawn(vector2 pos, uint hp, uint damage, string turretName, string bodyName, vector3 color, uint shootin = 6)
	{
		turretPos = pos;
		AddEntity(bodyName, vector3(turretPos,0), 0, @body, "body", 0.375f);
		AddEntity(turretName, vector3(turretPos,0), 0, @turret, "turret", 0.75f);
		body.SetUInt("body", 1);
		heat = 0.0f;
		lastShotTime = 0;
		body.SetColor(color);
		HP = hp;
		HP_MAX = hp;
		g_hp.set(hp);
		body.SetInt("hp", HP);
		body.SetInt("hpMax", HP);
		body.SetFloat("hpScale", 1.0f);
		DAMAGE = damage;
		updateBodyColor();
		shootingSoundId = shootin;
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
	
	bool isDead()
	{
		return dead;
	}
	
	void setId(uint q)
	{
		id = q;
		body.SetUInt("id", q);
	}
	
	void update()
	{
		if(body !is null)
		{
			//drawBlueLifeBar(body);
			restorePosition();
			updateHeat();
			//updateBodyColor();
		}
		if(body.GetInt("hp") <= 0 && !dead)
				destroy();
	}
	
	void updateBodyColor()
	{
		float bias = float(body.GetInt("hp")) / float(body.GetInt("hpMax"));
		body.SetColor(interpolate(V3_RED, V3_GREEN, bias));
		g_hp.setCurrentHp(max(0, (body.GetInt("hp"))));
	}
	
	void destroy()
	{
		dead = true;
		GAME_OVER = true;
		AddEntity("explosion.ent", body.GetPosition(), 0);
		g_enemyManager.explodeEnemies(body.GetPositionXY());
		DeleteEntity(turret);
		DeleteEntity(body);
		@turret = null;
		@body = null;
		g_turret.remove(id);
		g_enemyManager.resetTargets();
	}
	
	void shoot(vector2 target)
	{
		vector2 offset = normalize(turretPos -  target);
		float angle = radianToDegree(getAngle(offset));
		turret.SetAngle(angle);
		turret.SetPositionXY(turretPos + offset * PX_15);
		vector2 bulletPos = turretPos - offset * PX_128;
		vector2 muzzlePos = turretPos - offset * PX_128;
		ETHEntity@ bullet,muzzle;
		AddEntity("bullet.ent", vector3(bulletPos, 0), angle, @bullet, "bullet.ent", 0.6f);
		AddEntity("muzzle.ent", vector3(muzzlePos, 0), 0, @muzzle, "muzzle.ent", 1.0f);
		bullet.SetInt("damage", DAMAGE);
		play(shootingSoundId);
		heat += TURRET_HEAT;
		lastShotTime = getTime();
		g_backgroundManager.shoot();
		g_bps.insertBullet();
	}
	
	void updateHeat()
	{
		heat = min(heat, 0.6f);
		heat = max(heat, 0.0f);
		
		if(getTime() - lastShotTime > TURRET_COOLING)
		{
			heat -= UnitsPerSecond(TURRET_COOLING_RATIO);
		}
		
		float curretHeat = max(0, heat - 0.15f) * 5.0f;
		
		turret.SetColor(interpolate(V3_ONE, V3_RED, curretHeat));
	}
	
	void restorePosition()
	{
		if(distance(turret.GetPositionXY(), turretPos) > PX_2)
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