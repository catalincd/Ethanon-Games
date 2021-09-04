class BlockAnimator
{
	int lastPos = 0;
	int pos = 0;
	float m_currentBias = 0;
	int m_sign = 1;
	InterpolationTimer@ timer = InterpolationTimer(200, true);
	float SCREEN_SIZE_X2;
	float FACTOR;

	void setTarget(int npos)
	{
		if(timer.isOver())
		{
			timer.reset(200);
			lastPos = pos;
			pos = npos;
		}
	}
	
	void create()
	{
		timer.m_elapsedTime = 201;
		//timer.setFilter(@elastic);
		SCREEN_SIZE_X2 = GetScreenSize().x/2;
		FACTOR = 256*GetScale();
	}

	void update(ETHEntity@ thisEntity)
	{
		timer.update();
		m_currentBias = timer.getUnfilteredBias();
		float m_unfilteredPos = interpolate(float(lastPos), float(pos), smoothEnd(m_currentBias));
		//thisEntity.SetAngle(m_unfilteredPos * -90.0f);
		
		//thisEntity.SetAngle(timer.getUnfilteredBias() * 360);
		
		thisEntity.SetScale(halfBias(m_currentBias));
		
		thisEntity.SetPositionX(m_unfilteredPos * FACTOR + SCREEN_SIZE_X2);
		
	}
}

float halfBias(float v)
{
	float d = abs(v - 0.5f);
	return 0.5f + d;
}