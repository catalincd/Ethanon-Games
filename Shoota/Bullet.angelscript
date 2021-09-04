void ETHCallback_bullet(ETHEntity@ thisEntity)
{
	thisEntity.AddToPositionXY(-UnitsPerSecond(1500)*getVector2Deg(thisEntity.GetAngle()));
	if(SF.outOfScreenLimit(thisEntity.GetPositionXY()) || thisEntity.GetUInt("delete") == 1)
	{
		AddEntity("explosion_bullet.ent", thisEntity.GetPosition(), 0);
		DeleteEntity(thisEntity);
	}
}


void ETHBeginContactCallback_bullet(ETHEntity@ thisEntity, ETHEntity@ other, vector2 a, vector2 b, vector2 n)
{
	if(other.GetUInt("body") != 1 && other.GetUInt("bullet") != 1 && other.GetUInt("enemy")==1)
	{
		thisEntity.SetUInt("delete", 1);
		uint damage = thisEntity.GetInt("damage") * DAMAGE_RATE;
		g_gameSuccess.incDamage(damage);
		other.SetInt("hp", other.GetInt("hp") - damage);
		other.SetUInt("time", getTime());
	}
}

void ETHPreSolveContactCallback_bullet(ETHEntity@ thisEntity, ETHEntity@ other, vector2 a, vector2 b, vector2 n)
{
	if(other.GetUInt("body") == 1 || other.GetUInt("bullet") == 1)
		DisableContact();
}


void ETHCallback_enemyBullet(ETHEntity@ thisEntity)
{
	thisEntity.AddToPositionXY(-UnitsPerSecond(1500)*getVector2Deg(thisEntity.GetAngle()));
	if(SF.outOfScreenLimit(thisEntity.GetPositionXY()) || thisEntity.GetUInt("delete") == 1)
	{
		AddEntity("explosion_bullet.ent", thisEntity.GetPosition(), 0);
		DeleteEntity(thisEntity);
	}
}

void ETHBeginContactCallback_enemyBullet(ETHEntity@ thisEntity, ETHEntity@ other, vector2 a, vector2 b, vector2 n)
{
	if(other.GetUInt("enemy") != 1 && other.GetUInt("enemyBullet") != 1)
	{
		thisEntity.SetUInt("delete", 1);
		other.SetInt("hp", other.GetInt("hp") - thisEntity.GetInt("damage"));
		other.SetUInt("time", getTime());
		uint id = other.GetUInt("id");
		g_turret.updateBodyColor(id);
	}
}


void ETHPreSolveContactCallback_enemyBullet(ETHEntity@ thisEntity, ETHEntity@ other, vector2 a, vector2 b, vector2 n)
{
	if(other.GetUInt("enemy") == 1 || other.GetUInt("enemyBullet") == 1)
		DisableContact();
}