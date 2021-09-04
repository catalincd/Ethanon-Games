class MainMenuBlock
{
	vector2 m_position;
	vector2 m_offset;
	vector2 m_targetOffset;
	vector2 m_relativeOffset;
	vector2 m_size;
	vector2 m_spriteSize;
	vector2 m_overlaySize;
	vector2 m_targetSpriteSize;
	
	vector2 eyesOffset;
	vector2 eyesOffsetLast;
	vector2 initOffset;
	vector2 targetOffset;
	uint lastTime, stride = 1000;
	float radius;
	float targetRadius;
	uint overlayColor;
	uint eyesColor;
	float m_offsetRatio = 1;
	uint m_color = COLOR_WHITE;
	PositionRandomizer m_bodyRandomizer;
	InterpolationTimer@ m_timer = InterpolationTimer(500);
	InterpolationTimer@ eyesTimer = InterpolationTimer(300);
	bool starting = false;
	bool looking = false;
	
	void setOffset(vector2 offset)
	{
		m_relativeOffset = offset;
	}
	//offset 70
	void setColor(uint color)
	{
		m_color = color;
	}
	
	void start(vector2 target)
	{
		m_targetOffset = target;
		starting = true;
		eyesOffsetLast = eyesOffset;
	}
	
	void create()
	{
		m_color = getColor();
		starting = false;
		
		m_spriteSize = vector2(256,256) * GetScale();
		m_overlaySize = vector2(512,512) * GetScale();
		m_targetSpriteSize = m_spriteSize / 4;
		m_size = m_spriteSize;
		m_position = GetScreenSize()/2;
		m_offsetRatio = 1;
		m_timer.reset(500);
		//m_timer.setFilter(@bounceOut);
		eyesTimer.reset(300);
		targetRadius = 70*GetScale();
		m_bodyRandomizer.create(0.1,1, 100*GetScale());
		radius = 10*GetScale();
		targetOffset = vector2(randF(1), randF(1)) * radius * 0.75;
	}
	
	void update(bool goingToStats)
	{
		m_bodyRandomizer.update();
		m_offset = m_bodyRandomizer.getOffset();
		
		
		if(starting)
		{
			m_timer.update();
			m_offsetRatio = 1-m_timer.getBias();
			m_relativeOffset = m_targetOffset*m_timer.getBias();
			m_size = interpolate(m_spriteSize, m_targetSpriteSize, m_timer.getBias());
			eyesOffset = interpolate(eyesOffsetLast, 0, m_timer.getBias());
		}
		
		
		vector2 m_finalPosition = m_position + m_offset*m_offsetRatio + m_relativeOffset;
		overlayColor = DRAWING_OVERLAYS? white : ARGB(uint(255.0f*(1-m_timer.getBias())), 255,255,255);
		eyesColor = DRAWING_EYES? white : ARGB(uint(255.0f*(1-m_timer.getBias())), 255,255,255);
		uint blockColor = m_color;
		if(goingToStats) 
		{	
			uint opacity = uint(255.0f*(1-m_timer.getBias()));
			overlayColor = ARGB(opacity, 255,255,255);
			eyesColor = ARGB(opacity, 255,255,255);
			blockColor =  ARGB(opacity, m_color);
		}
		DrawShapedSprite("entities/block_64.png", m_finalPosition,m_size, blockColor);
		
		
		DrawShapedSprite("sprites/block/eyes_contour.png", m_finalPosition,m_size, overlayColor);
		string overlay = GetOverlayNameFromIdx(CURRENT_OVERLAY);
		if(overlay != "")
			DrawShapedSprite(overlay, m_finalPosition,m_size * 2, overlayColor);
		
		//DrawShapedSprite("sprites/block/body6.png", m_finalPosition,m_size, m_color);
		
		
		updateEyes(m_finalPosition);
		//if(!DRAWING_OVERLAYS)
		//	if(starting)
		//		drawBlink(m_finalPosition);
	}
	
	void updateEyes(vector2 pos)
	{
		if(!starting){
		
		eyesTimer.update();
		eyesOffset = interpolate(initOffset, targetOffset, eyesTimer.getBias());
		if(!looking)
		{
			if(GetTime()-lastTime>stride)
			{
					looking = true;
					uint angle = rand(360);
					initOffset = targetOffset;
					targetOffset = rotate(randF(0, radius), degreeToRadian(angle));
					lastTime = GetTime();
					stride = rand(3,6)*500;
					eyesTimer.reset(300);
			}
		}
		else
		{
			
				if(eyesTimer.isOver())looking = false;
		}
		}
		
		DrawShapedSprite("sprites/block/eyes.png", pos+eyesOffset,m_size, eyesColor);
		
	}
	
	void drawBlink(vector2 pos)
	{
		float actualTargetRadius = interpolate(targetRadius, targetRadius/4, m_timer.getBias());
		DrawShapedSprite("sprites/block/blink.png", pos+vector2(0, actualTargetRadius)*m_timer.getBias(),m_size, m_color);
	}
}

uint getColor()
{
	return GetColorFromIdx(CURRENT_COLOR);
}

MainMenuBlock g_menuBlock;