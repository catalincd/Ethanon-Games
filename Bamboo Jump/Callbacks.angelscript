void ETHCallback_bamboo_dynamic(ETHEntity@ thisEntity)
{
	uint f = thisEntity.GetUInt("f");
	
	if(f == 1)
	{
		thisEntity.SetPositionY(thisEntity.GetFloat("y"));
		thisEntity.SetAngle(90);
		thisEntity.AddToPositionX(UnitsPerSecond(200));
		if(thisEntity.GetPositionX() > outerScreen2.x)thisEntity.SetPositionX(thisEntity.GetPositionX() - GetScreenSize().x * 1.2f);
	}
	
	if(f == 2)
	{
		thisEntity.SetPositionY(thisEntity.GetFloat("y"));
		thisEntity.SetAngle(0);
		thisEntity.AddToPositionX(UnitsPerSecond(200));
		if(thisEntity.GetPositionX() > outerScreen2.x)thisEntity.SetPositionX(thisEntity.GetPositionX() - GetScreenSize().x * 1.5f);
	}
	
	if(f == 3)
	{
		thisEntity.SetPositionY(thisEntity.GetFloat("y"));
		thisEntity.AddToAngle(UnitsPerSecond(200) * thisEntity.GetInt("dir"));
		thisEntity.AddToPositionX(UnitsPerSecond(200) * thisEntity.GetInt("dir2"));
		if(thisEntity.GetPositionX() > outerScreen2.x)thisEntity.SetPositionX(thisEntity.GetPositionX() - GetScreenSize().x * 1.5f);
		if(thisEntity.GetPositionX() < outerScreen2_O.x)thisEntity.SetPositionX(thisEntity.GetPositionX() + GetScreenSize().x * 1.5f);
	}
	
	if(f == 4)
	{
		thisEntity.SetPositionY(thisEntity.GetFloat("y"));
		thisEntity.SetAngle(0);
		thisEntity.AddToPositionX(UnitsPerSecond(2000));
		if(thisEntity.GetPositionX() > GetScreenSize().x * 2.0f)thisEntity.SetPositionX(thisEntity.GetPositionX() - (GetScreenSize().x * 2.3f));
	}
}

void ETHPreSolveContactCallback_bamboo_dynamic(ETHEntity@ thisEntity, ETHEntity@ other, vector2 a, vector2 b, vector2 c)
{
	
}

void ETHPreSolveContactCallback_platform(ETHEntity@ thisEntity, ETHEntity@ other, vector2 a, vector2 b, vector2 c)
{
	if(other.GetUInt("char") != 1)
	{
		DisableContact();
	}
	else
	{
		execGameOver();
	}
}

void ETHPreSolveContactCallback_jumper(ETHEntity@ thisEntity, ETHEntity@ other, vector2 a, vector2 b, vector2 c)
{
	if(other.GetUInt("b") == 1)
	{
		execGameOver();
		DisableContact();
	}
}

void ETHCallback_platform(ETHEntity@ thisEntity)
{
	float targetY = GetCameraPos().y + outerScreen3.y;
	
	if(thisEntity.GetFloat("y") > targetY)
		thisEntity.SetFloat("y", targetY);
		
	thisEntity.SetPositionY(thisEntity.GetFloat("y"));
}


bool GAME_OVER = false;