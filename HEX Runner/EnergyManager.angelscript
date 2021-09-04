class EnergyManager : GameObject
{
	string getTag()
	{
		return "Energizer";
	}
	
	bool energize = false;
	bool starting = true;
	bool ending = false;
	ETHEntity@ trail = null;
	InterpolationTimer@ startTimer = InterpolationTimer(BOOST_TIME_DELAY_MS);
	InterpolationTimer@ runTimer = InterpolationTimer(BOOST_TIME_MS);
	InterpolationTimer@ endTimer = InterpolationTimer(BOOST_TIME_DELAY_MS);
	vector2 trailSize = 128;

	
	void create()
	{
		reset();
		trailSize = vector2(128,128) * GetScale();
	}
	
	void update()
	{	
		if(energize)
		{
			if(starting)
			{
				
				startTimer.update();
				if(startTimer.isOver())
					starting = false;
			}
			else if(ending)
			{
				endTimer.update();
				if(endTimer.isOver())
					reset();
			}
			else 
			{
				runTimer.update();
				if(runTimer.isOver())
				{
					ending = true;
					g_creator.explodeEntities();
					g_creator.added = 0;
				}
				
			}
			SetBackgroundColor(COL(interpolate(vector3(0,0,0), vector3(0.3f,0.3f,0.3f), getFactor())));
			
			float trailScale = g_block.thisEntity.GetScale().x / GetScale();
			DrawShapedSprite("sprites/trail.png", g_block.getPositionXY()-GetCameraPos(),trailSize*trailScale,ARGB(uint(getFactor() * 255.0f),GetColorFromIdx(CURRENT_COLOR)));
		}
		else
		{
			if(trail !is null)
				DeleteEntity(trail);
		}
	}
	
	void startBoost()
	{
		if(!energize)
		{
			energize = true;
			starting = true;
		}
		else
		{
			starting = false;
			ending = false;
			runTimer.reset(BOOST_TIME_MS);
		}
	}
	
	void reset()
	{
		energize = false;
		starting = true;
		ending = false;
		startTimer.reset(BOOST_TIME_DELAY_MS);
		runTimer.reset(BOOST_TIME_MS);
		endTimer.reset(BOOST_TIME_DELAY_MS);
	}
	
	bool isEnergyOn()
	{
		return energize;
	}
	
	float getFactor()
	{
		return energize? (ending? 1-endTimer.getBias() : startTimer.getBias()):0;
	}
	
	float getSpeedFactor()
	{
		return interpolate(1.0f, 1.2f, getFactor());
		//return 1;
	}
	
	void resume()
	{
		
	}
}

EnergyManager g_energyManager;

bool isEnergyOn()
{
	return g_energyManager.isEnergyOn();
}