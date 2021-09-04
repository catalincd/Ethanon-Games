class Ratings
{
	float m_scale;
	string level_string;
	vector2 m_pos;
	float m_alpha;
	float levelBias;
	uint CURRENT_LEVEL;	
	bool fromGame = false;
	vector2 fillPos;
	vector2 fillSize;
	vector2 fillSize2;
	vector2 strokeSize;
	vector2 strokePos;
	vector2 levelTextPos;
	uint op = ARGB(100,255,255,255);
	uint blackk = ARGB(255,0,0,0);
	uint whitee = ARGB(255,255,255,255);
	uint alpha = 255;
	InterpolationTimer@ timer = InterpolationTimer(500);
	
	
	void create()
	{
		m_scale = 1;
		g_levelBar.create();
		
		
		timer.reset(500);
	}
	
	void reset()
	{
		timer.reset(500);
	}
	
	void update()
	{
		timer.update();
		g_touchManager.update();
		float offsetX = g_touchManager.getOffset();
		LimitMin(offsetX, -150);
		float initOffset = (1-timer.getBias())*150*GetScale();
		g_levelBar.draw(timer.getBias(), timer.getBias(), offsetX+initOffset, timer.isOver());
		
		
		
	}
}

Ratings ratings;