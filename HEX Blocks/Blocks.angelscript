/* void ETHConstructorCallback_block3(ETHEntity@ thisEntity)
{
	thisEntity.KillParticleSystem(0);
}

void ETHConstructorCallback_block2(ETHEntity@ thisEntity)
{
	thisEntity.KillParticleSystem(0);
}

void ETHConstructorCallback_block1(ETHEntity@ thisEntity)
{
	thisEntity.KillParticleSystem(0);
}
*/



void ETHCallback_block3(ETHEntity@ thisEntity)
{
	ETHPhysicsController@ controller = thisEntity.GetPhysicsController();
	float linearY = controller.GetLinearVelocity().y;
	float linearX = controller.GetLinearVelocity().x;
	//if(thisEntity.GetFloat("y")!=0)
	thisEntity.SetPositionY(thisEntity.GetFloat("y"));
	if(thisEntity.GetUInt("f")==1)
	{
		if((GetTime()/1000)%2==0)
			controller.SetLinearVelocity(vector2(3,linearY));
			else
			controller.SetLinearVelocity(vector2(-3,linearY));
			
	}
	if(thisEntity.GetUInt("f")==2)
	{
		
		if((GetTime()/1000)%2==1)
			controller.SetLinearVelocity(vector2(3,linearY));
			else
			controller.SetLinearVelocity(vector2(-3,linearY));
			
	}
	if(thisEntity.GetUInt("f")==3)
	{
		
		thisEntity.AddToAngle(UnitsPerSecond(200));
		thisEntity.SetPositionXY(getCirclePosition(thisEntity.GetVector2("center"),degreeToRadian(thisEntity.GetAngle()),thisEntity.GetFloat("radius")));
			
	}
	
	if(thisEntity.GetUInt("f")==4)
	{
		if(thisEntity.GetPositionX()<-35*GetScale()) thisEntity.SetPositionX(SCREEN_SIZE_X+85*GetScale());
		thisEntity.AddToPositionX(UnitsPerSecond(-200));
		
	}
	if(thisEntity.GetUInt("f")==5)
	{
		if(thisEntity.GetPositionX()>SCREEN_SIZE_X+85*GetScale()) thisEntity.SetPositionX(-35*GetScale());
		thisEntity.AddToPositionX(UnitsPerSecond(200));
		
	}
	if(thisEntity.GetUInt("f")==8)
	{
		if(thisEntity.GetPositionX()<=thisEntity.GetFloat("limitL"))thisEntity.SetInt("up", -1);
		if(thisEntity.GetPositionX()>=thisEntity.GetFloat("limitR"))thisEntity.SetInt("up", 1);
		thisEntity.AddToPositionXY(UnitsPerSecond(-300)*V2_ONE*thisEntity.GetInt("up"));
		
	}
	
	if(thisEntity.GetUInt("f")==9)
	{
		if(thisEntity.GetPositionX()<=thisEntity.GetFloat("limitL"))thisEntity.SetInt("up", -1);
		if(thisEntity.GetPositionX()>=thisEntity.GetFloat("limitR"))thisEntity.SetInt("up", 1);
		thisEntity.AddToPositionXY(UnitsPerSecond(-300)*vector2(1, -1)*thisEntity.GetInt("up"));
		
	}
	
	if(thisEntity.GetUInt("f")==10)
	{
		thisEntity.AddToFloat("angle", UnitsPerSecond(120)*thisEntity.GetFloat("factor"));
		if(thisEntity.GetFloat("angle")>360)
			thisEntity.SetFloat("angle",0);
		thisEntity.SetPositionXY(getSquarePosition(thisEntity.GetVector2("center"), thisEntity.GetFloat("angle"), thisEntity.GetFloat("radius")));
	}
}


