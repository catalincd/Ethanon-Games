class Jumper : GameObject
{
	ETHEntity@ thisEntity = null;
	ETHPhysicsController@ controller = null;
	vector2 pos = GetScreenSize() * vector2(0.5f, 0.75f);
	bool deleted = false;

	void create()
	{
		ETHEntity@ bmb;
		
		AddEntity("jumper.ent", vector3(pos, 0), @thisEntity);
		
		AddEntity("bamboo.ent", vector3(pos + vector2(0, 100 * GetScale()), 0), @bmb);
		
		bmb.SetUInt("b", 0);
		
		thisEntity.Scale(1.1f);
		
	//	thisEntity.SetAlpha(0.5f);
		
		thisEntity.SetUInt("char", 1);
		
		thisEntity.SetSprite(CURRENT_SPRITE_NAME);
		
		@controller = thisEntity.GetPhysicsController();
		
		controller.SetGravityScale(15.0);
		controller.SetDensity(10.0);
		deleted = false;
	}
	
	
	void update()
	{
		if(!GAME_OVER && !deleted)
		{
			thisEntity.SetPositionX(pos.x);
		
			checkTouch();
		}
		else
		{
			thisEntity.SetPositionX(9999);
		}
	}
	
	void checkTouch()
	{
		if(!GAME_OVER && !deleted)
		if(GetInputHandle().GetTouchState(0) == KS_HIT || GetInputHandle().GetKeyState(K_SPACE) == KS_HIT)
		{
			controller.SetLinearVelocity(vector2(0, -40));
			
			float touchPos = GetInputHandle().GetTouchPos(0).x;
			float halfScreen = GetScreenSize().x / 2;
			
			float x = (touchPos < halfScreen)? halfScreen - touchPos : touchPos - halfScreen;
			x /= halfScreen;
			if(touchPos < halfScreen) x *= -1;
			
			controller.SetAngularVelocity(x * 10);
		}
	}
	
	void destroy()
	{
		
		if(!deleted)
		{
			o_camera.shake();
			ETHEntity@ explo;
			AddEntity("explosion.ent", thisEntity.GetPosition(), explo);
			explo.Scale(2);
		}
		deleted = true;				
	}
	
	vector2 GetPositionXY()
	{
		if(GAME_OVER) return V2_ZERO;
		return thisEntity.GetPositionXY();
	}
	
	void resume()
	{
		SetBackgroundColor(backColor);
	}
	
	string getTag()
	{
		return "Jumper";
	}
}

string CURRENT_SPRITE_NAME;

Jumper o_jumper;