class Effector
{
	float rSpeed = UnitsPerSecond(2000);
	float lSpeed = UnitsPerSecond(-4000);
	uint background = 0;
	uint rotate = 1;
	InterpolationTimer@ m_sw = InterpolationTimer(300);
	bool up = true;
	uint lastChange;
	FloatColor[] rainbow = {FloatColor(paleRed),
							FloatColor(orange),
							FloatColor(yellow),
							FloatColor(green),
							FloatColor(blue), 
							FloatColor(indigo), 
							FloatColor(violet)};
	uint len = 7;
	uint m_current = 0;
	
	void rotateRight(ETHEntity@ thisEntity)
	{
		thisEntity.AddToAngle(lSpeed);
	}
	
	void setDefaultFilter()
	{
		m_sw.setFilter(@defaultFilter);
	}
	
	void update(ETHEntity@ thisEntity)
	{
		if(rotate == 2)
		{
			thisEntity.AddToAngle(UnitsPerSecond(-270));
		}
		
		if(rotate == 3)
		{
			thisEntity.AddToAngle(UnitsPerSecond(270));
		}
	}
	
	void update()
	{
		if(background==1)
		interpolateMainColorsRainbow();
	}
	
	void interpolateMainColorsRainbow()
	{
		//if(GetTime()-lastChange>150)
		
		if(m_sw.isOver())
		{
			m_current++;
			if(m_current==len)m_current=0;
			m_sw.reset(600);
			lastChange = GetTime();
		}
		uint m_next = (m_current+1)%len;
		FloatColor f = interpolate(rainbow[m_current], rainbow[m_next], m_sw.getBias());
		SetBackgroundColor(f.getUInt());
		m_sw.update();
	}
	
}

Effector g_effector;