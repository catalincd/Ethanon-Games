class Block
{
	ETHEntity@ entity;
	ETHEntity@ clone;
	ETHInput@ input = GetInputHandle();
	bool blown = false;
	bool added = false;
	vector2 cam_offset = vector2(0,0);
	vector2 cam_pos_prev = vector2(0,0);
	vector2 cam_pos_target = vector2(0,0);
	vector2 c = vector2(0,0);
	uint lastqqq;
	float angleTarget = 0;
	float offset_x;
	uint blowTime;
	vector2 cam_pos;
	float colorBias = 0;
	uint startTime;
	bool starting = false;
	bool trigger1 = true;
	InterpolationTimer@ endingTimer = InterpolationTimer(300);
	InterpolationTimer@ endingTimer2 = InterpolationTimer(300);
	InterpolationTimer@ endingTimer3 = InterpolationTimer(300);
	InterpolationTimer@ endingTimer4 = InterpolationTimer(300);
	bool idle = false;
	uint idleTime;
	
	ETHEntity@ add()
	{
		ETHEntity@ q;
		endingTimer.reset(300);
		endingTimer2.reset(300);
		endingTimer3.reset(300);
		endingTimer4.reset(300);
		AddEntity("blockMain.ent", vector3(g_scale.SCREEN_SIZE_2,1), 0, @q, "mainBlock.ent", 1);
		AddEntity("blockMain.ent", vector3(g_scale.SCREEN_SIZE_2+vector2(100*GetScale(),100*GetScale()),0), 0, @clone, "clone.ent", 1);
		//q.SetEmissiveColor(blue);
		//SetAmbientLight(vector3(0.8,0.8,0.8));
		@entity = q;
		return q;
	}
	
	ETHEntity@ add(vector2 pos)
	{
		ETHEntity@ q;
		endingTimer.reset(300);
		endingTimer2.reset(300);
		endingTimer3.reset(300);
		endingTimer4.reset(300);
		AddEntity("blockMain.ent", vector3(pos,0), 0, @q, "mainBlock.ent", 1);
		angleTarget = g_waypoint.getFirstAngle()-180;
		AddEntity("blockMain.ent", vector3(pos+vector2(100*GetScale(),100*GetScale()),0), 0, @clone, "clone.ent", 1);
		q.SetColor(greyV3);
		q.SetScale(0.01);
		clone.SetColor(greyV3);
		//q.SetEmissiveColor(blue);
		//SetAmbientLight(vector3(0.8,0.8,0.8));
		@entity = q;
		return q;
	}
	
	void create()
	{
		offset_x = 50*GetScale();
	}
	
	void updateAcc()
	{
		vector3 v = GetInputHandle().GetAccelerometerData();
		entity.SetAngle(-radianToDegree(atan2(-v.x , pythagoras(v.y, v.z))));	

	}
	
	bool rightSide()
	{
		return entity.GetPositionX()<g_scale.SCREEN_SIZE_X2;
	}
	
	void updateClone()
	{
		clone.SetAngle(entity.GetAngle());
		if(rightSide())
			clone.SetPositionXY(vector2(entity.GetPositionX()+g_scale.SCREEN_SIZE_X, entity.GetPositionY()));
		else
			clone.SetPositionXY(vector2(entity.GetPositionX()-g_scale.SCREEN_SIZE_X, entity.GetPositionY()));
		
	}
	
	void update()
	{
		if(idle)
		{
			if(GetTime()-idleTime<3000)
			{	
				uint secsLeft = 3 - ((GetTime()-idleTime)/1000);
				DrawCenteredText(entity.GetPositionXY()-GetCameraPos(), ""+secsLeft, "Verdana64.fnt", black);
			}
			else
			{
				g_timeManager.setFactor(1.0f);
				g_scoreManager.unlock();
				idle = false;
			}
		}
		if(!GAME_OVER)
		{
		
		g_waypoint.remove(entity);
		//AddLight(vector3(entity.GetPositionXY(),5), vector3(1,0,0), 1000, true);
		if(windows)
		{
			float angleSpeed = unitsPerSecond(300);
			if (input.KeyDown(K_RIGHT))
			{
				entity.AddToAngle(-angleSpeed);
			}

			if (input.KeyDown(K_LEFT))
			{
				entity.AddToAngle(angleSpeed);
			}
		}
		else	
		updateAcc();
		vector2 direction(0.0f,-1.0f);
		direction = rotate(direction, degreeToRadian(entity.GetAngle()));
		entity.AddToPositionXY(direction * unitsPerSecond(200));
		
		updateClone();
	
		SetCameraPos(cam_offset+vector2(0,entity.GetPositionY()-g_scale.SCREEN_SIZE_Y2));
	
		if(entity.GetPositionX()<-offset_x)
			entity.SetPositionX(g_scale.SCREEN_SIZE_X-offset_x);
		if(entity.GetPositionX()>g_scale.SCREEN_SIZE_X+offset_x)
			entity.SetPositionX(offset_x);
		
		}
		if(GAME_OVER && !blown)
		{
			g_menu.checkTut();
			g_scoreManager.set();
			GLOBAL_CURRENT = g_scoreManager.current;
			//print(""+GLOBAL_CURRENT);
			blown = true;
			blowTime = GetTime();
			cam_pos = GetCameraPos();
			AddEntity("explosion.ent", entity.GetPosition(), 0);
			AddEntity("explosion.ent", clone.GetPosition(), 0);
			DeleteEntity(entity);
			DeleteEntity(clone);
			idleChangeId = 0;
		}
		if(GAME_OVER && blown)
		{	
			cam_offset = vector2(0,0);
			
			if(GetTime()-blowTime<700)
			{
				float v_offset = GetScale()*25*smoothBothSides(1-min(1,float(GetTime()-blowTime)/700.0f));
				cam_offset = vector2(randF(0,1), randF(0,1)) * v_offset;
			}
			
			else
			if(GetTime()-blowTime<1200)
			{
				endingTimer.update();
				colorBias = endingTimer.getUnfilteredBias();
				g_timeManager.setFactor(interpolate(1,1.4, colorBias));
				cam_pos_prev = GetCameraPos();
				cam_pos_target = vector2(0,g_waypoint.getLast().y-g_scale.SCREEN_SIZE_Y2);
				//g_scale.setScale(interpolate(1, 0.75, endingTimer.getBias()));
			}
			else
			if(GetTime()-blowTime<1500)
			{
				if(trigger1)
				{
					trigger1 = false;
					lastqqq = g_scoreManager.getScore();
					
				}
				endingTimer2.update();
				SetBackgroundColor(COL(interpolate(blackV3,greyDarkV3,endingTimer2.getUnfilteredBias())));
				if(!added)
				{
					add(g_waypoint.getLast());
					added = true;
				}
				
				updateClone();
				entity.SetScale(endingTimer2.getUnfilteredBias());
				entity.SetAngle(interpolate(0,angleTarget,endingTimer2.getUnfilteredBias()));
				cam_pos = interpolate(cam_pos_prev,cam_pos_target,endingTimer2.getUnfilteredBias());
			}
			else 
			if(GetTime()-blowTime<1800)
			{
				
				endingTimer3.update();
				//DrawCenteredText("TOUCH TO PLAY", "Verdana64.fnt", ARGB(endingTimer3.getUnfilteredBias(),whiteF));
				g_menu.update(endingTimer3.getUnfilteredBias());
				g_layer.set(1-endingTimer3.getUnfilteredBias());
			}
			else
			{
				g_menu.update(colorBias);
				
				
				endingTimer4.update();
				updateClone();
				g_waypoint.follow(entity);
				g_waypoint.setFactor(endingTimer4.getUnfilteredBias());
				cam_pos = vector2(0,entity.GetPositionY()-g_scale.SCREEN_SIZE_Y2);
				if(!starting)
				{
						if(g_menu.starting())
						{
							starting = true;
							startTime = GetTime();
							endingTimer.reset();
							g_scoreManager.reset();
							g_scoreManager.lock();
							
						}
						
				}
				else
				{
					if(added)
					{
						added = false;
						idle = true;
						idleTime = GetTime();
					}
					
					
					endingTimer.update();
					colorBias = 1-endingTimer.getUnfilteredBias();
					g_layer.set(endingTimer.getUnfilteredBias());
					g_timeManager.setFactor(interpolate(1.4,0, colorBias));
					entity.SetColor(interpolate(greyV3,whiteV3, 1-colorBias));
					SetBackgroundColor(COL(interpolate(greyDarkV3,blackV3,1-colorBias)));
					if(endingTimer.isOver())
					{
						GAME_OVER = false;
						starting = false;
						blown = false;
						added = false;
						trigger1 = true;
						endingTimer.reset();
						endingTimer4.reset();
						endingTimer3.reset();
						endingTimer2.reset();
						g_timeManager.setFactor(0.0f);
						RESPAWN_TIME = GetTime();
						entity.SetColor(whiteV3);
						entity.SetScale(1);
						SetBackgroundColor(black);
						
					}
				}
			}
			
			SetCameraPos(cam_offset+cam_pos);
		}
	}
	
}




void ETHPreSolveContactCallback_mainBlock(
	ETHEntity@ thisEntity,
	ETHEntity@ other,
	vector2 contactPointA,
	vector2 contactPointB,
	vector2 contactNormal)
{
	if(GetTime()-RESPAWN_TIME>2000)
	{
		GAME_OVER = true;
		
	}
	DisableContact();
}

void ETHPreSolveContactCallback_clone(
	ETHEntity@ thisEntity,
	ETHEntity@ other,
	vector2 contactPointA,
	vector2 contactPointB,
	vector2 contactNormal)
{
	if(GetTime()-RESPAWN_TIME>2000)
	{
		GAME_OVER = true;
		
	}
	DisableContact();
}

uint RESPAWN_TIME = 0;
uint GLOBAL_CURRENT = 0;

Block g_block;