class ScaleManager
{
	vector2 SCREEN_SIZE = GetScreenSize();
	vector2 SCREEN_SIZE_2 = GetScreenSize()/2;
	float SCREEN_SIZE_X = GetScreenSize().x;
	float SCREEN_SIZE_Y = GetScreenSize().y;
	float SCREEN_SIZE_X2 = SCREEN_SIZE_2.x;
	float SCREEN_SIZE_Y2 = SCREEN_SIZE_2.y;
	float m_currentEntityScale = 1.0f;
	float minScale = 0.75f;
	float ENT_RADIUS;
	float light;
	float ENT_JITTER;
	vector2 textPos1;
	float xOffset;
	
	void create()
	{
		light = 150*GetScale();
		ENT_RADIUS = 35*GetScale();
		ENT_JITTER = 35*GetScale();
		textPos1 = SCREEN_SIZE_2 - (vector2(0,100)*GetScale());
		xOffset = 10*GetScale();
	}
	
	void setScale(float sc)
	{
		m_currentEntityScale = sc;
	}
	
	void update(ETHEntityArray &allEnt)
	{
		//if(m_currentEntityScale != 1.0f && m_currentEntityScale != minScale)
		//{
			const uint t = allEnt.Size();
		
			for(uint i=0;i<t;i++)
			{
				allEnt[i].SetScale(m_currentEntityScale);
			}
		//}
	}
}

ScaleManager g_scale;