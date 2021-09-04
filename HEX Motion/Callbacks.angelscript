void ETHConstructorCallback_blockNormal(ETHEntity@ thisEntity)
{
	switch(thisEntity.GetUInt("data"))
	{
		case 1: {initAnimation1(thisEntity);return;}//angle
		case 2: {initAnimation2(thisEntity);return;}//omnidir 
		case 3: {initAnimation3(thisEntity);return;}//omnidir fixed
		case 4: {initAnimation4(thisEntity);return;}//omnidir reverse
		case 5: {initAnimation5(thisEntity);return;}//jitter horizontal
		case 6: {initAnimation6(thisEntity);return;}//jitter vertical
		case 7: {initAnimation7(thisEntity);return;}//angle reverse
	}
}

void ETHCallback_blockNormal(ETHEntity@ thisEntity)
{
	//thisEntity.SetColor(vector3(1,0,1));

	//AddLight(thisEntity.GetPosition(), GetColorV3(thisEntity.GetUInt("color")), g_scale.light,false);
	if(!GAME_OVER)
	{
		thisEntity.SetColor(GetColorV3(thisEntity.GetUInt("color")));
		thisEntity.SetScale(1.0f);
	}
	else 
	{
		thisEntity.SetColor(interpolate(GetColorV3(thisEntity.GetUInt("color")),greyV3,g_block.colorBias));
		thisEntity.SetScale(interpolate(1, 0.75, g_block.colorBias));
	}
	switch(thisEntity.GetUInt("data"))
	{
		case 1: {Animation1(thisEntity);return;}
		case 2: {Animation2(thisEntity);return;}
		case 3: {Animation3(thisEntity);return;}
		case 4: {Animation4(thisEntity);return;}
		case 5: {Animation5(thisEntity);return;}
		case 6: {Animation6(thisEntity);return;}
		case 7: {Animation7(thisEntity);return;}
	}
}