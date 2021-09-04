void initAnimation1(ETHEntity@ thisEntity)
{
	
}

void Animation1(ETHEntity@ thisEntity)
{
	thisEntity.AddToAngle(unitsPerSecond(200));
}


void initAnimation7(ETHEntity@ thisEntity)
{
	
}

void Animation7(ETHEntity@ thisEntity)
{
	thisEntity.AddToAngle(unitsPerSecond(-200));
}

void initAnimation2(ETHEntity@ thisEntity)
{
	thisEntity.SetVector2("center", thisEntity.GetPositionXY());
}

void Animation2(ETHEntity@ thisEntity)
{
	thisEntity.AddToAngle(unitsPerSecond(200));
	thisEntity.SetPositionXY(thisEntity.GetVector2("center")+rotateAround(degreeToRadian(thisEntity.GetAngle()), g_scale.ENT_RADIUS));
}

void initAnimation3(ETHEntity@ thisEntity)
{
	thisEntity.SetFloat("angle", 0);
	thisEntity.SetVector2("center", thisEntity.GetPositionXY());
}

void Animation3(ETHEntity@ thisEntity)
{
	thisEntity.AddToFloat("angle",unitsPerSecond(200));
	thisEntity.SetPositionXY(thisEntity.GetVector2("center")+rotateAround(degreeToRadian(thisEntity.GetFloat("angle")), g_scale.ENT_RADIUS));
}

void initAnimation4(ETHEntity@ thisEntity)
{
	thisEntity.SetVector2("center", thisEntity.GetPositionXY());
}

void Animation4(ETHEntity@ thisEntity)
{
	thisEntity.AddToAngle(unitsPerSecond(200));
	thisEntity.SetPositionXY(thisEntity.GetVector2("center")+rotateAround(degreeToRadian(360-thisEntity.GetAngle()), g_scale.ENT_RADIUS));
}


void initAnimation5(ETHEntity@ thisEntity)
{
	thisEntity.SetFloat("centerX", thisEntity.GetPositionX());
	thisEntity.SetFloat("dir", 1);
}

void Animation5(ETHEntity@ thisEntity)
{
	float center = thisEntity.GetFloat("centerX");
	thisEntity.AddToPositionX(thisEntity.GetFloat("dir")*unitsPerSecond(200));
	if(thisEntity.GetPositionX()>center+g_scale.ENT_JITTER) 
	{
		thisEntity.SetPositionX(center+g_scale.ENT_JITTER);
		thisEntity.SetFloat("dir", -1);
	}
	if(thisEntity.GetPositionX()<center-g_scale.ENT_JITTER)
	{
		thisEntity.SetPositionX(center-g_scale.ENT_JITTER);
		thisEntity.SetFloat("dir", 1);
	}
}

void initAnimation6(ETHEntity@ thisEntity)
{
	thisEntity.SetFloat("centerY", thisEntity.GetPositionY());
	thisEntity.SetFloat("dir", 1);
}

void Animation6(ETHEntity@ thisEntity)
{
	float center = thisEntity.GetFloat("centerY");
	thisEntity.AddToPositionY(thisEntity.GetFloat("dir")*unitsPerSecond(200));
	if(thisEntity.GetPositionY()>center+g_scale.ENT_JITTER) 
	{
		thisEntity.SetPositionY(center+g_scale.ENT_JITTER);
		thisEntity.SetFloat("dir", -1);
	}
	if(thisEntity.GetPositionY()<center-g_scale.ENT_JITTER)
	{
		thisEntity.SetPositionY(center-g_scale.ENT_JITTER);
		thisEntity.SetFloat("dir", 1);
	}
}






