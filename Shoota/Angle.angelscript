void setEnemyAngle(ETHEntity@ thisEntity)
{
	float angle = radianToDegree(getAngle(normalize(thisEntity.GetVector2("target")-thisEntity.GetPositionXY())));
	thisEntity.SetAngle(angle);
}

void setEnemyAngle(ETHEntity@ thisEntity, vector2 Pos)
{
	float angle = radianToDegree(getAngle(normalize(Pos-thisEntity.GetPositionXY())));
	thisEntity.SetAngle(angle);
}


void setTurretAngle(ETHEntity@ thisEntity, ETHEntity@ target)
{
	float angle = radianToDegree(getAngle(normalize(thisEntity.GetPositionXY()-target.GetPositionXY())));
	thisEntity.SetAngle(angle);
}

