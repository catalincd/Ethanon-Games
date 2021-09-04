bool left = false;
bool right = false;
float speed = 0;
uint touches = 0;
float it = 15;
float maxSpeed = 300;
void ETHCallback_ball(ETHEntity@ thisEntity)
{
	ETHPhysicsController@ controller = thisEntity.GetPhysicsController();
	//float linearY = controller.GetLinearVelocity().y;
	//float linearX = controller.GetLinearVelocity().x;
	controller.SetLinearVelocity(vector2(0,-5*scale_factor));
	//thisEntity.AddToPositionY(UnitsPerSecond(-300));
	if(CONTROL_TYPE == 0)	
	{
		if(GO_LEFT)
		{
			left = true;right = false;
			speed = -maxSpeed;	
		}
		else if(left) {speed+=it; if(speed>0)speed = 0;}
		
		if(GO_RIGHT)
		{
			right = true;left = false;
			speed = maxSpeed;
		}
		else if(right) {speed-=it; if(speed<0)speed = 0;}
		thisEntity.AddToPositionX(UnitsPerSecond(speed)*scale_factor);
	}
	else
	{
		if(GetInputHandle().GetTouchState(0)==KS_DOWN)
		{
			float xpos = GetInputHandle().GetTouchPos(0).x;
			thisEntity.SetPositionX(xpos);
		}
	}

	if(thisEntity.GetPositionX()<0) thisEntity.SetPositionX(SCREEN_SIZE_X);
	if(thisEntity.GetPositionX()>SCREEN_SIZE_X) thisEntity.SetPositionX(0);
	if(GAME_OVER){
		AddEntity("exp"+g_gameManager.sufix+".ent", thisEntity.GetPosition(), 0);
		DeleteEntity(thisEntity);
		DeleteEntity(SeekEntity(thisEntity.GetInt("ballId")));
	}
	
	
	g_effector.update(thisEntity);
	
}


void ETHCallback_tray(ETHEntity@ thisEntity)
{
	ETHEntity@ ball;
	thisEntity.GetObject("ball", @ball);
	thisEntity.SetPositionXY(ball.GetPositionXY());
}


void ETHPreSolveContactCallback_ball(
	ETHEntity@ thisEntity,
	ETHEntity@ other,
	vector2 contactPointA,
	vector2 contactPointB,
	vector2 contactPointC)
{
	GAME_OVER = true;
	DisableContact();
	CAM_END_POS = GetCameraPos();
}

void ETHBeginContactCallback_ball(
	ETHEntity@ thisEntity,
	ETHEntity@ other,
	vector2 contactPointA,
	vector2 contactPointB,
	vector2 contactPointC)
{
touches++;	
}