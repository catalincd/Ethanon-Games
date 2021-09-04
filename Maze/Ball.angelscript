class Ball
{
	vector2 pos;
	ETHEntity@ ent,nextBall;
	float ratio = 9.8f * tiltRatio;
	vector2 next;
	
	void create()
	{
		ratio = 9.8f * tiltRatio;
		g_tap.create();
	}
	
	void update()
	{
		g_tap.update();
		
		vector2 current = g_tap.getDirection() * 4 * SENSITIVITY;
		
		
		ETHPhysicsController@ controller = ent.GetPhysicsController();
		
		if(!Alert.showing)
			controller.SetLinearVelocity(current);
		else
			controller.SetLinearVelocity(V2_ZERO);
	}
	
	void resume()
	{
		g_tap.resume();
	}
	
	void add(vector2 _pos, vector2 _next = 0)
	{
		deleteOld();
		
		float xScale = (cellScale * 2.0f + 1.0f) / 3.0f;
		
		AddEntity("ball.ent", vector3(_pos, 5), @ent);
		ent.SetColor(ballColor.getVector3());
		ent.SetScale(0.75f);
		ent.Scale(xScale);
		pos = _pos;
		
		AddEntity("target.ent", vector3(_next, 5), 0, @nextBall, "sensor.ent", 0.75f);
		nextBall.SetColor(nextBallColor.getVector3());
		nextBall.SetInt("id", ent.GetID());
		nextBall.Scale(xScale);
	}
	
	void deleteOld()
	{
		if(ent !is null && ent.IsAlive()) DeleteEntity(ent);
		if(nextBall !is null && nextBall.IsAlive()) DeleteEntity(nextBall);
	}
	
	vector2 getAcceleration()
	{
		vector3 v = input.Acceleration();
		float x = v.x / ratio;
		float y = v.y / ratio;
		return UnitsPerSecond(300) * vector2(x,y);
	}
	
	vector2 getAccelerationX()
	{
		if(WINDOWS)
		{
			vector2 dir = V2_ZERO;
			if(GetInputHandle().GetKeyState(K_LEFT) == KS_DOWN)dir += vector2(-1, 0);
			if(GetInputHandle().GetKeyState(K_RIGHT) == KS_DOWN)dir += vector2(1, 0);
			if(GetInputHandle().GetKeyState(K_UP) == KS_DOWN)dir += vector2(0, -1);
			if(GetInputHandle().GetKeyState(K_DOWN) == KS_DOWN)dir += vector2(0, 1);
			return dir * 9.8f;
		}
		
		return getAcceleration();
	}
	
}

void ETHPreSolveContactCallback_sensor(ETHEntity@ thisEntity, ETHEntity@ other, vector2 a, vector2 b, vector2 c)
{
	if(other.GetID() == thisEntity.GetInt("id"))
		thisEntity.SetUInt("e", thisEntity.GetUInt("e") + 1);
	DisableContact();
}

void ETHCallback_sensor(ETHEntity@ thisEntity)
{
	if(thisEntity.GetUInt("e") == 1)
		nextLevel();
}

Ball g_ball;