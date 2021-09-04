class MainBlock : GameObject
{
	ETHEntity@ thisEntity = null;
	BlockAnimator m_animator;
	Swyper m_swyper;
	int pos = 0;
	float lastSpeed = 0;
	float SCREEN_SIZE_X2 = GetScreenSize().x/2;
	bool GOING = false;
	InterpolationTimer@ m_timer = InterpolationTimer(500);
	vector2 m_size;
	vector2 m_overlaySize;
	float screenY;


	MainBlock()
	{
	
	}
	
	string getTag()
	{
		return "MainBlock";
	}
	
	void create()
	{
	
		AddEntity("block.ent", vector3(GetScreenSize()/2, -1), 0, @thisEntity, "MainBlock.ent", 1);
		m_animator.create();
		m_timer.reset(500);
		m_swyper.create();
		GOING = false;
		pos = 0;
		m_animator.pos = 0;
		m_size = vector2(64,64) * GetScale();
		m_overlaySize = vector2(64,64) * GetScale() * 2;
		screenY = GetScreenSize().y*0.6;
	}
	
	void update()
	{
		if(!GAME_OVER)
		{
		
			if(!GOING)
			{
				m_timer.update();
				if(m_timer.isOver())
				{
					GOING = true;
					m_timer.reset(500);
				}
			}
		
			thisEntity.SetColor(COL(getColor()));
			if(GOING)
			{
				if(isEnergyOn())
				{
					float speedNow = interpolate(g_speedFactorManager.getSpeed(), 2500.0f, g_energyManager.getSpeedFactor());
					lastSpeed = UnitsPerSecond(speedNow);
				}
					else
						lastSpeed = UnitsPerSecond(g_speedFactorManager.getSpeed()) * g_pauseManager.getFactor() * m_runFactor;
					
				thisEntity.AddToPositionY(-lastSpeed);
				
			}
			m_swyper.update();
				if(m_swyper.getPos() != m_animator.pos)
				{
					m_animator.setTarget(m_swyper.getPos());
					g_soundManager.playSound(0);
				}
			m_animator.update(thisEntity);
			
				drawSprites();
			g_cameraManager.focus(thisEntity);
		}
		if(GAME_OVER && !BLOWN)
		{
			g_scoreManager.lastScore = GetScore();
			g_scoreManager.saveScore();
			g_cameraManager.focusGameOver();
			g_soundManager.playSound(1);
			ForwardCommand("vibrate 100");
			ETHEntity@ explosion;
			AddEntity("explosion_"+GetColorNameFromIdx(CURRENT_COLOR)+".ent", thisEntity.GetPosition(), @explosion);
			explosion.SetColor(thisEntity.GetColor());
			@thisEntity = DeleteEntity(thisEntity);
			BLOWN = true;
			
		}
		else if(GAME_OVER && BLOWN)
		{
			g_cameraManager.updateGameOver();
		}
		
		
		
	}
	
	vector2 getPositionXY()
	{
		return thisEntity.GetPositionXY();
	}
	
	void drawSprites()
	{
		//contour
		//overlay
		//eyes
		screenY = GetScreenSize().y*0.6;
		vector2 currentPos = vector2(thisEntity.GetPositionX(), screenY) + vector2(0,1);
		if(g_cameraManager.shaking())currentPos -= g_cameraManager.offset;
		float angle = thisEntity.GetAngle();
		if(DRAWING_EYES)
		DrawShapedSprite("sprites/block/eyes_contour.png", currentPos,m_size, white);
		string overlay = GetOverlayNameFromIdx(CURRENT_OVERLAY);
		
		float eScale = thisEntity.GetScale().x / GetScale();
		
		if(DRAWING_OVERLAYS)
		if(overlay != "")
			DrawShapedSprite(overlay, currentPos, m_overlaySize * eScale, white, angle);
		if(DRAWING_EYES)
		DrawShapedSprite("sprites/block/eyes.png", currentPos, m_size * eScale, white);
	}
	
	void resume()
	{
		
	}
	
}

float getLastSpeedUnitF()
{
	return g_block.lastSpeed;
}

vector2 getLastSpeedUnit()
{
	return vector2(0, getLastSpeedUnitF()/2);
}

float m_runFactor = 1.0f;

uint lastEnergy;

MainBlock g_block;

void ETHPreSolveContactCallback_MainBlock(ETHEntity@ thisEntity, ETHEntity@ other, vector2 pointA, vector2 pointB, vector2 normal)
{
	if(other.GetUInt("coin") == 0)
	{
		if(!TUTORIAL && !isEnergyOn() && GetTime() - lastEnergy > 500)
		{
			GAME_OVER = true;
			GAME_OVER_TIME = GetTime();
		}
		else
		other.SetUInt("delete",1);
	}
	else
	{
		other.SetUInt("add", 1);
	}
	DisableContact();
}