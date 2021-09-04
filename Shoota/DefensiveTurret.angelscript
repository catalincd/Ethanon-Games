class DefensiveTurret : Turret
{
	
	vector2 turretPos;
	ETHEntity@ turret;
	ETHEntity@ body;
	bool dead = false;
	uint id = 0;
	uint HP;
	
	bool isDead()
	{
		return dead;
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
	
	void spawn(vector2 pos, string turretName, string bodyName, vector3 color){}
	
	
	void spawn(vector2 pos, uint hp, string bodyName)
	{
		AddEntity(bodyName, vector3(pos,0), 0, @body, "body", 0.75f);
		body.SetUInt("body", 1);
		HP = hp;
		body.SetInt("hp", HP);
		body.SetInt("hpMax", HP);
		body.SetFloat("hpScale", 1.0f);
		updateBodyColor();
	}
	
	void destroy()
	{
		dead = true;
		AddEntity("explosion.ent", body.GetPosition(), 0);
		g_enemyManager.explodeEnemies(body.GetPositionXY());
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
		if(body.GetInt("hp") <= 0 && !dead)
			destroy();
	}
	
	void shoot(vector2 target){}

	void restorePosition(){}
	
	vector2 getPosition()
	{
		return body.GetPositionXY();
	}
}