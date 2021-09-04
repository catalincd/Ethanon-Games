void ETHCallback_blockNormal(ETHEntity@ thisEntity)
{
	g_effector.updateEntity(thisEntity);
	
	if(thisEntity.GetUInt("delete") == 1)
	{
		if(TUTORIAL)
			AddEntity("explosion_WHITE.ent", thisEntity.GetPosition(), 0);
		else
			AddEntity("explosion.ent", thisEntity.GetPosition(), 0);
		DeleteEntity(thisEntity);
	}
	if(isEnergyOn())
	{
		thisEntity.SetColor(interpolate(thisEntity.GetVector3("color"), vector3(1,1,1), g_energyManager.getFactor()));
	}
	else
	if(thisEntity.GetUInt("hex")==1)
	g_effector.updateRainbow(thisEntity);
	else
	thisEntity.SetColor(thisEntity.GetVector3("color"));
}


void ETHCallback_coin(ETHEntity@ thisEntity)
{
	if(thisEntity.GetUInt("add") == 1)
	{
		//COINS++;
		
		g_energyManager.startBoost();
		
		AddEntity("explosion_coin.ent", thisEntity.GetPosition(), 0);
		@thisEntity = DeleteEntity(thisEntity);
	}
}

void ETHCallback_coin_color(ETHEntity@ thisEntity)
{
	if(thisEntity.GetUInt("add") == 1)
	{
		BOOST_COINS++;
		ETHEntity@ explo;
		AddEntity("explosion_"+GetColorNameFromIdx(CURRENT_COLOR)+".ent", thisEntity.GetPosition(), @explo);
		explo.SetScale(0.25);
		@thisEntity = DeleteEntity(thisEntity);
	}
}