void ETHCallback_block2(ETHEntity@ thisEntity)
{
	if(thisEntity.GetUInt("a")==1)
	{
		thisEntity.SetAngle(0);
	}

	if(thisEntity.GetUInt("f")==1)
	{
		
		thisEntity.AddToFloat("angle", UnitsPerSecond(100));
		thisEntity.SetAngle(360-thisEntity.GetFloat("angle"));
		thisEntity.SetPositionXY(getCirclePosition(thisEntity.GetVector2("center"),degreeToRadian(thisEntity.GetFloat("angle")),thisEntity.GetFloat("radius")));
	}
	
	if(thisEntity.GetUInt("f")==2)
	{
		if(thisEntity.GetUInt("a2")==0)
		thisEntity.AddToAngle(UnitsPerSecond(100));
		else
		thisEntity.AddToAngle(UnitsPerSecond(-100));
		ETHEntity@ target;
		thisEntity.GetObject("target", @target);
		thisEntity.SetPositionXY(getCirclePosition(target.GetPositionXY(),degreeToRadian(thisEntity.GetAngle()),thisEntity.GetFloat("radius")));
	}
	if(thisEntity.GetUInt("f")==3)
	{
		
		thisEntity.AddToAngle(UnitsPerSecond(100));
		thisEntity.SetPositionXY(getCirclePosition(thisEntity.GetVector2("center"),degreeToRadian(thisEntity.GetAngle()),thisEntity.GetFloat("radius")));
	}
	
	if(thisEntity.GetUInt("f")==4)
	{
		
		thisEntity.AddToAngle(UnitsPerSecond(100));
	}
	
	if(thisEntity.GetUInt("f")==5)
	{
		
		thisEntity.AddToAngle(UnitsPerSecond(-100));
	}
	if(thisEntity.GetUInt("f")==6)
	{
		if(thisEntity.GetPositionX()>SCREEN_SIZE_X+85*GetScale()) thisEntity.SetPositionX(-35*GetScale());
		thisEntity.AddToPositionX(UnitsPerSecond(200));
		thisEntity.AddToAngle(UnitsPerSecond(-100));
	}
	
	if(thisEntity.GetUInt("f")==7)
	{
		if(thisEntity.GetPositionX()<-35*GetScale()) thisEntity.SetPositionX(SCREEN_SIZE_X+85*GetScale());
		thisEntity.AddToPositionX(UnitsPerSecond(-200));
		thisEntity.AddToAngle(UnitsPerSecond(100));
	}
	
	if(thisEntity.GetUInt("f")==8)
	{
		if(thisEntity.GetPositionX()<=thisEntity.GetFloat("limitL"))thisEntity.SetInt("up", -1);
		if(thisEntity.GetPositionX()>=thisEntity.GetFloat("limitR"))thisEntity.SetInt("up", 1);
		thisEntity.AddToPositionXY(UnitsPerSecond(-300)*V2_ONE*thisEntity.GetInt("up"));
		
	}
	
	if(thisEntity.GetUInt("f")==9)
	{
		if(thisEntity.GetPositionX()<=thisEntity.GetFloat("limitL"))thisEntity.SetInt("up", -1);
		if(thisEntity.GetPositionX()>=thisEntity.GetFloat("limitR"))thisEntity.SetInt("up", 1);
		thisEntity.AddToPositionXY(UnitsPerSecond(-300)*vector2(1, -1)*thisEntity.GetInt("up"));
		
	}

	if(thisEntity.GetUInt("f")==10)
	{
		if(thisEntity.GetFloat("radius")>GetScale()*280)thisEntity.SetInt("up", -1);
		if(thisEntity.GetFloat("radius")<GetScale()*160)thisEntity.SetInt("up", 1);
		thisEntity.AddToFloat("radius", UnitsPerSecond(70)*thisEntity.GetInt("up"));
		thisEntity.AddToAngle(UnitsPerSecond(100));
		thisEntity.SetPositionXY(getCirclePosition(thisEntity.GetVector2("center"),degreeToRadian(thisEntity.GetAngle()),thisEntity.GetFloat("radius")));
			
	}
	
	if(thisEntity.GetUInt("f")==11)
	{
		if(thisEntity.GetFloat("radius")>GetScale()*315)thisEntity.SetInt("up", -1);
		if(thisEntity.GetFloat("radius")<GetScale()*100)thisEntity.SetInt("up", 1);
		thisEntity.AddToFloat("radius", UnitsPerSecond(100)*thisEntity.GetInt("up"));
		thisEntity.AddToFloat("angle", UnitsPerSecond(100));
		thisEntity.SetAngle(360-thisEntity.GetFloat("angle"));
		thisEntity.SetPositionXY(getCirclePosition(thisEntity.GetVector2("center"),degreeToRadian(thisEntity.GetFloat("angle")),thisEntity.GetFloat("radius")));
	}

}