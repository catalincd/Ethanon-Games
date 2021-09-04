class World : GameObject
{
	ETHEntity@ circle,platform;
	
	uint cubesNum;
	uint cubesAlive;
	uint cubesDead;
	float maxY = 1920;

	void create()
	{
		cubesNum = 0;
		cubesAlive = 0;
		cubesDead = 0;
	
		SetBackgroundColor(0xFFFFFFFF);

		vector2 circlePos = GetScreenSize() * vector2(0.5f, 0.85f);
		
		maxY = GetScreenSize().y * 1.1f;
		
		AddEntity("circle.ent", vector3(circlePos, 5.0f), 0.0f, @circle, "circle", 0.75f);
		AddEntity("platform.ent", vector3(circlePos + vector2(0, 0), 5.0f), 0.0f, @platform, "platform.ent", 1.2f);
		
		circle.ResolveJoints();
		ETHPhysicsController@ controller = platform.GetPhysicsController();
		
		SetGravity(vector2(0, 20));
		controller.SetDensity(5.0f);
		//controller.SetFriction(0.5f);
		
		circle.SetColor(vector3(1,0,0));
		platform.SetColor(vector3(0,0,0));
	}
	
	void update()
	{
		if(GetInputHandle().GetTouchState(0) == KS_HIT)
		{
			vector2 touchPos = GetInputHandle().GetTouchPos(0);
			addEntity(touchPos);
		}
		
		ETHPhysicsController@ controller = platform.GetPhysicsController();
		
		
		
		float vel = getVel(controller.GetAngularVelocity());
		o_ui.draw(vel, cubesNum, cubesAlive, cubesDead);
		
	}
	
	bool GameIsOver()
	{
		return abs(platform.GetAngle()) > 45;
	}
	
	bool blockDead(ETHEntity@ xent)
	{
		return xent.GetPositionY() > maxY;
	}
	
	void addEntity(vector2 pos)
	{
		cubesNum++;
		cubesAlive++;
		ETHEntity@ thisEntity;
		AddEntity("block.ent", vector3(pos, 5.0f), 0.0f, @thisEntity, "block", 0.5f);
		thisEntity.SetColor(vector3(0,0,0));
	}
	
	
	void resume()
	{
		SetBackgroundColor(white.getUInt());
	}
	
	string getTag()
	{
		return "World";
	}
}

World o_world;